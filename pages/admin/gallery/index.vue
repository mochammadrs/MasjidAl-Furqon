<template>
  <NuxtLayout name="admin">
    <div class="space-y-6">
      <!-- Add Button -->
    <div class="flex justify-end">
      <NuxtLink
        to="/admin/gallery/new"
        class="px-4 py-2.5 bg-masjid-gold hover:bg-masjid-dark text-white font-semibold rounded-lg transition-all duration-300 inline-flex items-center gap-2 shadow-md hover:shadow-lg"
      >
        <PhPlus :size="18" />
        <span>Upload Foto</span>
      </NuxtLink>
    </div>

    <!-- Filter Kategori -->
    <div class="bg-white rounded-xl p-4 shadow-sm border border-gray-200">
      <div class="flex items-center gap-3 flex-wrap">
        <span class="text-sm font-medium text-masjid-dark">Filter:</span>
        <button
          v-for="cat in categories"
          :key="cat.value"
          @click="selectedCategory = cat.value"
          :class="[
            'px-4 py-2 rounded-lg text-sm font-medium transition-colors',
            selectedCategory === cat.value
              ? 'bg-masjid-gold text-white'
              : 'bg-gray-100 text-masjid-dark hover:bg-gray-200'
          ]"
        >
          {{ cat.label }}
        </button>
      </div>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="flex justify-center py-12">
      <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-masjid-gold"></div>
    </div>

    <!-- Empty State -->
    <div v-else-if="filteredGallery.length === 0" class="bg-white rounded-xl shadow-sm border border-gray-200 p-16 text-center">
      <div class="inline-flex items-center justify-center w-20 h-20 rounded-2xl bg-gray-100 mb-5">
        <PhImage :size="40" class="text-gray-400" />
      </div>
      <h3 class="text-xl font-serif font-bold text-masjid-dark mb-3">
        Belum Ada Foto
      </h3>
      <p class="text-masjid-text-muted mb-6">
        {{ selectedCategory ? `Belum ada foto di kategori "${categoryLabel}"` : 'Mulai upload foto dokumentasi kegiatan masjid' }}
      </p>
      <NuxtLink
        to="/admin/gallery/new"
        class="inline-block px-6 py-3 bg-masjid-gold hover:bg-masjid-dark text-white font-medium rounded-lg transition-colors"
      >
        Upload Foto Pertama
      </NuxtLink>
    </div>

    <!-- Gallery Grid -->
    <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
      <div
        v-for="item in filteredGallery"
        :key="item.id"
        class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden hover:shadow-lg transition-shadow group"
      >
        <!-- Image -->
        <div class="relative aspect-[4/3] bg-gray-100 overflow-hidden">
          <img
            v-if="item.image_url"
            :src="item.image_url"
            :alt="item.title"
            class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
          />
          <div v-else class="w-full h-full flex items-center justify-center">
            <PhImage :size="64" class="text-gray-300" />
          </div>
          
          <!-- Category Badge -->
          <div class="absolute top-3 left-3">
            <span :class="getCategoryColor(item.category)" class="px-3 py-1 rounded-full text-xs font-medium">
              {{ getCategoryLabel(item.category) }}
            </span>
          </div>
        </div>

        <!-- Info -->
        <div class="p-4">
          <h3 class="font-serif font-bold text-masjid-dark mb-2 line-clamp-2">
            {{ item.title }}
          </h3>
          <p v-if="item.description" class="text-sm text-masjid-text-muted mb-4 line-clamp-2">
            {{ item.description }}
          </p>
          <p class="text-xs text-masjid-text-muted mb-4">
            {{ formatDate(item.created_at) }}
          </p>

          <!-- Actions -->
          <div class="flex gap-2">
            <NuxtLink
              :to="`/admin/gallery/edit/${item.id}`"
              class="flex-1 px-4 py-2 bg-blue-50 hover:bg-blue-100 text-blue-700 text-sm font-medium rounded-lg transition-colors text-center"
            >
              Edit
            </NuxtLink>
            <button
              @click="confirmDelete(item)"
              class="flex-1 px-4 py-2 bg-red-50 hover:bg-red-100 text-red-700 text-sm font-medium rounded-lg transition-colors"
            >
              Hapus
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div
      v-if="showDeleteModal"
      class="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4"
      @click.self="showDeleteModal = false"
    >
      <div class="bg-white rounded-xl p-6 max-w-md w-full shadow-2xl">
        <div class="text-center mb-6">
          <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-red-100 mb-4">
            <PhWarning :size="32" class="text-red-600" />
          </div>
          <h3 class="text-xl font-serif font-bold text-masjid-dark mb-2">
            Hapus Foto?
          </h3>
          <p class="text-masjid-text-muted">
            Foto "<strong>{{ itemToDelete?.title }}</strong>" akan dihapus permanen. Tindakan ini tidak bisa dibatalkan.
          </p>
        </div>
        
        <div class="flex gap-3">
          <button
            @click="showDeleteModal = false"
            class="flex-1 px-6 py-3 bg-gray-100 hover:bg-gray-200 text-masjid-dark font-medium rounded-lg transition-colors"
          >
            Batal
          </button>
          <button
            @click="handleDelete"
            :disabled="deleting"
            class="flex-1 px-6 py-3 bg-red-600 hover:bg-red-700 text-white font-medium rounded-lg transition-colors disabled:opacity-50"
          >
            {{ deleting ? 'Menghapus...' : 'Ya, Hapus' }}
          </button>
        </div>
      </div>
    </div>
  </div>
  </NuxtLayout>
