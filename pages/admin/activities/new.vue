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

    <!-- Premium Form Card with Glassmorphism -->
    <div class="relative overflow-hidden">
      <!-- Background Gradient Overlay -->
      <div class="absolute inset-0 bg-gradient-to-br from-masjid-gold/5 via-masjid-cream/5 to-white rounded-2xl"></div>
      
      <!-- Ambient Glow Decorations -->
      <div class="absolute -top-24 -right-24 w-48 h-48 bg-masjid-gold/10 rounded-full blur-3xl"></div>
      <div class="absolute -bottom-24 -left-24 w-48 h-48 bg-masjid-cream/10 rounded-full blur-3xl"></div>

      <!-- Main Form Card -->
      <div class="relative bg-white/80 backdrop-blur-xl rounded-2xl shadow-xl border border-white/60 p-8">
        <!-- Header with Icon -->
        <div class="flex items-center gap-4 mb-8 pb-6 border-b border-masjid-gold/20">
          <div class="w-12 h-12 rounded-xl bg-gradient-to-br from-masjid-gold to-masjid-dark flex items-center justify-center shadow-lg shadow-masjid-gold/20">
            <PhFloppyDisk :size="24" weight="duotone" class="text-white" />
          </div>
          <div>
            <h2 class="text-2xl font-serif font-bold text-masjid-dark">
              Tambah Kegiatan Baru
            </h2>
            <p class="text-sm text-gray-600 mt-1">Isi form di bawah untuk menambahkan kegiatan</p>
          </div>
        </div>

        <form @submit.prevent="handleSubmit" class="space-y-6">
          <!-- Title with Premium Input -->
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">
              Judul Kegiatan <span class="text-red-500">*</span>
            </label>
            <input
              v-model="form.title"
              type="text"
              required
              placeholder="Contoh: Kajian Rutin Ahad Pagi"
              class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50"
            />
          </div>

          <!-- Description with Premium Textarea -->
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">
              Deskripsi <span class="text-red-500">*</span>
            </label>
            <textarea
              v-model="form.description"
              required
              rows="5"
              placeholder="Jelaskan detail kegiatan seperti tema, pembicara, dan informasi penting lainnya..."
              class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none resize-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50"
            ></textarea>
          </div>

          <!-- Date & Time Grid -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="space-y-2">
              <label class="block text-sm font-semibold text-masjid-dark">
                Tanggal <span class="text-red-500">*</span>
              </label>
              <div class="relative">
                <input
                  v-model="form.date"
                  type="date"
                  required
                  class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none shadow-sm hover:border-masjid-gold/50"
                />
              </div>
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

          <!-- Location & Category Grid -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="space-y-2">
              <label class="block text-sm font-semibold text-masjid-dark">
                Lokasi
              </label>
              <input
                v-model="form.location"
                type="text"
                placeholder="Masjid Jamie Al-Furqon"
                class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50"
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

          <!-- Premium Image Upload Area -->
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">
              Foto Kegiatan
            </label>
            
            <!-- Upload Button with Glassmorphism -->
            <div v-if="!imagePreview" class="relative group">
              <input
                ref="fileInput"
                type="file"
                accept="image/*"
                @change="handleImageChange"
                class="absolute inset-0 w-full h-full opacity-0 cursor-pointer z-10"
              />
              <div class="relative overflow-hidden rounded-xl border-2 border-dashed border-gray-300 bg-gradient-to-br from-masjid-gold/5 to-masjid-cream/5 p-12 text-center group-hover:border-masjid-gold group-hover:bg-masjid-gold/10 transition-all duration-300">
                <!-- Upload Icon with Animation -->
                <div class="inline-flex items-center justify-center w-20 h-20 rounded-full bg-white/80 backdrop-blur-sm shadow-lg shadow-masjid-gold/10 mb-4 group-hover:scale-110 group-hover:shadow-masjid-gold/30 transition-all duration-300">
                  <PhUpload :size="36" weight="duotone" class="text-masjid-gold" />
                </div>
                <p class="text-base font-semibold text-masjid-dark mb-2">Klik untuk upload foto</p>
                <p class="text-sm text-gray-500">JPG, PNG (Maks. 5MB)</p>
                
                <!-- Decorative Elements -->
                <div class="absolute top-4 right-4 w-16 h-16 bg-masjid-gold/5 rounded-full blur-2xl"></div>
                <div class="absolute bottom-4 left-4 w-16 h-16 bg-masjid-cream/5 rounded-full blur-2xl"></div>
              </div>
            </div>

            <!-- Premium Image Preview -->
            <div v-else class="relative group">
              <div class="relative overflow-hidden rounded-xl border-2 border-masjid-gold/30 shadow-lg">
                <img
                  :src="imagePreview"
                  alt="Preview"
                  class="w-full h-72 object-cover"
                  loading="lazy"
                  decoding="async"
                />
                <!-- Glassmorphism Overlay on Hover -->
                <div class="absolute inset-0 bg-gradient-to-t from-black/50 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
                
                <!-- Delete Button Premium -->
                <button
                  type="button"
                  @click="removeImage"
                  class="absolute top-3 right-3 p-2.5 bg-red-500/90 backdrop-blur-sm hover:bg-red-600 text-white rounded-lg shadow-lg shadow-red-500/30 transition-all duration-300 hover:scale-110"
                >
                  <PhX :size="20" weight="bold" />
                </button>

                <!-- Success Badge -->
                <div class="absolute bottom-3 left-3 px-4 py-2 bg-green-500/90 backdrop-blur-sm text-white text-sm font-medium rounded-lg shadow-lg flex items-center gap-2">
                  <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                  </svg>
                  Foto siap diupload
                </div>
              </div>
            </div>
          </div>

          <!-- Premium Checkbox for Publish Status -->
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
                <p class="text-xs text-gray-600">Centang untuk langsung menampilkan kegiatan ini di halaman website</p>
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
              <span v-else class="flex items-center justify-center gap-2">
                <PhFloppyDisk :size="20" weight="fill" />
                Simpan Kegiatan
              </span>
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
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
  location: 'Masjid Jamie Al-Furqon',
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
