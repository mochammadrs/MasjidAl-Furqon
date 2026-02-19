<template>
  <section id="galeri" class="relative py-20 md:py-28 overflow-hidden">
    <!-- Premium Background -->
    <div class="absolute inset-0 bg-gradient-to-b from-gray-50/50 via-white to-gray-50/30"></div>
    
    <!-- Decorative Ambient Elements -->
    <div class="absolute top-1/3 -left-40 w-96 h-96 bg-gradient-to-br from-pink-500/5 to-transparent rounded-full blur-3xl animate-pulse-slow"></div>
    <div class="absolute bottom-1/4 -right-40 w-80 h-80 bg-gradient-to-br from-cyan-500/5 to-transparent rounded-full blur-3xl animate-pulse-slow" style="animation-delay: 2.5s;"></div>
    
    <!-- Camera Pattern Overlay -->
    <div class="absolute inset-0 opacity-[0.015]" style="background-image: url('data:image/svg+xml,%3Csvg width=\'80\' height=\'80\' viewBox=\'0 0 80 80\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Cg fill=\'%23000000\' fill-opacity=\'1\'%3E%3Cpath d=\'M20 15h40v10H20zM15 30h50v35H15z\'/%3E%3Ccircle cx=\'40\' cy=\'47.5\' r=\'10\'/%3E%3C/g%3E%3C/svg%3E'); background-size: 100px 100px;"></div>
    
    <div class="container mx-auto px-6 relative z-10">
      <!-- Section Header -->
      <div class="text-center max-w-3xl mx-auto mb-16">
        <div class="inline-flex items-center gap-2 px-4 py-2 bg-white border border-masjid-gold/20 rounded-full mb-5 shadow-sm">
          <PhImage :size="18" class="text-masjid-gold" />
          <span class="text-sm font-semibold text-masjid-dark tracking-wide">Galeri Kegiatan</span>
        </div>
        <h2 class="text-3xl md:text-4xl lg:text-5xl font-serif font-bold text-masjid-dark mb-4 leading-tight">
          Galeri Kegiatan
        </h2>
        <p class="text-lg text-masjid-text-muted leading-relaxed">
          Dokumentasi kegiatan dan momen berharga di Masjid Jamie Al-Furqon
        </p>
      </div>

      <!-- Filter Tabs -->
      <div class="flex justify-center gap-3 mb-14 flex-wrap">
        <button
          v-for="cat in categories"
          :key="cat.value"
          @click="selectedCategory = cat.value"
          :class="[
            'px-5 py-2.5 rounded-xl text-sm font-semibold transition-all duration-300',
            selectedCategory === cat.value
              ? 'bg-masjid-gold text-white shadow-lg scale-105 border border-masjid-gold'
              : 'bg-white text-masjid-dark hover:bg-gray-50 border border-gray-200 hover:border-masjid-gold/30'
          ]"
        >
          {{ cat.label }}
        </button>
      </div>

      <!-- Loading State -->
      <div v-if="loading" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
        <SkeletonGalleryImageSkeleton v-for="i in 8" :key="i" />
      </div>

      <!-- Empty State -->
      <div v-else-if="filteredGallery.length === 0" class="text-center py-16">
        <div class="inline-flex items-center justify-center w-24 h-24 rounded-2xl bg-gray-100 mb-6">
          <PhImage :size="48" class="text-gray-400" />
        </div>
        <p class="text-lg text-masjid-text-muted">Belum ada foto di galeri</p>
      </div>

      <!-- Gallery Grid -->
      <div v-else class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5">
        <div
          v-for="item in displayedGallery"
          :key="item.id"
          @click="openLightbox(item)"
          class="group relative aspect-square rounded-2xl overflow-hidden cursor-pointer border border-gray-200 hover:border-masjid-gold/40 hover:shadow-2xl transition-all duration-500"
        >
          <!-- Image -->
          <img
            v-if="item.image_url"
            :src="item.image_url"
            :alt="item.title"
            class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-700"
            loading="lazy"
            decoding="async"
          />
          <div v-else class="w-full h-full bg-gradient-to-br from-gray-100 to-gray-50 flex items-center justify-center">
            <PhImage :size="64" class="text-gray-300" />
          </div>

          <!-- Overlay -->
          <div class="absolute inset-0 bg-gradient-to-t from-black/90 via-black/50 to-transparent opacity-0 group-hover:opacity-100 transition-all duration-500">
            <div class="absolute bottom-0 left-0 right-0 p-5">
              <div class="mb-3">
                <span :class="getCategoryColor(item.category)" class="px-3 py-1.5 rounded-lg text-xs font-bold shadow-lg">
                  {{ getCategoryLabel(item.category).toUpperCase() }}
                </span>
              </div>
              <h3 class="text-white font-serif font-bold text-base mb-2 line-clamp-2 leading-tight">
                {{ item.title }}
              </h3>
              <p v-if="item.description" class="text-white/90 text-xs line-clamp-2 leading-relaxed">
                {{ item.description }}
              </p>
            </div>
          </div>
        </div>
      </div>

      <!-- Show More Button -->
      <div v-if="filteredGallery.length > displayLimit" class="text-center mt-14">
        <button
          @click="showMore"
          class="px-8 py-3.5 bg-white hover:bg-masjid-gold hover:text-white border-2 border-masjid-gold text-masjid-dark font-semibold rounded-xl transition-all duration-300 shadow-md hover:shadow-xl"
        >
          Lihat Lebih Banyak ({{ filteredGallery.length - displayLimit }} foto)
        </button>
      </div>
    </div>

    <!-- Lightbox Modal Premium -->
    <Transition
      enter-active-class="transition-opacity duration-300"
      enter-from-class="opacity-0"
      enter-to-class="opacity-100"
      leave-active-class="transition-opacity duration-200"
      leave-from-class="opacity-100"
      leave-to-class="opacity-0"
    >
      <div
        v-if="lightboxItem"
        @click="closeLightbox"
        class="fixed inset-0 z-[9999] flex items-center justify-center p-4 overflow-hidden"
      >
        <!-- Glassmorphism Background with Gradients -->
        <div class="absolute inset-0 bg-gradient-to-br from-black via-gray-900 to-black">
          <div class="absolute inset-0 backdrop-blur-3xl bg-black/40"></div>
          <!-- Ambient Glows -->
          <div class="absolute top-1/4 left-1/4 w-96 h-96 bg-masjid-gold/10 rounded-full blur-3xl"></div>
          <div class="absolute bottom-1/4 right-1/4 w-96 h-96 bg-blue-500/10 rounded-full blur-3xl"></div>
        </div>

        <div @click.stop class="relative max-w-6xl w-full h-full flex flex-col items-center justify-center">
          <!-- Top Bar: Close Button + Counter -->
          <div class="absolute top-4 left-0 right-0 z-10 flex items-center justify-between px-4 sm:px-6">
            <!-- Image Counter -->
            <div class="flex items-center gap-2 px-4 py-2 bg-white/10 backdrop-blur-md border border-white/20 rounded-full">
              <PhImage :size="18" class="text-masjid-gold" />
              <span class="text-white font-semibold text-sm">
                {{ currentImageIndex + 1 }} / {{ filteredGallery.length }}
              </span>
            </div>

            <!-- Close Button -->
            <button
              @click="closeLightbox"
              class="group w-12 h-12 flex items-center justify-center bg-white/10 hover:bg-red-500/80 backdrop-blur-md border border-white/20 hover:border-red-500 rounded-full transition-all duration-300"
              aria-label="Close lightbox"
            >
              <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>

          <!-- Main Content -->
          <div class="flex items-center justify-center gap-4 w-full max-h-[80vh]">
            <!-- Previous Button -->
            <button
              v-if="currentImageIndex > 0"
              @click="navigateImage(-1)"
              class="group flex-shrink-0 w-14 h-14 flex items-center justify-center bg-white/10 hover:bg-masjid-gold/80 backdrop-blur-md border border-white/20 hover:border-masjid-gold rounded-full transition-all duration-300 hover:scale-110 hover:shadow-lg hover:shadow-masjid-gold/30"
              aria-label="Previous image"
            >
              <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M15 19l-7-7 7-7" />
              </svg>
            </button>

            <!-- Image Container -->
            <div class="flex-1 max-w-4xl">
              <img
                :src="lightboxItem.image_url"
                :alt="lightboxItem.title"
                class="w-full h-auto max-h-[60vh] sm:max-h-[70vh] object-contain rounded-2xl shadow-2xl"
                loading="eager"
                decoding="async"
              />
            </div>

            <!-- Next Button -->
            <button
              v-if="currentImageIndex < filteredGallery.length - 1"
              @click="navigateImage(1)"
              class="group flex-shrink-0 w-14 h-14 flex items-center justify-center bg-white/10 hover:bg-masjid-gold/80 backdrop-blur-md border border-white/20 hover:border-masjid-gold rounded-full transition-all duration-300 hover:scale-110 hover:shadow-lg hover:shadow-masjid-gold/30"
              aria-label="Next image"
            >
              <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M9 5l7 7-7 7" />
              </svg>
            </button>
          </div>

          <!-- Info Card -->
          <div class="absolute bottom-6 left-6 right-6 max-w-4xl mx-auto">
            <div class="bg-white/10 backdrop-blur-xl border border-white/20 rounded-2xl p-4 sm:p-6 shadow-2xl">
              <div class="flex items-start gap-4">
                <div class="flex-1">
                  <div class="flex items-center gap-3 mb-3">
                    <span :class="getCategoryColor(lightboxItem.category)" class="px-3 py-1.5 rounded-lg text-xs font-bold shadow-md">
                      {{ getCategoryLabel(lightboxItem.category).toUpperCase() }}
                    </span>
                    <div class="flex items-center gap-2 text-white/70 text-sm">
                      <PhCalendar :size="16" />
                      <span>{{ formatDate(lightboxItem.created_at) }}</span>
                    </div>
                  </div>
                  <h3 class="text-xl sm:text-2xl font-serif font-bold text-white mb-2">
                    {{ lightboxItem.title }}
                  </h3>
                  <p v-if="lightboxItem.description" class="text-sm sm:text-base text-white/80 leading-relaxed">
                    {{ lightboxItem.description }}
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </Transition>
  </section>
