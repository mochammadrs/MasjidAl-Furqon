<template>
  <div class="space-y-6">
    <!-- Stats Cards -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
      <div
        v-for="(stat, index) in stats"
        :key="index"
        class="bg-white rounded-xl p-6 shadow-sm border border-gray-200 hover:shadow-lg hover:-translate-y-1 transition-all duration-300"
      >
        <div class="flex items-center justify-between mb-4">
          <div :class="`w-12 h-12 rounded-lg flex items-center justify-center ${stat.iconBg}`">
            <component :is="stat.icon" :size="24" :class="stat.iconColor" />
          </div>
          <span :class="`px-3 py-1 rounded-full text-xs font-semibold ${stat.badgeColor}`">
            {{ stat.badge }}
          </span>
        </div>
        <div class="text-3xl font-serif font-bold text-masjid-dark mb-1">
          {{ stat.value }}
        </div>
        <div class="text-sm text-masjid-text-muted mb-3">
          {{ stat.label }}
        </div>
      </div>
    </div>

    <!-- Recent Activities & Quick Actions -->
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <!-- Recent Activities -->
      <div class="lg:col-span-2 bg-white rounded-xl p-6 shadow-sm border border-gray-200">
        <div class="flex items-center justify-between mb-6">
          <h3 class="text-lg font-serif font-bold text-masjid-dark">
            Kegiatan Terbaru
          </h3>
          <NuxtLink
            to="/admin/activities"
            class="text-sm text-masjid-gold hover:text-masjid-dark transition-colors font-medium"
          >
            Lihat Semua
          </NuxtLink>
        </div>
        <div v-if="loading" class="flex justify-center py-12">
          <div class="animate-spin rounded-full h-10 w-10 border-b-2 border-masjid-gold"></div>
        </div>
        <div v-else-if="recentActivities.length === 0" class="text-center py-12">
          <PhCalendar :size="48" class="text-gray-300 mx-auto mb-3" />
          <p class="text-masjid-text-muted">Belum ada kegiatan. Klik "Tambah Kegiatan" untuk menambah.</p>
        </div>
        <div v-else>
          <div class="overflow-x-auto">
            <table class="w-full">
              <thead>
                <tr class="border-b border-gray-200">
                  <th class="text-left py-3 px-2 text-xs font-semibold text-masjid-text-muted uppercase">Kegiatan</th>
                  <th class="text-left py-3 px-2 text-xs font-semibold text-masjid-text-muted uppercase">Jadwal</th>
                  <th class="text-left py-3 px-2 text-xs font-semibold text-masjid-text-muted uppercase">Pembimbing</th>
                  <th class="text-left py-3 px-2 text-xs font-semibold text-masjid-text-muted uppercase">Kategori</th>
                </tr>
              </thead>
              <tbody>
                <tr
                  v-for="activity in recentActivities.slice(0, 5)"
                  :key="activity.id"
                  class="border-b border-gray-100 hover:bg-gray-50 transition-colors"
                >
                  <td class="py-4 px-2">
                    <p class="font-medium text-masjid-dark">{{ activity.title }}</p>
                  </td>
                  <td class="py-4 px-2 text-sm text-masjid-text-muted">
                    {{ formatDate(activity.date) }}
                  </td>
                  <td class="py-4 px-2 text-sm text-masjid-text-muted">
                    {{ activity.speaker || '-' }}
                  </td>
                  <td class="py-4 px-2">
                    <span :class="`px-2 py-1 rounded text-xs font-medium ${getCategoryColor(activity.category)}`">
                      {{ activity.category }}
                    </span>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- Quick Actions -->
      <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-200">
        <h3 class="text-lg font-serif font-bold text-masjid-dark mb-6">
          Aksi Cepat
        </h3>
        <div class="space-y-3">
          <NuxtLink
            v-for="action in quickActions"
            :key="action.path"
            :to="action.path"
            :class="`flex items-center gap-3 p-4 rounded-lg transition-all ${action.color}`"
          >
            <div :class="`w-10 h-10 rounded-lg flex items-center justify-center ${action.iconBg}`">
              <component :is="action.icon" :size="20" class="text-white" />
            </div>
            <span class="text-sm font-medium text-masjid-dark">{{ action.label }}</span>
          </NuxtLink>
        </div>
      </div>
    </div>

    <!-- Donation Progress -->
    <div class="bg-gradient-to-br from-masjid-gold/10 via-masjid-gold-light/10 to-transparent rounded-xl p-6 shadow-sm border border-masjid-gold/20">
      <div class="flex items-center gap-3 mb-6">
        <div class="w-12 h-12 bg-masjid-gold/20 rounded-lg flex items-center justify-center">
          <PhCurrencyCircleDollar :size="24" class="text-masjid-gold" />
        </div>
        <div>
          <h3 class="text-lg font-serif font-bold text-masjid-dark">Progress Donasi Pembangunan</h3>
          <p class="text-sm text-masjid-text-muted">Target: Rp {{ donationTarget.toLocaleString('id-ID') }}</p>
        </div>
      </div>
      <div class="space-y-4">
        <div class="flex items-baseline gap-2">
          <p class="text-4xl font-serif font-bold bg-gradient-to-r from-masjid-gold to-masjid-dark bg-clip-text text-transparent">
            {{ donationPercentage.toFixed(0) }}%
          </p>
          <p class="text-sm text-masjid-text-muted">tercapai</p>
        </div>
        <div class="relative w-full bg-gray-200 rounded-full h-4 overflow-hidden">
          <div
            class="absolute top-0 left-0 h-full bg-gradient-to-r from-masjid-gold to-masjid-dark rounded-full transition-all duration-700 shadow-md"
            :style="{ width: `${donationPercentage}%` }"
          ></div>
        </div>
        <div class="flex justify-between items-center pt-2">
          <div>
            <p class="text-xs text-masjid-text-muted mb-1">Terkumpul</p>
            <p class="text-xl font-serif font-bold text-masjid-dark">
              Rp {{ donationCollected.toLocaleString('id-ID') }}
            </p>
          </div>
          <NuxtLink
            to="/admin/settings"
            class="px-4 py-2 bg-masjid-gold hover:bg-masjid-dark text-white text-sm font-medium rounded-lg transition-colors inline-flex items-center gap-2"
          >
            <PhGear :size="16" />
            <span>Update</span>
          </NuxtLink>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PhCalendar, PhUsers, PhImage, PhCurrencyCircleDollar, PhPlus, PhUserPlus, PhUpload, PhGear } from '@phosphor-icons/vue'