</template>

<script setup lang="ts">
import { PhPlus, PhImage, PhWarning } from '@phosphor-icons/vue'

definePageMeta({
  layout: 'admin',
  middleware: 'auth'
})

const { fetchGalleryItems, deleteGalleryItem, deleteGalleryPhoto } = useGallery()
const toast = useToast()

const gallery = ref<any[]>([])
const loading = ref(true)
const selectedCategory = ref<string>('')
const showDeleteModal = ref(false)
const itemToDelete = ref<any>(null)
const deleting = ref(false)

const categories = [
  { value: '', label: 'Semua' },
  { value: 'kegiatan', label: 'Kegiatan' },
  { value: 'masjid', label: 'Masjid' },
  { value: 'jamaah', label: 'Jamaah' },
  { value: 'lainnya', label: 'Lainnya' }
]

const categoryLabel = computed(() => {
  const cat = categories.find(c => c.value === selectedCategory.value)
  return cat?.label || 'Semua'
})

const filteredGallery = computed(() => {
  if (!selectedCategory.value) return gallery.value
  return gallery.value.filter(item => item.category === selectedCategory.value)
})

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

const formatDate = (dateString: string) => {
  const date = new Date(dateString)
  return new Intl.DateTimeFormat('id-ID', {
    day: 'numeric',
    month: 'long',
    year: 'numeric'
  }).format(date)
}

const getCategoryLabel = (category: string) => {
  const cat = categories.find(c => c.value === category)
  return cat?.label || category
}

const getCategoryColor = (category: string) => {
  const colors: Record<string, string> = {
    kegiatan: 'bg-blue-100 text-blue-700',
    masjid: 'bg-green-100 text-green-700',
    jamaah: 'bg-purple-100 text-purple-700',
    lainnya: 'bg-gray-100 text-gray-700'
  }
  return colors[category] || colors.lainnya
}

const confirmDelete = (item: any) => {
  itemToDelete.value = item
  showDeleteModal.value = true
}

const handleDelete = async () => {
  if (!itemToDelete.value) return

  deleting.value = true
  try {
    // Delete photo from storage if exists
    if (itemToDelete.value.image_url) {
      await deleteGalleryPhoto(itemToDelete.value.image_url)
    }

    // Delete from database
    await deleteGalleryItem(itemToDelete.value.id)

    toast.success('Foto berhasil dihapus')

    // Remove from local array
    gallery.value = gallery.value.filter(item => item.id !== itemToDelete.value.id)

    showDeleteModal.value = false
    itemToDelete.value = null
  } catch (error) {
    console.error('Error deleting gallery item:', error)
    toast.error('Gagal menghapus foto. Silakan coba lagi.')
  } finally {
    deleting.value = false
  }
}

onMounted(() => {
  loadGallery()
})
</script>

<style scoped>
.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