</template>

<script setup lang="ts">
import { PhImage, PhCalendar } from '@phosphor-icons/vue'

const { fetchGalleryItems } = useGallery()

const gallery = ref<any[]>([])
const loading = ref(true)
const selectedCategory = ref<string>('')
const displayLimit = ref(12)
const lightboxItem = ref<any>(null)

const categories = [
  { value: '', label: 'Semua' },
  { value: 'kegiatan', label: 'Kegiatan' },
  { value: 'masjid', label: 'Masjid' },
  { value: 'jamaah', label: 'Jamaah' },
  { value: 'lainnya', label: 'Lainnya' }
]

const filteredGallery = computed(() => {
  if (!selectedCategory.value) return gallery.value
  return gallery.value.filter(item => item.category === selectedCategory.value)
})

const displayedGallery = computed(() => {
  return filteredGallery.value.slice(0, displayLimit.value)
})

// Current image index in filtered gallery
const currentImageIndex = computed(() => {
  if (!lightboxItem.value) return -1
  return filteredGallery.value.findIndex(item => item.id === lightboxItem.value.id)
})

const getCategoryLabel = (category: string) => {
  const cat = categories.find(c => c.value === category)
  return cat?.label || category
}

const getCategoryColor = (category: string) => {
  const colors: Record<string, string> = {
    kegiatan: 'bg-blue-500 text-white',
    masjid: 'bg-green-500 text-white',
    jamaah: 'bg-purple-500 text-white',
    lainnya: 'bg-gray-500 text-white'
  }
  return colors[category] || colors.lainnya
}

