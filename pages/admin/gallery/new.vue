<template>
  <NuxtLayout name="admin">
    <div class="max-w-4xl">
    <div class="mb-6">
      <NuxtLink
        to="/admin/gallery"
        class="text-sm text-masjid-gold hover:text-masjid-dark transition-colors inline-flex items-center gap-1"
      >
        ← Kembali ke Galeri
      </NuxtLink>
    </div>

    <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
      <h2 class="text-2xl font-serif font-bold text-masjid-dark mb-6">
        Upload Foto Baru
      </h2>

      <form @submit.prevent="handleSubmit" class="space-y-6">
        <!-- Photo Upload (Required) -->
        <div>
          <label class="block text-sm font-medium text-masjid-dark mb-2">
            Foto * <span class="text-xs text-masjid-text-muted">(Wajib diisi)</span>
          </label>
          <div class="space-y-4">
            <!-- Preview -->
            <div v-if="photoPreview" class="relative rounded-lg overflow-hidden bg-gray-100 aspect-video">
              <img
                :src="photoPreview"
                alt="Preview"
                class="w-full h-full object-cover"
              />
              <button
                type="button"
                @click="removePhoto"
                class="absolute top-3 right-3 px-3 py-2 bg-red-600 hover:bg-red-700 text-white text-sm font-medium rounded-lg transition-colors"
              >
                Hapus Foto
              </button>
            </div>
            
            <!-- Upload Area -->
            <div
              v-else
              @click="photoInput?.click()"
              class="border-2 border-dashed border-gray-300 rounded-lg p-12 text-center cursor-pointer hover:border-masjid-gold transition-colors"
            >
              <div class="flex items-center justify-center mb-4">
                <PhCamera :size="64" class="text-gray-400" />
              </div>
              <p class="text-masjid-dark font-medium mb-1">
                Klik untuk pilih foto
              </p>
              <p class="text-sm text-masjid-text-muted">
                Format: JPG, PNG. Maksimal 5MB. Rekomendasi: 1200x800px
              </p>
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
            :disabled="submitting || !photoFile"
            class="flex-1 px-6 py-3 bg-masjid-gold hover:bg-masjid-dark text-white font-medium rounded-lg transition-colors disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2"
          >
            <span v-if="submitting" class="animate-spin rounded-full h-5 w-5 border-2 border-white border-t-transparent"></span>
            <PhUpload v-else :size="20" />
            <span>{{ submitting ? 'Mengupload...' : 'Upload Foto' }}</span>
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
  </NuxtLayout>
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
