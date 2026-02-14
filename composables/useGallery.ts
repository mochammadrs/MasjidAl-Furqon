export const useGallery = () => {
  const supabase = useSupabase()

  // Fetch all gallery items or by category
  const fetchGalleryItems = async (category?: string) => {
    let query = supabase
      .from('gallery')
      .select('*')
      .order('created_at', { ascending: false })

    if (category) {
      query = query.eq('category', category)
    }

    const { data, error } = await query

    if (error) throw error
    return data
  }

  // Fetch single gallery item
  const fetchGalleryItem = async (id: string) => {
    const { data, error } = await supabase
      .from('gallery')
      .select('*')
      .eq('id', id)
      .single()

    if (error) throw error
    return data
  }

  // Create new gallery item
  const createGalleryItem = async (item: {
    title: string
    description?: string | null
    category: string
    uploaded_by?: string | null
  }) => {
    const { data, error } = await supabase
      .from('gallery')
      .insert([item])
      .select()
      .single()

    if (error) throw error
    return data
  }

  // Update gallery item
  const updateGalleryItem = async (id: string, item: {
    title?: string
    description?: string | null
    category?: string
  }) => {
    const { data, error } = await supabase
      .from('gallery')
      .update(item)
      .eq('id', id)
      .select()
      .single()

    if (error) throw error
    return data
  }

  // Delete gallery item
  const deleteGalleryItem = async (id: string) => {
    const { error } = await supabase
      .from('gallery')
      .delete()
      .eq('id', id)

    if (error) throw error
  }

  // Upload gallery photo
  const uploadGalleryPhoto = async (file: File, galleryId: string) => {
    const fileExt = file.name.split('.').pop()
    const fileName = `${galleryId}-${Date.now()}.${fileExt}`
    const filePath = `gallery/${fileName}`

    const { error: uploadError } = await supabase.storage
      .from('photos')
      .upload(filePath, file)

    if (uploadError) throw uploadError

    // Get public URL
    const { data } = supabase.storage
      .from('photos')
      .getPublicUrl(filePath)

    const publicUrl = data.publicUrl

    // Update gallery record with image URL
    const { error: updateError } = await supabase
      .from('gallery')
      .update({ image_url: publicUrl })
      .eq('id', galleryId)

    if (updateError) throw updateError

    return publicUrl
  }

  // Delete gallery photo
  const deleteGalleryPhoto = async (photoUrl: string) => {
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
    fetchGalleryItems,
    fetchGalleryItem,
    createGalleryItem,
    updateGalleryItem,
    deleteGalleryItem,
    uploadGalleryPhoto,
    deleteGalleryPhoto
  }
}