const formatDate = (dateString: string) => {
  const date = new Date(dateString)
  return new Intl.DateTimeFormat('id-ID', {
    day: 'numeric',
    month: 'long',
    year: 'numeric'
  }).format(date)
}

const showMore = () => {
  displayLimit.value += 8
}

const openLightbox = (item: any) => {
  lightboxItem.value = item
  document.body.style.overflow = 'hidden'
}

// Navigate between images (prev/next)
const navigateImage = (direction: number) => {
  const newIndex = currentImageIndex.value + direction
  if (newIndex >= 0 && newIndex < filteredGallery.value.length) {
    lightboxItem.value = filteredGallery.value[newIndex]
  }
}

const closeLightbox = () => {
  lightboxItem.value = null
  document.body.style.overflow = ''
}

// Keyboard handlers (ESC + Arrow keys)
const handleKeydown = (e: KeyboardEvent) => {
  if (!lightboxItem.value) return
  
  if (e.key === 'Escape') {
    closeLightbox()
  } else if (e.key === 'ArrowLeft') {
    navigateImage(-1)
  } else if (e.key === 'ArrowRight') {
    navigateImage(1)
  }
}

const loadGallery = async () => {
  loading.value = true
  try {
    const data = await fetchGalleryItems()
    gallery.value = data || []
  } catch (error) {
    console.error('Error loading gallery:', error)
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  loadGallery()
  window.addEventListener('keydown', handleKeydown)
})

onBeforeUnmount(() => {
  document.body.style.overflow = ''
  window.removeEventListener('keydown', handleKeydown)
})

// Watch route changes and close lightbox
const route = useRoute()
watch(() => route.path, () => {
  if (lightboxItem.value) {
    closeLightbox()
  }
})
</script>

<style scoped>
.line-clamp-1 {
  display: -webkit-box;
  -webkit-line-clamp: 1;
  line-clamp: 1;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

@keyframes pulse-slow {
  0%, 100% {
    opacity: 0.3;
    transform: scale(1);
  }
  50% {
    opacity: 0.5;
    transform: scale(1.12);
  }
}

.animate-pulse-slow {
  animation: pulse-slow 20s ease-in-out infinite;
}
</style>