definePageMeta({
  layout: 'admin',
  middleware: 'auth'
})

const supabase = useSupabase()
const loading = ref(true)
const recentActivities = ref<any[]>([])
const donationCollected = ref(45000000)
const donationTarget = ref(150000000)

const stats = ref([
  { 
    icon: PhCalendar, 
    value: '0', 
    label: 'Total Kegiatan', 
    badge: 'Aktif', 
    badgeColor: 'bg-blue-500 text-white',
    iconBg: 'bg-blue-100',
    iconColor: 'text-blue-500'
  },
  { 
    icon: PhUsers, 
    value: '4', 
    label: 'Pengurus Aktif', 
    badge: 'Daftar', 
    badgeColor: 'bg-orange-500 text-white',
    iconBg: 'bg-orange-100',
    iconColor: 'text-orange-500'
  },
  { 
    icon: PhImage, 
    value: '0', 
    label: 'Foto Galeri', 
    badge: 'Upload', 
    badgeColor: 'bg-pink-500 text-white',
    iconBg: 'bg-pink-100',
    iconColor: 'text-pink-500'
  },
  { 
    icon: PhCurrencyCircleDollar, 
    value: '67%', 
    label: 'Progress Donasi', 
    badge: 'Update', 
    badgeColor: 'bg-yellow-500 text-white',
    iconBg: 'bg-yellow-100',
    iconColor: 'text-yellow-500'
  }
])

const quickActions = [
  { 
    icon: PhPlus, 
    label: 'Tambah Kegiatan', 
    path: '/admin/activities/new',
    color: 'bg-blue-50 hover:bg-blue-100 border border-blue-200',
    iconBg: 'bg-blue-500'
  },
  { 
    icon: PhUserPlus, 
    label: 'Tambah Pengurus', 
    path: '/admin/officials/new',
    color: 'bg-orange-50 hover:bg-orange-100 border border-orange-200',
    iconBg: 'bg-orange-500'
  },
  { 
    icon: PhUpload, 
    label: 'Upload Foto', 
    path: '/admin/gallery/new',
    color: 'bg-pink-50 hover:bg-pink-100 border border-pink-200',
    iconBg: 'bg-pink-500'
  },
  { 
    icon: PhGear, 
    label: 'Pengaturan', 
    path: '/admin/settings',
    color: 'bg-gray-50 hover:bg-gray-100 border border-gray-200',
    iconBg: 'bg-gray-500'
  }
]

const donationPercentage = computed(() => {
  return (donationCollected.value / donationTarget.value) * 100
})

const formatDate = (dateString: string) => {
  const date = new Date(dateString)
  return new Intl.DateTimeFormat('id-ID', {
    day: 'numeric',
    month: 'long',
    year: 'numeric'
  }).format(date)
}

const getCategoryColor = (category: string) => {
  const colors: Record<string, string> = {
    kajian: 'bg-blue-100 text-blue-700',
    sosial: 'bg-green-100 text-green-700',
    pendidikan: 'bg-purple-100 text-purple-700',
    ramadhan: 'bg-yellow-100 text-yellow-700',
    lainnya: 'bg-gray-100 text-gray-700'
  }
  return colors[category] || colors.lainnya
}

// Fetch data
const fetchData = async () => {
  loading.value = true
  try {
    // Fetch activities
    const { data: activities } = await supabase
      .from('activities')
      .select('*')
      .order('date', { ascending: false })
    
    if (activities) {
      recentActivities.value = activities
      if (stats.value[0]) {
        stats.value[0].value = activities.length.toString()
      }
    }

    // Fetch officials count
    const { data: officials } = await supabase
      .from('officials')
      .select('*', { count: 'exact' })
      .eq('is_active', true)
    
    if (officials) {
      if (stats.value[1]) {
        stats.value[1].value = officials.length.toString()
      }
    }

    // Fetch gallery count
    const { data: gallery } = await supabase
      .from('gallery')
      .select('*', { count: 'exact' })
    
    if (gallery) {
      if (stats.value[2]) {
        stats.value[2].value = gallery.length.toString()
      }
    }

    // Fetch settings for donation
    const { data: settings } = await supabase
      .from('settings')
      .select('*')
      .in('key', ['donation_collected', 'donation_target'])
    
    if (settings) {
      const collected = settings.find(s => s.key === 'donation_collected')
      const target = settings.find(s => s.key === 'donation_target')
      
      if (collected) donationCollected.value = parseInt(collected.value)
      if (target) donationTarget.value = parseInt(target.value)
      
      if (stats.value[3]) {
        stats.value[3].value = `${donationPercentage.value.toFixed(0)}%`
      }
    }
  } catch (error) {
    console.error('Error fetching data:', error)
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchData()
})
</script>
