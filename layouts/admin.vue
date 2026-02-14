<template>
  <div class="min-h-screen bg-gray-50">
    <!-- Admin Sidebar -->
    <aside class="fixed top-0 left-0 w-64 h-screen bg-masjid-dark text-white shadow-xl z-50 flex flex-col">
      <!-- Logo -->
      <div class="flex items-center gap-3 p-6 border-b border-masjid-gold/20 flex-shrink-0">
        <div class="w-10 h-10 bg-white rounded-lg shadow-md flex items-center justify-center overflow-hidden">
          <img src="/images/logo-masjid.png" alt="Logo Masjid Al-Furqon" class="w-full h-full object-cover" />
        </div>
        <div>
          <h2 class="font-serif font-bold text-lg">Admin Panel</h2>
          <p class="text-xs text-gray-400">Masjid Al-Furqon</p>
        </div>
      </div>

      <!-- Navigation Menu -->
      <nav class="p-4 space-y-2 flex-1 overflow-y-auto">
        <NuxtLink
          v-for="item in menuItems"
          :key="item.path"
          :to="item.path"
          class="flex items-center gap-3 px-4 py-3 rounded-lg transition-colors hover:bg-masjid-gold/20"
          :class="{ 'bg-masjid-gold/30': isActive(item.path) }"
        >
          <component :is="item.icon" :size="20" />
          <span class="font-medium">{{ item.label }}</span>
        </NuxtLink>
      </nav>

      <!-- Logout Button (Always visible at bottom) -->
      <div class="p-4 border-t border-masjid-gold/20 flex-shrink-0">
        <button
          @click="handleLogout"
          class="w-full flex items-center gap-3 px-4 py-3 rounded-lg transition-colors hover:bg-red-500/20 text-red-300 hover:text-red-200"
        >
          <PhSignOut :size="20" />
          <span class="font-medium">Keluar</span>
        </button>
      </div>
    </aside>

    <!-- Main Content Area -->
    <div class="ml-64">
      <!-- Top Bar -->
      <header class="bg-white shadow-sm border-b border-gray-200 sticky top-0 z-40">
        <div class="px-6 py-4 flex items-center justify-between">
          <div>
            <h1 class="text-2xl font-serif font-bold text-masjid-dark">{{ pageTitle }}</h1>
            <p class="text-sm text-masjid-text-muted">{{ pageDescription }}</p>
          </div>
          <div class="flex items-center gap-3">
            <div class="text-right">
              <p class="text-sm font-medium text-masjid-dark">{{ displayName }}</p>
              <p class="text-xs text-masjid-text-muted">Administrator</p>
            </div>
            <div class="w-10 h-10 bg-masjid-gold rounded-full flex items-center justify-center">
              <span class="text-white font-bold">{{ userInitial }}</span>
            </div>
          </div>
        </div>
      </header>

      <!-- Page Content -->
      <main class="p-6">
        <slot />
      </main>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PhChartLine, PhCalendar, PhUsers, PhImage, PhGear, PhSignOut } from '@phosphor-icons/vue'

const route = useRoute()
const { user, profile, logout, displayName } = useAuth()

const menuItems = [
  { path: '/admin/dashboard', icon: PhChartLine, label: 'Dashboard' },
  { path: '/admin/activities', icon: PhCalendar, label: 'Kegiatan' },
  { path: '/admin/officials', icon: PhUsers, label: 'Pengurus' },
  { path: '/admin/gallery', icon: PhImage, label: 'Galeri' },
  { path: '/admin/settings', icon: PhGear, label: 'Pengaturan' }
]

const isActive = (path: string) => {
  return route.path.startsWith(path)
}

const pageTitle = computed(() => {
  const item = menuItems.find(m => isActive(m.path))
  return item?.label || 'Dashboard'
})

const pageDescription = computed(() => {
  const descriptions: Record<string, string> = {
    '/admin/dashboard': 'Ringkasan statistik dan aktivitas',
    '/admin/activities': 'Kelola kegiatan masjid',
    '/admin/officials': 'Kelola pengurus masjid',
    '/admin/gallery': 'Kelola galeri foto',
    '/admin/settings': 'Pengaturan website'
  }
  return descriptions[route.path] || ''
})

const userEmail = computed(() => user.value?.email || '')
const userInitial = computed(() => {
  // Get initial from display name first, fallback to email
  const name = displayName.value
  if (name && name !== user.value?.email) {
    return name.charAt(0).toUpperCase()
  }
  return userEmail.value.charAt(0).toUpperCase()
})

const handleLogout = async () => {
  if (confirm('Apakah Anda yakin ingin keluar?')) {
    await logout()
  }
}

// Auto-check auth on mount
onMounted(async () => {
  const { checkAuth } = useAuth()
  await checkAuth()
})
</script>
