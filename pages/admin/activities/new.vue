<template>
  <NuxtLayout name="admin">
    <div class="max-w-4xl">
    <div class="mb-6">
      <NuxtLink
        to="/admin/activities"
        class="text-sm text-masjid-gold hover:text-masjid-dark transition-colors inline-flex items-center gap-1"
      >
        ← Kembali ke Daftar Kegiatan
      </NuxtLink>
    </div>

    <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
      <h2 class="text-2xl font-serif font-bold text-masjid-dark mb-6">
        Tambah Kegiatan Baru
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
            placeholder="Contoh: Kajian Rutin Ahad Pagi"
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
            placeholder="Jelaskan detail kegiatan..."
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
              placeholder="Masjid Al-Furqon"
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

        <!-- Image Upload -->
        <div>
          <label class="block text-sm font-medium text-masjid-dark mb-2">
            Foto Kegiatan
          </label>
          
          <!-- Upload Button or Preview -->
          <div v-if="!imagePreview" class="relative">
            <input
              ref="fileInput"
              type="file"
              accept="image/*"
              @change="handleImageChange"
              class="absolute inset-0 w-full h-full opacity-0 cursor-pointer z-10"
            />
            <div class="border-2 border-dashed border-gray-300 rounded-lg p-8 text-center hover:border-masjid-gold transition-colors">
              <PhUpload :size="40" class="mx-auto text-gray-400 mb-3" />
              <p class="text-sm text-masjid-dark font-medium mb-1">Klik untuk upload foto</p>
              <p class="text-xs text-masjid-text-muted">JPG, PNG (Maks. 5MB)</p>
            </div>
          </div>

          <!-- Image Preview -->
          <div v-else class="relative">
            <img
              :src="imagePreview"
              alt="Preview"
              class="w-full h-64 object-cover rounded-lg border-2 border-gray-200"
              loading="lazy"
              decoding="async"
            />
            <button
              type="button"
              @click="removeImage"
              class="absolute top-2 right-2 p-2 bg-red-500 hover:bg-red-600 text-white rounded-lg shadow-lg transition-colors"
            >
              <PhX :size="20" weight="bold" />
            </button>
            <p class="text-xs text-masjid-text-muted mt-2">Foto siap diupload</p>
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
            {{ submitting ? 'Menyimpan...' : 'Simpan Kegiatan' }}
          </button>
        </div>
      </form>
    </div>
  </div>
  </NuxtLayout>
</template>

<script setup lang="ts">
import { PhFloppyDisk, PhUpload, PhX } from '@phosphor-icons/vue'

definePageMeta({
  layout: 'admin',
  middleware: 'auth'
})

const { createActivity, uploadActivityImage } = useActivities()
const toast = useToast()

const form = ref({
  title: '',
  description: '',
  date: '',
  time: '',
  location: 'Masjid Al-Furqon',
  category: 'kajian',
  is_published: true
})

const selectedImage = ref<File | null>(null)
const imagePreview = ref<string | null>(null)
const submitting = ref(false)
const fileInput = ref<HTMLInputElement>()

const handleImageChange = (event: Event) => {
  const target = event.target as HTMLInputElement
  const file = target.files?.[0]
  
  if (file) {
    // Validate file size (max 5MB)
    if (file.size > 5 * 1024 * 1024) {
      toast.error('Ukuran file terlalu besar. Maksimal 5MB.')
      return
    }
    
    selectedImage.value = file
    imagePreview.value = URL.createObjectURL(file)
  }
}

const removeImage = () => {
  if (imagePreview.value) {
    URL.revokeObjectURL(imagePreview.value)
  }
  selectedImage.value = null
  imagePreview.value = null
  if (fileInput.value) {
    fileInput.value.value = ''
  }
}

const handleSubmit = async () => {
  submitting.value = true
  let activityCreated = null
  
  try {
    console.log('Creating activity with data:', form.value)
    
    // Create activity first
    activityCreated = await createActivity({
      title: form.value.title,
      description: form.value.description,
      date: form.value.date,
      time: form.value.time || null,
      location: form.value.location,
      category: form.value.category,
      is_published: form.value.is_published,
      image_url: null
    })

    console.log('Activity created successfully:', activityCreated)

    // Upload image if exists (optional - tidak error jika gagal)
    if (selectedImage.value && activityCreated?.id) {
      try {
        console.log('Uploading image...')
        const imageUrl = await uploadActivityImage(selectedImage.value, activityCreated.id)
        console.log('Image uploaded successfully:', imageUrl)
        
        // Update activity with image URL
        await useActivities().updateActivity(activityCreated.id, {
          image_url: imageUrl
        })
        console.log('Activity updated with image URL')
      } catch (uploadError: any) {
        console.error('Error uploading image (non-critical):', uploadError)
        // Don't throw error, image is optional
        // Activity already created, just continue
      }
    }

    // Show success message
    toast.success('Kegiatan berhasil disimpan!')
    
    // Redirect to list
    await navigateTo('/admin/activities')
  } catch (error: any) {
    console.error('Error creating activity:', error)
    
    // If activity was created but image upload failed, still redirect
    if (activityCreated) {
      toast.warning('Kegiatan berhasil disimpan, tetapi foto gagal diupload. Anda bisa edit kegiatan untuk menambahkan foto.')
      await navigateTo('/admin/activities')
      return
    }
    
    // More detailed error message for create failure
    let errorMessage = 'Gagal menyimpan kegiatan. '
    
    if (error.message) {
      errorMessage += error.message
    }
    
    // Check for specific errors
    if (error.message?.includes('permission') || error.message?.includes('policy')) {
      errorMessage = 'Tidak ada izin untuk menyimpan data. Pastikan Anda sudah menjalankan SQL fix-policies.sql di Supabase SQL Editor.'
    } else if (error.message?.includes('violates') || error.message?.includes('constraint')) {
      errorMessage = 'Data tidak valid. Periksa format tanggal dan kategori.'
    } else if (error.code === '23505') {
      errorMessage = 'Data duplikat terdeteksi.'
    }
    
    toast.error(errorMessage)
  } finally {
    submitting.value = false
  }
}
</script>
