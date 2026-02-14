export default defineNuxtRouteMiddleware(async (to) => {
  const supabase = useSupabase()
  
  // Check if user is authenticated
  const { data: { user } } = await supabase.auth.getUser()

  // If not authenticated and trying to access admin pages (except login)
  if (!user && to.path.startsWith('/admin') && to.path !== '/admin/login') {
    return navigateTo('/admin/login')
  }

  // If authenticated and trying to access login page, redirect to dashboard
  if (user && to.path === '/admin/login') {
    return navigateTo('/admin/dashboard')
  }
})
