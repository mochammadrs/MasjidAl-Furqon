export const useOfficials = () => {
  const supabase = useSupabase()

  // Fetch all officials
  const fetchOfficials = async (includeInactive = false) => {
    let query = supabase
      .from('officials')
      .select('*')
      .order('display_order', { ascending: true })

    if (!includeInactive) {
      query = query.eq('is_active', true)
    }

    const { data, error } = await query

    if (error) throw error
    return data
  }

  // Fetch single official by ID
  const fetchOfficial = async (id: string) => {
    const { data, error } = await supabase
      .from('officials')
      .select('*')
      .eq('id', id)
      .single()

    if (error) throw error
    return data
  }

  // Create new official
  const createOfficial = async (official: any) => {
    const { data, error } = await supabase
      .from('officials')
      .insert([official])
      .select()
      .single()

    if (error) throw error
    return data
  }

  // Update official
  const updateOfficial = async (id: string, official: any) => {
    const { data, error } = await supabase
      .from('officials')
      .update(official)
      .eq('id', id)
      .select()
      .single()

    if (error) throw error
    return data
  }

  // Delete official
  const deleteOfficial = async (id: string) => {
    const { error } = await supabase
      .from('officials')
      .delete()
      .eq('id', id)

    if (error) throw error
  }

  // Upload official photo
  const uploadOfficialPhoto = async (file: File, officialId: string) => {
    const fileExt = file.name.split('.').pop()
    const fileName = `${officialId}-${Date.now()}.${fileExt}`
    const filePath = `officials/${fileName}`

    const { error: uploadError } = await supabase.storage
      .from('photos')
      .upload(filePath, file)

    if (uploadError) throw uploadError

    // Get public URL
    const { data } = supabase.storage
      .from('photos')
      .getPublicUrl(filePath)

    const publicUrl = data.publicUrl

    // Update official record with photo URL
    const { error: updateError } = await supabase
      .from('officials')
      .update({ photo_url: publicUrl })
      .eq('id', officialId)

    if (updateError) throw updateError

    return publicUrl
  }

  // Delete official photo
  const deleteOfficialPhoto = async (photoUrl: string) => {
    // Extract path from URL
    const urlParts = photoUrl.split('/photos/')
    if (urlParts.length < 2) return

    const filePath = urlParts[1]
    if (!filePath) return

    const { error } = await supabase.storage
      .from('photos')
      .remove([filePath])

    if (error) throw error
  }

  return {
    fetchOfficials,
    fetchOfficial,
    createOfficial,
    updateOfficial,
    deleteOfficial,
    uploadOfficialPhoto,
    deleteOfficialPhoto
  }
}
