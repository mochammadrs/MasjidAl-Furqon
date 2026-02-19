<template>
  <div class="max-w-4xl">
    <!-- Back Button Premium -->
    <div class="mb-6">
      <NuxtLink
        to="/admin/gallery"
        class="group inline-flex items-center gap-2 px-4 py-2 rounded-lg bg-white/50 backdrop-blur-sm border border-masjid-gold/20 hover:bg-masjid-gold/10 hover:border-masjid-gold/40 transition-all duration-300"
      >
        <svg class="w-4 h-4 text-masjid-gold group-hover:-translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
        </svg>
        <span class="text-sm font-medium text-masjid-dark">Kembali ke Galeri</span>
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

    <!-- Premium Form Card -->
    <div v-else class="relative overflow-hidden">
      <!-- Background Gradient -->
      <div class="absolute inset-0 bg-gradient-to-br from-masjid-gold/5 via-masjid-cream/5 to-white rounded-2xl"></div>
      <div class="absolute -top-24 -right-24 w-48 h-48 bg-masjid-gold/10 rounded-full blur-3xl"></div>
      <div class="absolute -bottom-24 -left-24 w-48 h-48 bg-masjid-cream/10 rounded-full blur-3xl"></div>

      <div class="relative bg-white/80 backdrop-blur-xl rounded-2xl shadow-xl border border-white/60 p-8">
        <!-- Header with Icon -->
        <div class="flex items-center gap-4 mb-8 pb-6 border-b border-masjid-gold/20">
          <div class="w-12 h-12 rounded-xl bg-gradient-to-br from-masjid-gold to-masjid-dark flex items-center justify-center shadow-lg shadow-masjid-gold/20">
            <PhImage :size="24" weight="duotone" class="text-white" />
          </div>
          <div>
            <h2 class="text-2xl font-serif font-bold text-masjid-dark">
              Edit Foto: {{ item.title }}
            </h2>
            <p class="text-sm text-gray-600 mt-1">Perbarui foto di galeri</p>
          </div>
        </div>

        <form @submit.prevent="handleSubmit" class="space-y-6">
          <!-- Photo Display/Replace Premium -->
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">Foto <span class="text-red-500">*</span></label>
            <div class="space-y-4">
              <!-- Current/Preview Photo Premium -->
              <div class="relative rounded-xl overflow-hidden bg-gradient-to-br from-gray-100 to-gray-200 aspect-video border-2 border-gray-200 shadow-md group hover:border-masjid-gold/50 transition-all duration-300">
                <img v-if="photoPreview || form.image_url" :src="photoPreview || form.image_url || ''" alt="Preview" class="w-full h-full object-cover" />
                <div v-else class="w-full h-full flex items-center justify-center">
                  <PhImage :size="64" weight="duotone" class="text-gray-400" />
                </div>
                <!-- Success Badge on Preview -->
                <div v-if="photoPreview" class="absolute top-4 right-4 px-3 py-1.5 bg-gradient-to-r from-green-500 to-emerald-600 text-white text-xs font-semibold rounded-full shadow-lg backdrop-blur-sm">
                  ✓ Foto Baru
                </div>
              </div>
              
              <!-- Upload Buttons Premium -->
              <div class="flex gap-3">
                <input ref="photoInput" type="file" accept="image/*" @change="handlePhotoChange" class="hidden" />
                <button type="button" @click="photoInput?.click()" class="px-5 py-2.5 bg-gradient-to-r from-masjid-gold/10 to-masjid-cream/10 hover:from-masjid-gold/20 hover:to-masjid-cream/20 text-masjid-dark font-semibold rounded-lg border-2 border-masjid-gold/30 transition-all duration-300 shadow-sm hover:shadow-md">
                  {{ form.image_url ? 'Ganti Foto' : 'Pilih Foto' }}
                </button>
                <button v-if="photoPreview || form.image_url" type="button" @click="removePhoto" class="px-5 py-2.5 bg-gradient-to-r from-red-50 to-red-100 hover:from-red-100 hover:to-red-200 text-red-700 font-semibold rounded-lg border-2 border-red-200 hover:border-red-300 transition-all duration-300 shadow-sm">
                  🗑️ Hapus Foto
                </button>
              </div>
              <p class="text-xs text-gray-600">Format: JPG, PNG. Maksimal 5MB. Rekomendasi: 1200x800px</p>
            </div>
          </div>

          <!-- Title Premium -->
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">Judul Foto <span class="text-red-500">*</span></label>
            <input v-model="form.title" type="text" required placeholder="Contoh: Kajian Ramadhan 2026" class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50" />
          </div>

          <!-- Description Premium -->
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">Deskripsi <span class="text-xs text-gray-500 font-normal">(Opsional)</span></label>
            <textarea v-model="form.description" rows="3" placeholder="Jelaskan tentang foto ini..." class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none resize-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50"></textarea>
          </div>

          <!-- Category Premium -->
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">Kategori <span class="text-red-500">*</span></label>
            <select v-model="form.category" required class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none shadow-sm hover:border-masjid-gold/50 cursor-pointer appearance-none" style="background-image: url('data:image/svg+xml;charset=UTF-8,%3csvg xmlns=%27http://www.w3.org/2000/svg%27 viewBox=%270 0 24 24%27 fill=%27none%27 stroke=%27%236B7280%27 stroke-width=%272%27 stroke-linecap=%27round%27 stroke-linejoin=%27round%27%3e%3cpolyline points=%276 9 12 15 18 9%27%3e%3c/polyline%3e%3c/svg%3e'); background-repeat: no-repeat; background-position: right 1rem center; background-size: 1.25rem; padding-right: 3rem;">
              <option value="">-- Pilih Kategori --</option>
              <option value="kegiatan">📸 Kegiatan</option>
              <option value="masjid">🕌 Masjid</option>
              <option value="jamaah">👥 Jamaah</option>
              <option value="lainnya">✨ Lainnya</option>
            </select>
          </div>

          <!-- Premium Action Buttons -->
          <div class="flex flex-col-reverse sm:flex-row gap-4 pt-6 border-t border-masjid-gold/20">
            <NuxtLink to="/admin/gallery" class="sm:w-40 px-6 py-3.5 bg-white border-2 border-gray-200 hover:border-gray-300 hover:bg-gray-50 text-gray-700 font-semibold rounded-xl transition-all duration-300 text-center shadow-sm">Batal</NuxtLink>
            <button type="submit" :disabled="submitting" class="flex-1 px-6 py-3.5 bg-gradient-to-r from-masjid-gold to-masjid-dark hover:from-masjid-dark hover:to-masjid-gold text-white font-semibold rounded-xl transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed shadow-lg shadow-masjid-gold/30 hover:shadow-xl hover:shadow-masjid-gold/40 hover:scale-[1.02] active:scale-[0.98]">
              <span v-if="submitting" class="flex items-center justify-center gap-2"><svg class="animate-spin w-5 h-5" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>Menyimpan...</span>
              <span v-else>Simpan Perubahan</span>
            </button>
          </div>
        </form>
      </div>
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
