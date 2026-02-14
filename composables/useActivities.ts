export const useActivities = () => {
  const supabase = useSupabase()

  // Fetch all activities
  const fetchActivities = async (includeUnpublished = true) => {
    let query = supabase
      .from('activities')
      .select('*')
      .order('date', { ascending: false })

    if (!includeUnpublished) {
      query = query.eq('is_published', true)
    }

    const { data, error } = await query

    if (error) throw error
    return data
  }

  // Fetch single activity by ID
  const fetchActivity = async (id: string) => {
    const { data, error } = await supabase
      .from('activities')
      .select('*')
      .eq('id', id)
      .single()

    if (error) throw error
    return data
  }

  // Create new activity
  const createActivity = async (activity: any) => {
    const { data, error } = await supabase
      .from('activities')
      .insert([activity])
      .select()
      .single()

    if (error) throw error
    return data
  }

  // Update activity
  const updateActivity = async (id: string, activity: any) => {
    const { data, error } = await supabase
      .from('activities')
      .update(activity)
      .eq('id', id)
      .select()
      .single()

    if (error) throw error
    return data
  }

  // Delete activity
  const deleteActivity = async (id: string) => {
    const { error } = await supabase
      .from('activities')
      .delete()
      .eq('id', id)

    if (error) throw error
  }

  // Upload activity image
  const uploadActivityImage = async (file: File, activityId: string) => {
    const fileExt = file.name.split('.').pop()
    const fileName = `${activityId}-${Date.now()}.${fileExt}`
    const filePath = `activities/${fileName}`

    const { error: uploadError } = await supabase.storage
      .from('photos')
      .upload(filePath, file)

    if (uploadError) throw uploadError

    // Get public URL
    const { data } = supabase.storage
      .from('photos')
      .getPublicUrl(filePath)

    return data.publicUrl
  }

  // Delete activity image
  const deleteActivityImage = async (imageUrl: string) => {
    // Extract path from URL
    const urlParts = imageUrl.split('/photos/')
    if (urlParts.length < 2) return

    const filePath = urlParts[1]
    if (!filePath) return

    const { error } = await supabase.storage
      .from('photos')
      .remove([filePath])

    if (error) throw error
  }

  return {
    fetchActivities,
    fetchActivity,
    createActivity,
    updateActivity,
    deleteActivity,
    uploadActivityImage,
    deleteActivityImage
  }
}
