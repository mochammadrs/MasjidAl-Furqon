export const useSettings = () => {
  const supabase = useSupabase()

  // Fetch all settings
  const fetchSettings = async () => {
    const { data, error } = await supabase
      .from('settings')
      .select('*')

    if (error) throw error
    return data
  }

  // Fetch single setting by key
  const fetchSetting = async (key: string) => {
    const { data, error } = await supabase
      .from('settings')
      .select('*')
      .eq('key', key)
      .single()

    if (error) throw error
    return data
  }

  // Fetch settings as key-value object
  const fetchSettingsObject = async () => {
    const { data, error } = await supabase
      .from('settings')
      .select('*')

    if (error) throw error

    // Convert array to object { key: value }
    const settingsObj: Record<string, string> = {}
    data?.forEach(setting => {
      settingsObj[setting.key] = setting.value
    })

    return settingsObj
  }

  // Update single setting
  const updateSetting = async (key: string, value: string) => {
    const { data, error } = await supabase
      .from('settings')
      .update({ value, updated_at: new Date().toISOString() })
      .eq('key', key)
      .select()
      .single()

    if (error) throw error
    return data
  }

  // Update multiple settings at once
  const updateSettings = async (settings: Record<string, string>) => {
    const updates = Object.entries(settings).map(([key, value]) => ({
      key,
      value,
      updated_at: new Date().toISOString()
    }))

    // Update each setting
    const promises = updates.map(update =>
      supabase
        .from('settings')
        .update({ value: update.value, updated_at: update.updated_at })
        .eq('key', update.key)
    )

    const results = await Promise.all(promises)
    
    // Check for errors
    const errors = results.filter(r => r.error)
    if (errors.length > 0) {
      throw new Error('Failed to update some settings')
    }

    return true
  }

  // Create new setting
  const createSetting = async (key: string, value: string, description?: string) => {
    const { data, error } = await supabase
      .from('settings')
      .insert([{ key, value, description }])
      .select()
      .single()

    if (error) throw error
    return data
  }

  // Upsert setting (update if exists, create if not)
  const upsertSetting = async (key: string, value: string, description?: string) => {
    const { data, error } = await supabase
      .from('settings')
      .upsert({ key, value, description }, { onConflict: 'key' })
      .select()
      .single()

    if (error) throw error
    return data
  }

  return {
    fetchSettings,
    fetchSetting,
    fetchSettingsObject,
    updateSetting,
    updateSettings,
    createSetting,
    upsertSetting
  }
}
