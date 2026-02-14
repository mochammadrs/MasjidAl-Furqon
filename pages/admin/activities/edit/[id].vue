<template>
  <div class="max-w-4xl">
    <div class="mb-6">
      <NuxtLink
        to="/admin/activities"
        class="text-sm text-masjid-gold hover:text-masjid-dark transition-colors inline-flex items-center gap-1"
      >
        ← Kembali ke Daftar Kegiatan
      </NuxtLink>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="flex justify-center py-12">
      <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-masjid-gold"></div>
    </div>

    <div v-else class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
      <h2 class="text-2xl font-serif font-bold text-masjid-dark mb-6">
        Edit Kegiatan
      </h2>

      <form @submit.prevent="handleSubmit" class="space-y-6">
        <!-- Title -->
        <div>
          <label class="block text-sm font-medium text-masjid-dark mb-2">
            Judul Kegiatan *
          </label>
          <input
            v-model="form.title"
            type="text"
            required
            class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
          />
        </div>

        <!-- Description -->
        <div>
          <label class="block text-sm font-medium text-masjid-dark mb-2">
            Deskripsi *
          </label>
          <textarea
            v-model="form.description"
            required
            rows="4"
            class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none resize-none"
          ></textarea>
        </div>

        <!-- Date & Time -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-medium text-masjid-dark mb-2">
              Tanggal *
            </label>
            <input
              v-model="form.date"
              type="date"
              required
              class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
            />
          </div>
          <div>
            <label class="block text-sm font-medium text-masjid-dark mb-2">
              Waktu
            </label>
            <input
              v-model="form.time"
              type="text"
              placeholder="Contoh: 07:00 - 08:30"
              class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
            />
          </div>
        </div>

        <!-- Location & Category -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-medium text-masjid-dark mb-2">
              Lokasi
            </label>
            <input
              v-model="form.location"
              type="text"
              class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
            />
          </div>
          <div>
            <label class="block text-sm font-medium text-masjid-dark mb-2">
              Kategori *
            </label>
            <select
              v-model="form.category"
              required
              class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
            >
              <option value="kajian">Kajian</option>
              <option value="sosial">Sosial</option>
              <option value="pendidikan">Pendidikan</option>
              <option value="ramadhan">Ramadhan</option>
              <option value="lainnya">Lainnya</option>
            </select>
          </div>
        </div>

        <!-- Current Image -->
        <div v-if="currentImageUrl">
          <label class="block text-sm font-medium text-masjid-dark mb-2">
            Foto Saat Ini
          </label>
          <div class="relative inline-block">
            <img :src="currentImageUrl" alt="Current" class="w-48 h-48 object-cover rounded-lg" />
            <button
              type="button"
              @click="handleDeleteImage"
              class="absolute top-2 right-2 bg-red-600 hover:bg-red-700 text-white rounded-full p-2 shadow-lg transition-colors"
              title="Hapus foto"
            >
              <PhTrash :size="16" />
            </button>
          </div>
        </div>

        <!-- Image Upload -->
        <div>
          <label class="block text-sm font-medium text-masjid-dark mb-2">
            {{ currentImageUrl ? 'Ganti Foto' : 'Upload Foto' }}
          </label>
          <input
            type="file"
            accept="image/*"
            @change="handleImageChange"
            class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
          />
          <p class="text-xs text-masjid-text-muted mt-1">
            Format: JPG, PNG (Maks. 5MB)
          </p>
          
          <!-- New Image Preview -->
          <div v-if="imagePreview" class="mt-4">
            <p class="text-sm text-masjid-dark mb-2">Preview Foto Baru:</p>
            <img :src="imagePreview" alt="Preview" class="w-48 h-48 object-cover rounded-lg" />
          </div>
        </div>

        <!-- Published Status -->
        <div class="flex items-center gap-3">
          <input
            v-model="form.is_published"
            type="checkbox"
            id="published"
            class="w-5 h-5 text-masjid-gold border-gray-300 rounded focus:ring-masjid-gold"
          />
          <label for="published" class="text-sm font-medium text-masjid-dark">
            Publish kegiatan (tampilkan di website)
          </label>
        </div>

        <!-- Submit Buttons -->
        <div class="flex gap-3 pt-4 border-t">
          <NuxtLink
            to="/admin/activities"
            class="px-6 py-3 bg-gray-100 hover:bg-gray-200 text-gray-700 font-medium rounded-lg transition-colors"
          >
            Batal
          </NuxtLink>
          <button
            type="submit"
            :disabled="submitting"
            class="flex-1 px-6 py-3 bg-masjid-gold hover:bg-masjid-dark text-white font-medium rounded-lg transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {{ submitting ? 'Menyimpan...' : 'Update Kegiatan' }}
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PhTrash } from '@phosphor-icons/vue'

