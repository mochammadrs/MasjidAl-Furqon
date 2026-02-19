<template>
  <div class="max-w-4xl">
    <!-- Back Button Premium Style -->
    <div class="mb-6">
      <NuxtLink
        to="/admin/activities"
        class="group inline-flex items-center gap-2 px-4 py-2 rounded-lg bg-white/50 backdrop-blur-sm border border-masjid-gold/20 hover:bg-masjid-gold/10 hover:border-masjid-gold/40 transition-all duration-300"
      >
        <svg class="w-4 h-4 text-masjid-gold group-hover:-translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
        </svg>
        <span class="text-sm font-medium text-masjid-dark">Kembali ke Daftar Kegiatan</span>
      </NuxtLink>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="flex justify-center py-12">
      <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-masjid-gold"></div>
    </div>

    <!-- Premium Form Card -->
    <div v-else class="relative overflow-hidden">
      <!-- Background Gradient Overlay -->
      <div class="absolute inset-0 bg-gradient-to-br from-masjid-gold/5 via-masjid-cream/5 to-white rounded-2xl"></div>
      
      <!-- Ambient Glow Decorations -->
      <div class="absolute -top-24 -right-24 w-48 h-48 bg-masjid-gold/10 rounded-full blur-3xl"></div>
      <div class="absolute -bottom-24 -left-24 w-48 h-48 bg-masjid-cream/10 rounded-full blur-3xl"></div>

      <div class="relative bg-white/80 backdrop-blur-xl rounded-2xl shadow-xl border border-white/60 p-8">
        <!-- Header with Icon -->
        <div class="flex items-center gap-4 mb-8 pb-6 border-b border-masjid-gold/20">
          <div class="w-12 h-12 rounded-xl bg-gradient-to-br from-masjid-gold to-masjid-dark flex items-center justify-center shadow-lg shadow-masjid-gold/20">
            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
            </svg>
          </div>
          <div>
            <h2 class="text-2xl font-serif font-bold text-masjid-dark">
              Edit Kegiatan
            </h2>
            <p class="text-sm text-gray-600 mt-1">Perbarui informasi kegiatan</p>
          </div>
        </div>

      <form @submit.prevent="handleSubmit" class="space-y-6">
        <!-- Title Premium -->
        <div class="space-y-2">
          <label class="block text-sm font-semibold text-masjid-dark">
            Judul Kegiatan <span class="text-red-500">*</span>
          </label>
          <input
            v-model="form.title"
            type="text"
            required
            class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none shadow-sm hover:border-masjid-gold/50"
          />
        </div>

        <!-- Description Premium -->
        <div class="space-y-2">
          <label class="block text-sm font-semibold text-masjid-dark">
            Deskripsi <span class="text-red-500">*</span>
          </label>
          <textarea
            v-model="form.description"
            required
            rows="5"
            class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none resize-none shadow-sm hover:border-masjid-gold/50"
          ></textarea>
        </div>

        <!-- Date & Time Grid Premium -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">
              Tanggal <span class="text-red-500">*</span>
            </label>
            <input
              v-model="form.date"
              type="date"
              required
              class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none shadow-sm hover:border-masjid-gold/50"
            />
          </div>
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">
              Waktu
            </label>
            <input
              v-model="form.time"
              type="text"
              placeholder="Contoh: 07:00 - 08:30"
              class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50"
            />
          </div>
        </div>

        <!-- Location & Category Grid Premium -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">
              Lokasi
            </label>
            <input
              v-model="form.location"
              type="text"
              class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none shadow-sm hover:border-masjid-gold/50"
            />
          </div>
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">
              Kategori <span class="text-red-500">*</span>
            </label>
            <select
              v-model="form.category"
              required
              class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none shadow-sm hover:border-masjid-gold/50 cursor-pointer"
            >
              <option value="kajian">📚 Kajian</option>
              <option value="sosial">🤝 Sosial</option>
              <option value="pendidikan">🎓 Pendidikan</option>
              <option value="ramadhan">🌙 Ramadhan</option>
              <option value="lainnya">✨ Lainnya</option>
            </select>
          </div>
        </div>

        <!-- Current Image Premium Card -->
        <div v-if="currentImageUrl" class="space-y-2">
          <label class="block text-sm font-semibold text-masjid-dark">
            Foto Saat Ini
          </label>
          <div class="relative inline-block rounded-xl overflow-hidden shadow-lg border-2 border-masjid-gold/30">
            <img :src="currentImageUrl" alt="Current" class="w-64 h-64 object-cover" />
            <button
              type="button"
              @click="handleDeleteImage"
              class="absolute top-3 right-3 p-2.5 bg-red-500/90 backdrop-blur-sm hover:bg-red-600 text-white rounded-lg shadow-lg shadow-red-500/30 transition-all duration-300 hover:scale-110"
              title="Hapus foto"
            >
              <PhTrash :size="18" weight="bold" />
            </button>
          </div>
        </div>

        <!-- Image Upload Premium -->
        <div class="space-y-2">
          <label class="block text-sm font-semibold text-masjid-dark">
            {{ currentImageUrl ? 'Ganti Foto' : 'Upload Foto' }}
          </label>
          <input
            type="file"
            accept="image/*"
            @change="handleImageChange"
            class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:bg-masjid-gold/10 file:text-masjid-gold file:font-semibold hover:file:bg-masjid-gold/20 file:cursor-pointer shadow-sm hover:border-masjid-gold/50"
          />
          <p class="text-xs text-gray-600 mt-1">
            Format: JPG, PNG (Maks. 5MB)
          </p>
          
          <!-- New Image Preview Card -->
          <div v-if="imagePreview" class="mt-4 pt-4 border-t border-masjid-gold/20">
            <p class="text-sm font-semibold text-masjid-dark mb-3">Preview Foto Baru:</p>
            <div class="relative inline-block rounded-xl overflow-hidden shadow-lg border-2 border-green-500/50">
              <img :src="imagePreview" alt="Preview" class="w-64 h-64 object-cover" />
              <div class="absolute bottom-3 left-3 px-3 py-1.5 bg-green-500/90 backdrop-blur-sm text-white text-xs font-semibold rounded-lg">
                Foto Baru
              </div>
            </div>
          </div>
        </div>

        <!-- Premium Checkbox -->
        <div class="bg-gradient-to-br from-masjid-gold/5 to-masjid-cream/5 rounded-xl p-5 border border-masjid-gold/20">
          <div class="flex items-start gap-4">
            <div class="relative flex items-center justify-center">
              <input
                v-model="form.is_published"
                type="checkbox"
                id="published"
                class="peer w-6 h-6 appearance-none border-2 border-gray-300 rounded-lg checked:bg-masjid-gold checked:border-masjid-gold cursor-pointer transition-all duration-300 focus:ring-4 focus:ring-masjid-gold/20"
              />
              <svg class="absolute w-4 h-4 text-white pointer-events-none hidden peer-checked:block" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M5 13l4 4L19 7"/>
              </svg>
            </div>
            <div class="flex-1">
              <label for="published" class="text-sm font-semibold text-masjid-dark cursor-pointer block mb-1">
                Publish kegiatan (tampilkan di website)
              </label>
              <p class="text-xs text-gray-600">Centang untuk menampilkan kegiatan ini di halaman website</p>
            </div>
          </div>
        </div>

        <!-- Premium Action Buttons -->
        <div class="flex flex-col sm:flex-row gap-4 pt-6 border-t border-masjid-gold/20">
          <NuxtLink
            to="/admin/activities"
            class="sm:w-40 px-6 py-3.5 bg-white border-2 border-gray-200 hover:border-gray-300 hover:bg-gray-50 text-gray-700 font-semibold rounded-xl transition-all duration-300 text-center shadow-sm"
          >
            Batal
          </NuxtLink>
          <button
            type="submit"
            :disabled="submitting"
            class="flex-1 px-6 py-3.5 bg-gradient-to-r from-masjid-gold to-masjid-dark hover:from-masjid-dark hover:to-masjid-gold text-white font-semibold rounded-xl transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed shadow-lg shadow-masjid-gold/30 hover:shadow-xl hover:shadow-masjid-gold/40 hover:scale-[1.02] active:scale-[0.98]"
          >
            <span v-if="submitting" class="flex items-center justify-center gap-2">
              <svg class="animate-spin w-5 h-5" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
              Menyimpan...
            </span>
            <span v-else>Update Kegiatan</span>
          </button>
        </div>
      </form>
      </div>
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
