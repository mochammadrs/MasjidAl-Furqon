<template>
  <div class="max-w-4xl">
    <div class="mb-6">
      <NuxtLink
        to="/admin/gallery"
        class="text-sm text-masjid-gold hover:text-masjid-dark transition-colors inline-flex items-center gap-1"
      >
        ← Kembali ke Galeri
      </NuxtLink>
    </div>

    <div v-if="loading" class="flex justify-center items-center min-h-[400px]">
      <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-masjid-gold"></div>
    </div>

    <div v-else-if="!item" class="text-center py-16">
      <div class="inline-flex items-center justify-center w-20 h-20 rounded-2xl bg-gray-100 mb-5">
        <PhWarning :size="40" class="text-gray-400" />
      </div>
      <h2 class="text-2xl font-serif font-bold text-masjid-dark mb-3">
        Foto Tidak Ditemukan
      </h2>
      <NuxtLink
        to="/admin/gallery"
        class="inline-block px-6 py-3 bg-masjid-gold hover:bg-masjid-dark text-white font-medium rounded-lg transition-colors"
      >
        ← Kembali ke Galeri
      </NuxtLink>
    </div>

    <div v-else class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
      <h2 class="text-2xl font-serif font-bold text-masjid-dark mb-6">
        Edit Foto: {{ item.title }}
      </h2>

      <form @submit.prevent="handleSubmit" class="space-y-6">
        <!-- Photo Display/Replace -->
        <div>
          <label class="block text-sm font-medium text-masjid-dark mb-2">
            Foto
          </label>
          <div class="space-y-4">
            <!-- Current/Preview Photo -->
            <div class="relative rounded-lg overflow-hidden bg-gray-100 aspect-video">
              <img
                v-if="photoPreview || form.image_url"
                :src="photoPreview || form.image_url || ''"
                alt="Preview"
                class="w-full h-full object-cover"
              />
              <div v-else class="w-full h-full flex items-center justify-center">
                <PhImage :size="64" class="text-gray-300" />
              </div>
            </div>
            
            <!-- Upload Button -->
            <div class="flex gap-3">
              <input
                ref="photoInput"
                type="file"
                accept="image/*"
                @change="handlePhotoChange"
                class="hidden"
              />
              <button
                type="button"
                @click="photoInput?.click()"
                class="px-4 py-2 bg-gray-100 hover:bg-gray-200 text-masjid-dark rounded-lg transition-colors"
              >
                {{ form.image_url ? 'Ganti Foto' : 'Pilih Foto' }}
              </button>
              <button
                v-if="photoPreview || form.image_url"
                type="button"
                @click="removePhoto"
                class="px-4 py-2 bg-red-50 hover:bg-red-100 text-red-700 rounded-lg transition-colors"
              >
                Hapus Foto
              </button>
            </div>
            <p class="text-xs text-masjid-text-muted">
              Format: JPG, PNG. Maksimal 5MB. Rekomendasi: 1200x800px
            </p>
          </div>
        </div>

        <!-- Title -->
        <div>
          <label class="block text-sm font-medium text-masjid-dark mb-2">
            Judul Foto *
          </label>
          <input
            v-model="form.title"
            type="text"
            required
            placeholder="Contoh: Kajian Ramadhan 2026"
            class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
          />
        </div>

        <!-- Description -->
        <div>
          <label class="block text-sm font-medium text-masjid-dark mb-2">
            Deskripsi <span class="text-xs text-masjid-text-muted">(Opsional)</span>
          </label>
          <textarea
            v-model="form.description"
            rows="3"
            placeholder="Jelaskan tentang foto ini..."
            class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none resize-none"
          ></textarea>
        </div>

        <!-- Category -->
        <div>
          <label class="block text-sm font-medium text-masjid-dark mb-2">
            Kategori *
          </label>
          <select
            v-model="form.category"
            required
            class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
          >
            <option value="">-- Pilih Kategori --</option>
            <option value="kegiatan">Kegiatan</option>
            <option value="masjid">Masjid</option>
            <option value="jamaah">Jamaah</option>
            <option value="lainnya">Lainnya</option>
          </select>
        </div>

        <!-- Submit Buttons -->
        <div class="flex gap-3 pt-4">
          <button
            type="submit"
            :disabled="submitting"
            class="flex-1 px-6 py-3 bg-masjid-gold hover:bg-masjid-dark text-white font-medium rounded-lg transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
          >
            <span v-if="submitting">Menyimpan...</span>
            <span v-else>Simpan Perubahan</span>
          </button>
          <NuxtLink
            to="/admin/gallery"
            class="px-6 py-3 bg-gray-100 hover:bg-gray-200 text-masjid-dark font-medium rounded-lg transition-colors text-center"
          >
            Batal
          </NuxtLink>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PhWarning, PhImage } from '@phosphor-icons/vue'

