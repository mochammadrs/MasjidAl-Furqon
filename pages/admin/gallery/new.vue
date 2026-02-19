<template>
  <div class="max-w-4xl">
    <!-- Back Button Premium -->    <div class="mb-6">
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

    <!-- Premium Form Card -->
    <div class="relative overflow-hidden">
      <!-- Background Gradient Overlay -->
      <div class="absolute inset-0 bg-gradient-to-br from-masjid-gold/5 via-masjid-cream/5 to-white rounded-2xl"></div>
      
      <!-- Ambient Glow Decorations -->
      <div class="absolute -top-24 -right-24 w-48 h-48 bg-masjid-gold/10 rounded-full blur-3xl"></div>
      <div class="absolute -bottom-24 -left-24 w-48 h-48 bg-masjid-cream/10 rounded-full blur-3xl"></div>

      <div class="relative bg-white/80 backdrop-blur-xl rounded-2xl shadow-xl border border-white/60 p-8">
        <!-- Header with Icon -->
        <div class="flex items-center gap-4 mb-8 pb-6 border-b border-masjid-gold/20">
          <div class="w-12 h-12 rounded-xl bg-gradient-to-br from-masjid-gold to-masjid-dark flex items-center justify-center shadow-lg shadow-masjid-gold/20">
            <PhCamera :size="24" weight="duotone" class="text-white" />
          </div>
          <div>
            <h2 class="text-2xl font-serif font-bold text-masjid-dark">
              Upload Foto Baru
            </h2>
            <p class="text-sm text-gray-600 mt-1">Tambahkan foto ke galeri masjid</p>
          </div>
        </div>

        <form @submit.prevent="handleSubmit" class="space-y-6">
          <!-- Photo Upload Premium -->
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">
              Foto <span class="text-red-500">*</span> <span class="text-xs font-normal text-gray-600">(Wajib diisi)</span>
            </label>
            <div class="space-y-4">
              <!-- Preview Premium -->
              <div v-if="photoPreview" class="relative rounded-xl overflow-hidden bg-gradient-to-br from-gray-50 to-gray-100 shadow-lg border-2 border-masjid-gold/30">
                <img
                  :src="photoPreview"
                  alt="Preview"
                  class="w-full aspect-video object-cover"
                />
                <button
                  type="button"
                  @click="removePhoto"
                  class="absolute top-3 right-3 px-4 py-2 bg-red-500/90 backdrop-blur-sm hover:bg-red-600 text-white text-sm font-semibold rounded-lg transition-all duration-300 shadow-lg shadow-red-500/30 hover:scale-105"
                >
                  Hapus Foto
                </button>
                <div class="absolute bottom-3 left-3 px-4 py-2 bg-green-500/90 backdrop-blur-sm text-white text-sm font-medium rounded-lg shadow-lg flex items-center gap-2">
                  <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                  </svg>
                  Foto Siap
                </div>
              </div>
              
              <!-- Upload Area Premium -->
              <div
                v-else
                @click="photoInput?.click()"
                class="relative group overflow-hidden rounded-xl border-2 border-dashed border-gray-300 bg-gradient-to-br from-masjid-gold/5 to-masjid-cream/5 p-16 text-center cursor-pointer hover:border-masjid-gold hover:bg-masjid-gold/10 transition-all duration-300"
              >
                <!-- Upload Icon with Animation -->
                <div class="inline-flex items-center justify-center w-24 h-24 rounded-full bg-white/80 backdrop-blur-sm shadow-lg shadow-masjid-gold/10 mb-5 group-hover:scale-110 group-hover:shadow-masjid-gold/30 transition-all duration-300">
                  <PhCamera :size="48" weight="duotone" class="text-masjid-gold" />
                </div>
                <p class="text-base font-semibold text-masjid-dark mb-2">
                  Klik untuk pilih foto
                </p>
                <p class="text-sm text-gray-500 mb-1">
                  Format: JPG, PNG. Maksimal 5MB
                </p>
                <p class="text-xs text-gray-400">
                  Rekomendasi: 1200x800px
                </p>
                
                <!-- Decorative Elements -->
                <div class="absolute top-4 right-4 w-20 h-20 bg-masjid-gold/5 rounded-full blur-2xl"></div>
                <div class="absolute bottom-4 left-4 w-20 h-20 bg-masjid-cream/5 rounded-full blur-2xl"></div>
              </div>
              
              <input
                ref="photoInput"
                type="file"
                accept="image/*"
                required
                @change="handlePhotoChange"
                class="hidden"
              />
            </div>
          </div>

          <!-- Title Premium -->
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">
              Judul Foto <span class="text-red-500">*</span>
            </label>
            <input
              v-model="form.title"
              type="text"
              required
              placeholder="Contoh: Kajian Ramadhan 2026"
              class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50"
            />
          </div>

          <!-- Description Premium -->
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">
              Deskripsi <span class="text-xs font-normal text-gray-600">(Opsional)</span>
            </label>
            <textarea
              v-model="form.description"
              rows="4"
              placeholder="Jelaskan tentang foto ini..."
              class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none resize-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50"
            ></textarea>
          </div>

          <!-- Category Premium -->
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">
              Kategori <span class="text-red-500">*</span>
            </label>
            <select
              v-model="form.category"
              required
              class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none shadow-sm hover:border-masjid-gold/50 cursor-pointer"
            >
              <option value="">-- Pilih Kategori --</option>
              <option value="kegiatan">📸 Kegiatan</option>
              <option value="masjid">🕌 Masjid</option>
              <option value="jamaah">👥 Jamaah</option>
              <option value="lainnya">✨ Lainnya</option>
            </select>
          </div>

          <!-- Premium Action Buttons -->
          <div class="flex flex-col-reverse sm:flex-row gap-4 pt-6 border-t border-masjid-gold/20">
            <NuxtLink
              to="/admin/gallery"
              class="sm:w-40 px-6 py-3.5 bg-white border-2 border-gray-200 hover:border-gray-300 hover:bg-gray-50 text-gray-700 font-semibold rounded-xl transition-all duration-300 text-center shadow-sm"
            >
              Batal
            </NuxtLink>
            <button
              type="submit"
              :disabled="submitting || !photoFile"
              class="flex-1 px-6 py-3.5 bg-gradient-to-r from-masjid-gold to-masjid-dark hover:from-masjid-dark hover:to-masjid-gold text-white font-semibold rounded-xl transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed shadow-lg shadow-masjid-gold/30 hover:shadow-xl hover:shadow-masjid-gold/40 hover:scale-[1.02] active:scale-[0.98]"
            >
              <span v-if="submitting" class="flex items-center justify-center gap-2">
                <svg class="animate-spin w-5 h-5" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                </svg>
                Mengupload...
              </span>
              <span v-else class="flex items-center justify-center gap-2">
                <PhUpload :size="20" />
                Upload Foto
              </span>
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PhCamera, PhUpload } from '@phosphor-icons/vue'

