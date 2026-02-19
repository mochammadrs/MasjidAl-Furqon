<template>
  <section id="kegiatan" class="relative py-16 md:py-24 overflow-hidden">
    <!-- Premium Background -->
    <div class="absolute inset-0 bg-gradient-to-b from-gray-50 via-white to-gray-50/50"></div>
    
    <!-- Decorative Ambient Elements -->
    <div class="absolute -top-40 right-1/4 w-80 h-80 bg-gradient-to-br from-masjid-gold/5 to-transparent rounded-full blur-3xl animate-pulse-slow"></div>
    <div class="absolute -bottom-40 left-1/4 w-96 h-96 bg-gradient-to-br from-blue-500/5 to-transparent rounded-full blur-3xl animate-pulse-slow" style="animation-delay: 3s;"></div>
    
    <!-- Grid Pattern Overlay -->
    <div class="absolute inset-0 opacity-[0.015]" style="background-image: linear-gradient(rgba(0,0,0,.05) 1px, transparent 1px), linear-gradient(90deg, rgba(0,0,0,.05) 1px, transparent 1px); background-size: 40px 40px;"></div>
    
    <div class="container mx-auto px-4 lg:px-8 relative z-10">
      <!-- Section Header -->
      <div class="max-w-3xl mx-auto text-center mb-14">
        <div class="inline-flex items-center gap-2 px-4 py-2 bg-white border border-masjid-gold/20 rounded-full mb-5 shadow-sm">
          <PhCalendar :size="18" class="text-masjid-gold" />
          <span class="text-sm font-semibold text-masjid-dark tracking-wide">Kegiatan Masjid</span>
        </div>
        <h2 class="text-3xl md:text-4xl lg:text-5xl font-serif font-bold text-masjid-dark mb-4 leading-tight">
          Kegiatan Terbaru
        </h2>
        <p class="text-lg text-masjid-text-muted leading-relaxed">
          Ikuti berbagai kegiatan kajian, sosial, dan pendidikan di Masjid Jamie Al-Furqon
        </p>
      </div>

      <!-- Loading State -->
      <div v-if="loading" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <SkeletonActivityCardSkeleton v-for="i in 3" :key="i" />
      </div>

      <!-- Activities Grid -->
      <div v-else-if="activities.length > 0" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        <div
          v-for="activity in activities"
          :key="activity.id"
          class="group bg-white rounded-2xl overflow-hidden border border-gray-100 hover:border-masjid-gold/30 hover:shadow-xl transition-all duration-500"
        >
          <!-- Image -->
          <div class="relative h-52 bg-gradient-to-br from-masjid-dark/90 to-masjid-gold/60 overflow-hidden">
            <img
              v-if="activity.image_url"
              :src="activity.image_url"
              :alt="activity.title"
              class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-700"
              loading="lazy"
              decoding="async"
            />
            <div v-else class="w-full h-full flex items-center justify-center bg-gradient-to-br from-masjid-gold/20 to-masjid-dark/5">
              <PhCalendar :size="64" class="text-masjid-gold/40" />
            </div>
            
            <!-- Category Badge -->
            <div class="absolute top-4 right-4">
              <span :class="`px-3 py-1.5 rounded-lg text-xs font-bold shadow-lg ${getCategoryColor(activity.category)}`">
                {{ activity.category.toUpperCase() }}
              </span>
            </div>
          </div>

          <!-- Content -->
          <div class="p-6">
            <h3 class="text-xl font-serif font-bold text-masjid-dark mb-3 line-clamp-2 group-hover:text-masjid-gold transition-colors">
              {{ activity.title }}
            </h3>
            
            <p class="text-sm text-masjid-text-muted mb-5 line-clamp-3 leading-relaxed">
              {{ activity.description }}
            </p>

            <!-- Date, Time, Location -->
            <div class="space-y-2.5 border-t border-gray-100 pt-4">
              <div class="flex items-center gap-3 text-sm text-masjid-text-muted">
                <PhCalendar :size="16" class="text-masjid-gold flex-shrink-0" />
                <span class="font-medium">{{ formatDate(activity.date) }}</span>
              </div>
              <div v-if="activity.time" class="flex items-center gap-3 text-sm text-masjid-text-muted">
                <PhClock :size="16" class="text-masjid-gold flex-shrink-0" />
                <span>{{ activity.time }}</span>
              </div>
              <div class="flex items-center gap-3 text-sm text-masjid-text-muted">
                <PhMapPin :size="16" class="text-masjid-gold flex-shrink-0" />
                <span>{{ activity.location }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Empty State -->
      <div v-else class="text-center py-16">
        <div class="inline-flex items-center justify-center w-24 h-24 rounded-2xl bg-gray-100 mb-6">
          <PhCalendar :size="48" class="text-gray-400" />
        </div>
        <p class="text-lg text-masjid-text-muted">Belum ada kegiatan terjadwal</p>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { PhCalendar, PhClock, PhMapPin } from '@phosphor-icons/vue'

const { fetchActivities } = useActivities()

const activities = ref<any[]>([])
const loading = ref(true)

const formatDate = (dateString: string) => {
  const date = new Date(dateString)
  return new Intl.DateTimeFormat('id-ID', {
    weekday: 'long',
    day: 'numeric',
    month: 'long',
    year: 'numeric'
  }).format(date)
}

const getCategoryColor = (category: string) => {
  const colors: Record<string, string> = {
    kajian: 'bg-blue-500 text-white',
    sosial: 'bg-green-500 text-white',
    pendidikan: 'bg-purple-500 text-white',
    ramadhan: 'bg-yellow-500 text-white',
    lainnya: 'bg-gray-500 text-white'
  }
  return colors[category] || colors.lainnya
}

const loadActivities = async () => {
  loading.value = true
  try {
    const allActivities = await fetchActivities(false) // Only published
    // Show only upcoming activities or latest 6
    activities.value = allActivities
      .filter((a: any) => new Date(a.date) >= new Date() || true) // Show all for now
      .slice(0, 6)
  } catch (error) {
    console.error('Error loading activities:', error)
    activities.value = []
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  loadActivities()
})
</script>
<style scoped>
@keyframes pulse-slow {
  0%, 100% {
    opacity: 0.3;
    transform: scale(1);
  }
  50% {
    opacity: 0.5;
    transform: scale(1.1);
  }
}

.animate-pulse-slow {
  animation: pulse-slow 18s ease-in-out infinite;
}
</style>