definePageMeta({
  layout: 'admin',
  middleware: 'auth'
})

const route = useRoute()
const { fetchGalleryItem, updateGalleryItem, uploadGalleryPhoto, deleteGalleryPhoto } = useGallery()
const toast = useToast()

const itemId = computed(() => route.params.id as string)

const item = ref<any>(null)
const loading = ref(true)

const form = ref({
  title: '',
  description: '',
  category: '',
  image_url: ''
})

const photoInput = ref<HTMLInputElement>()
const photoFile = ref<File | null>(null)
const photoPreview = ref<string>('')
const submitting = ref(false)

// Load gallery item
const loadItem = async () => {
  loading.value = true
  try {
    const data = await fetchGalleryItem(itemId.value)
    if (data) {
      item.value = data
      form.value = {
        title: data.title || '',
        description: data.description || '',
        category: data.category || '',
        image_url: data.image_url || ''
      }
    }
  } catch (err) {
    console.error('Error loading gallery item:', err)
  } finally {
    loading.value = false
  }
}

const handlePhotoChange = (event: Event) => {
  const target = event.target as HTMLInputElement
  const file = target.files?.[0]
  
  if (!file) return

  // Validate file size (max 5MB)
  if (file.size > 5 * 1024 * 1024) {
    toast.error('Ukuran file terlalu besar. Maksimal 5MB.')
    return
  }

  // Validate file type
  if (!file.type.startsWith('image/')) {
    toast.error('File harus berupa gambar.')
    return
  }

  photoFile.value = file
  
  // Create preview
  const reader = new FileReader()
  reader.onload = (e) => {
    photoPreview.value = e.target?.result as string
  }
  reader.readAsDataURL(file)
}

const removePhoto = async () => {
  if (form.value.image_url) {
    const confirmed = confirm('Hapus foto yang sudah ada?')
    if (confirmed) {
      try {
        await deleteGalleryPhoto(form.value.image_url)
        form.value.image_url = ''
        photoPreview.value = ''
        photoFile.value = null
        if (photoInput.value) {
          photoInput.value.value = ''
        }
        toast.success('Foto berhasil dihapus')
      } catch (err) {
        console.error('Error deleting photo:', err)
        toast.error('Gagal menghapus foto')
      }
    }
  } else {
    photoFile.value = null
    photoPreview.value = ''
    if (photoInput.value) {
      photoInput.value.value = ''
    }
  }
}

const handleSubmit = async () => {
  submitting.value = true

  try {
    // Upload new photo if selected
    if (photoFile.value) {
      try {
        // Delete old photo if exists
        if (form.value.image_url) {
          await deleteGalleryPhoto(form.value.image_url)
        }
        // Upload new photo
        await uploadGalleryPhoto(photoFile.value, itemId.value)
      } catch (uploadError) {
        console.error('Error uploading photo:', uploadError)
        // Don't fail the whole operation if photo upload fails
      }
    }

    // Update gallery item data
    await updateGalleryItem(itemId.value, {
      title: form.value.title,
      description: form.value.description || null,
      category: form.value.category
    })

    toast.success('Perubahan berhasil disimpan!')
    
    // Redirect to list
    await navigateTo('/admin/gallery')
  } catch (err: any) {
    console.error('Error updating gallery item:', err)
    toast.error(err.message || 'Gagal menyimpan perubahan')
  } finally {
    submitting.value = false
  }
}

onMounted(() => {
  loadItem()
})
</script>