definePageMeta({
  layout: 'admin',
  middleware: 'auth'
})

const { createGalleryItem, uploadGalleryPhoto } = useGallery()
const toast = useToast()

const form = ref({
  title: '',
  description: '',
  category: ''
})

const photoInput = ref<HTMLInputElement>()
const photoFile = ref<File | null>(null)
const photoPreview = ref<string>('')
const submitting = ref(false)

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

const removePhoto = () => {
  photoFile.value = null
  photoPreview.value = ''
  if (photoInput.value) {
    photoInput.value.value = ''
  }
}

const handleSubmit = async () => {
  if (!photoFile.value) {
    toast.error('Foto wajib diupload')
    return
  }

  submitting.value = true

  try {
    // Create gallery item without photo first
    const item = await createGalleryItem({
      title: form.value.title,
      description: form.value.description || null,
      category: form.value.category
    })

    // Upload photo
    if (item?.id) {
      try {
        await uploadGalleryPhoto(photoFile.value, item.id)
      } catch (uploadError) {
        console.error('Error uploading photo:', uploadError)
        // Don't fail the whole operation if photo upload fails
      }
    }

    toast.success('Foto berhasil diupload!')
    
    // Redirect to list
    await navigateTo('/admin/gallery')
  } catch (err: any) {
    console.error('Error creating gallery item:', err)
    toast.error(err.message || 'Gagal mengupload foto')
  } finally {
    submitting.value = false
  }
}
</script>