definePageMeta({
  layout: 'admin',
  middleware: 'auth'
})

const route = useRoute()
const activityId = route.params.id as string

const { fetchActivity, updateActivity, uploadActivityImage, deleteActivityImage } = useActivities()
const toast = useToast()

const loading = ref(true)
const form = ref({
  title: '',
  description: '',
  date: '',
  time: '',
  location: '',
  category: 'kajian',
  is_published: true
})

const currentImageUrl = ref<string | null>(null)
const selectedImage = ref<File | null>(null)
const imagePreview = ref<string | null>(null)
const submitting = ref(false)

const loadActivity = async () => {
  loading.value = true
  try {
    const activity = await fetchActivity(activityId)
    
    form.value = {
      title: activity.title,
      description: activity.description,
      date: activity.date,
      time: activity.time || '',
      location: activity.location,
      category: activity.category,
      is_published: activity.is_published
    }
    
    currentImageUrl.value = activity.image_url
  } catch (error) {
    console.error('Error loading activity:', error)
    toast.error('Gagal memuat data kegiatan')
    await navigateTo('/admin/activities')
  } finally {
    loading.value = false
  }
}

const handleImageChange = (event: Event) => {
  const target = event.target as HTMLInputElement
  const file = target.files?.[0]
  
  if (file) {
    selectedImage.value = file
    imagePreview.value = URL.createObjectURL(file)
  }
}

const handleDeleteImage = async () => {
  if (!confirm('Hapus foto ini?')) return

  try {
    if (currentImageUrl.value) {
      await deleteActivityImage(currentImageUrl.value)
      await updateActivity(activityId, { image_url: null })
      currentImageUrl.value = null
      toast.success('Foto berhasil dihapus')
    }
  } catch (error) {
    console.error('Error deleting image:', error)
    toast.error('Gagal menghapus foto')
  }
}

const handleSubmit = async () => {
  submitting.value = true
  try {
    console.log('=== Starting update ===')
    console.log('Activity ID:', activityId)
    console.log('Form data:', form.value)
    
    let imageUrl = currentImageUrl.value

    // Upload new image if selected
    if (selectedImage.value) {
      try {
        console.log('Uploading new image...')
        // Delete old image first
        if (currentImageUrl.value) {
          console.log('Deleting old image...')
          await deleteActivityImage(currentImageUrl.value)
        }
        
        imageUrl = await uploadActivityImage(selectedImage.value, activityId)
        console.log('New image uploaded:', imageUrl)
      } catch (uploadError: any) {
        console.error('Error uploading image (non-critical):', uploadError)
        // Continue even if image upload fails
      }
    }

    // Update activity
    console.log('Updating activity...')
    const updateData = {
      title: form.value.title,
      description: form.value.description,
      date: form.value.date,
      time: form.value.time || null,
      location: form.value.location,
      category: form.value.category,
      is_published: form.value.is_published,
      image_url: imageUrl
    }
    console.log('Update data:', updateData)
    
    await updateActivity(activityId, updateData)
    console.log('Activity updated successfully!')

    // Show success message
    toast.success('Kegiatan berhasil diupdate!')
    
    // Redirect to list
    await navigateTo('/admin/activities')
  } catch (error: any) {
    console.error('=== Update Error ===')
    console.error('Error object:', error)
    console.error('Error message:', error.message)
    console.error('Error code:', error.code)
    console.error('Error details:', error.details)
    
    let errorMessage = 'Gagal update kegiatan. '
    
    if (error.message) {
      errorMessage += error.message
    }
    
    // Check for specific errors
    if (error.message?.includes('permission') || error.message?.includes('policy') || error.code === '42501') {
      errorMessage = 'Tidak ada izin untuk update data. Pastikan Anda sudah menjalankan SQL fix-policies.sql di Supabase SQL Editor.'
    } else if (error.message?.includes('JWT') || error.message?.includes('expired')) {
      toast.error('❌ Session expired. Silakan login ulang.')
      await navigateTo('/admin/login')
      return
    }
    
    toast.error(`❌ ${errorMessage}`)
  } finally {
    submitting.value = false
  }
}

onMounted(() => {
  loadActivity()
})
</script>
