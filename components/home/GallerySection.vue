<template>
  <section id="galeri" class="py-20 md:py-28 bg-gradient-to-b from-gray-50/50 to-white">
    <div class="container mx-auto px-6">
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
          Dokumentasi kegiatan dan momen berharga di Masjid Al-Furqon
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

    <!-- Lightbox Modal -->
    <div
      v-if="lightboxItem"
      @click="closeLightbox"
      class="fixed inset-0 bg-black/95 z-50 flex items-center justify-center p-4"
    >
      <button
        @click="closeLightbox"
        class="absolute top-6 right-6 text-white text-4xl hover:text-masjid-gold transition-colors z-10"
      >
        ✕
      </button>

      <div @click.stop class="max-w-6xl w-full">
        <!-- Image -->
        <div class="mb-6">
          <img
            :src="lightboxItem.image_url"
            :alt="lightboxItem.title"
            class="w-full h-auto max-h-[80vh] object-contain rounded-lg"
            loading="eager"
            decoding="async"
          />
        </div>

        <!-- Info -->
        <div class="text-center text-white">
          <div class="mb-3">
            <span :class="getCategoryColor(lightboxItem.category)" class="px-3 py-1 rounded-full text-xs font-medium">
              {{ getCategoryLabel(lightboxItem.category) }}
            </span>
          </div>
          <h3 class="text-2xl font-serif font-bold mb-2">
            {{ lightboxItem.title }}
          </h3>
          <p v-if="lightboxItem.description" class="text-white/80">
            {{ lightboxItem.description }}
          </p>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { PhImage } from '@phosphor-icons/vue'

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

const showMore = () => {
  displayLimit.value += 8
}

const openLightbox = (item: any) => {
  lightboxItem.value = item
  document.body.style.overflow = 'hidden'
}

const closeLightbox = () => {
  lightboxItem.value = null
  document.body.style.overflow = 'auto'
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
})

onBeforeUnmount(() => {
  document.body.style.overflow = 'auto'
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
</style>
