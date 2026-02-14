import type { User } from '@supabase/supabase-js'

export interface AdminProfile {
  id: string
  user_id: string
  display_name: string
  created_at: string
  updated_at: string
}

export const useAuth = () => {
  const supabase = useSupabase()
  const user = useState<User | null>('user', () => null)
  const profile = useState<AdminProfile | null>('admin-profile', () => null)
  const loading = useState<boolean>('auth-loading', () => true)

  // Check current session
  const checkAuth = async () => {
    loading.value = true
    try {
      const { data: { user: currentUser } } = await supabase.auth.getUser()
      user.value = currentUser
      
      // Fetch admin profile if user exists
      if (currentUser) {
        const { data: profileData } = await supabase
          .from('admin_profiles')
          .select('*')
          .eq('user_id', currentUser.id)
          .single()
        
        profile.value = profileData
      } else {
        profile.value = null
      }
    } catch (error) {
      console.error('Auth check error:', error)
      user.value = null
      profile.value = null
    } finally {
      loading.value = false
    }
  }

  // Login with email & password
  const login = async (email: string, password: string) => {
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password
    })

    if (error) throw error
    
    user.value = data.user
    
    // Fetch admin profile
    if (data.user) {
      const { data: profileData } = await supabase
        .from('admin_profiles')
        .select('*')
        .eq('user_id', data.user.id)
        .single()
      
      profile.value = profileData
    }
    
    return data
  }

  // Logout
  const logout = async () => {
    const { error } = await supabase.auth.signOut()
    if (error) throw error
    
    user.value = null
    profile.value = null
    await navigateTo('/admin/login')
  }

  // Register new admin with display name
  const register = async (email: string, password: string, displayName: string) => {
    // 1. Create auth user
    const { data, error } = await supabase.auth.signUp({
      email,
      password
    })

    if (error) throw error
    
    // 2. Create admin profile
    if (data.user) {
      const { error: profileError } = await supabase
        .from('admin_profiles')
        .insert({
          user_id: data.user.id,
          display_name: displayName
        })
      
      if (profileError) throw profileError
    }
    
    return data
  }

  return {
    user,
    profile,
    loading,
    checkAuth,
    login,
    logout,
    register,
    isAuthenticated: computed(() => !!user.value),
    displayName: computed(() => profile.value?.display_name || user.value?.email || 'Admin')
  }
}
