<template>
  <div class="max-w-4xl">
    <!-- Back Button Premium -->
    <div class="mb-6">
      <NuxtLink
        to="/admin/officials"
        class="group inline-flex items-center gap-2 px-4 py-2 rounded-lg bg-white/50 backdrop-blur-sm border border-masjid-gold/20 hover:bg-masjid-gold/10 hover:border-masjid-gold/40 transition-all duration-300"
      >
        <svg class="w-4 h-4 text-masjid-gold group-hover:-translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
        </svg>
        <span class="text-sm font-medium text-masjid-dark">Kembali ke Daftar Pengurus</span>
      </NuxtLink>
    </div>

    <div v-if="loading" class="flex justify-center items-center min-h-[400px]">
      <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-masjid-gold"></div>
    </div>

    <div v-else-if="!official" class="text-center py-16">
      <div class="inline-flex items-center justify-center w-20 h-20 rounded-2xl bg-gray-100 mb-5">
        <PhWarning :size="40" class="text-gray-400" />
      </div>
      <h2 class="text-2xl font-serif font-bold text-masjid-dark mb-3">
        Pengurus Tidak Ditemukan
      </h2>
      <NuxtLink
        to="/admin/officials"
        class="inline-block px-6 py-3 bg-masjid-gold hover:bg-masjid-dark text-white font-medium rounded-lg transition-colors"
      >
        ← Kembali ke Daftar
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
            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
            </svg>
          </div>
          <div>
            <h2 class="text-2xl font-serif font-bold text-masjid-dark">
              Edit Pengurus: {{ official.name }}
            </h2>
            <p class="text-sm text-gray-600 mt-1">Perbarui informasi pengurus</p>
          </div>
        </div>

        <form @submit.prevent="handleSubmit" class="space-y-6">
          <!-- Photo Upload Premium (same as new) -->
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">
              Foto Pengurus
            </label>
            <div class="flex items-start gap-6">
              <div class="flex-shrink-0">
                <div class="relative w-32 h-32 rounded-full overflow-hidden border-4 border-masjid-gold/20 shadow-lg">
                  <div class="w-full h-full bg-gradient-to-br from-gray-100 to-gray-200 flex items-center justify-center">
                    <img
                      v-if="photoPreview || form.photo_url"
                      :src="photoPreview || form.photo_url || ''"
                      alt="Preview"
                      class="w-full h-full object-cover"
                    />
                    <PhUser v-else :size="48" weight="duotone" class="text-gray-400" />
                  </div>
                </div>
              </div>
              <div class="flex-1">
                <input ref="photoInput" type="file" accept="image/*" @change="handlePhotoChange" class="hidden" />
                <button type="button" @click="photoInput?.click()" class="px-5 py-2.5 bg-gradient-to-r from-masjid-gold/10 to-masjid-cream/10 hover:from-masjid-gold/20 hover:to-masjid-cream/20 text-masjid-dark font-semibold rounded-lg border-2 border-masjid-gold/30 transition-all duration-300 shadow-sm">
                  {{ form.photo_url ? 'Ganti Foto' : 'Pilih Foto' }}
                </button>
                <p class="text-xs text-gray-600 mt-3">Format: JPG, PNG. Maksimal 2MB<br>Rekomendasi: 500x500px (foto bulat)</p>
                <button v-if="photoPreview || form.photo_url" type="button" @click="removePhoto" class="text-sm font-medium text-red-600 hover:text-red-700 mt-3 transition-colors">✕ Hapus Foto</button>
              </div>
            </div>
          </div>

          <!-- Name Premium -->
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">Nama Lengkap <span class="text-red-500">*</span></label>
            <input v-model="form.name" type="text" required placeholder="Contoh: Ustadz Ahmad Hidayat" class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50" />
          </div>

          <!-- Position Premium -->
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">Jabatan <span class="text-red-500">*</span></label>
            <input v-model="form.position" type="text" required placeholder="Contoh: Ketua Takmir" class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50" />
          </div>

          <!-- Contact Info Grid Premium -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="space-y-2">
              <label class="block text-sm font-semibold text-masjid-dark">Nomor Telepon</label>
              <input v-model="form.phone" type="tel" placeholder="08123456789" class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50" />
            </div>
            <div class="space-y-2">
              <label class="block text-sm font-semibold text-masjid-dark">Email</label>
              <input v-model="form.email" type="email" placeholder="email@example.com" class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50" />
            </div>
          </div>

          <!-- Bio Premium -->
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">Biografi Singkat</label>
            <textarea v-model="form.bio" rows="5" placeholder="Jelaskan latar belakang, pendidikan, atau pengalaman..." class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none resize-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50"></textarea>
          </div>

          <!-- Display Order Premium -->
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">Urutan Tampilan <span class="text-red-500">*</span></label>
            <input v-model.number="form.display_order" type="number" required min="1" placeholder="1" class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50" />
            <p class="text-xs text-gray-600 mt-1">Semakin kecil angka, semakin tinggi urutan tampilan</p>
          </div>

          <!-- Status Premium Checkbox (same) -->
          <div class="bg-gradient-to-br from-masjid-gold/5 to-masjid-cream/5 rounded-xl p-5 border border-masjid-gold/20">
            <div class="flex items-start gap-4">
              <div class="relative flex items-center justify-center">
                <input v-model="form.is_active" type="checkbox" id="isActiveEdit" class="peer w-6 h-6 appearance-none border-2 border-gray-300 rounded-lg checked:bg-masjid-gold checked:border-masjid-gold cursor-pointer transition-all duration-300 focus:ring-4 focus:ring-masjid-gold/20" />
                <svg class="absolute w-4 h-4 text-white pointer-events-none hidden peer-checked:block" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M5 13l4 4L19 7"/></svg>
              </div>
              <div class="flex-1">
                <label for="isActiveEdit" class="text-sm font-semibold text-masjid-dark cursor-pointer block mb-1">Tampilkan di website (Aktif)</label>
                <p class="text-xs text-gray-600">Centang untuk menampilkan pengurus ini di halaman website</p>
              </div>
            </div>
          </div>

          <!-- Premium Action Buttons -->
          <div class="flex flex-col-reverse sm:flex-row gap-4 pt-6 border-t border-masjid-gold/20">
            <NuxtLink to="/admin/officials" class="sm:w-40 px-6 py-3.5 bg-white border-2 border-gray-200 hover:border-gray-300 hover:bg-gray-50 text-gray-700 font-semibold rounded-xl transition-all duration-300 text-center shadow-sm">Batal</NuxtLink>
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
import { PhWarning, PhUser } from '@phosphor-icons/vue'

definePageMeta({
  layout: 'admin',
  middleware: 'auth'
})

const route = useRoute()
const { fetchOfficial, updateOfficial, uploadOfficialPhoto, deleteOfficialPhoto } = useOfficials()
const toast = useToast()

const officialId = computed(() => route.params.id as string)

const official = ref<any>(null)
const loading = ref(true)

const form = ref({
  name: '',
  position: '',
  phone: '',
  email: '',
  bio: '',
  display_order: 1,
  is_active: true,
  photo_url: ''
})

const photoInput = ref<HTMLInputElement>()
const photoFile = ref<File | null>(null)
const photoPreview = ref<string>('')
const submitting = ref(false)

// Fetch official data
const loadOfficial = async () => {
  loading.value = true
  try {
    const data = await fetchOfficial(officialId.value)
    if (data) {
      official.value = data
      form.value = {
        name: data.name || '',
        position: data.position || '',
        phone: data.phone || '',
        email: data.email || '',
        bio: data.bio || '',
        display_order: data.display_order || 1,
        is_active: data.is_active ?? true,
        photo_url: data.photo_url || ''
      }
    }
  } catch (err) {
    console.error('Error loading official:', err)
  } finally {
    loading.value = false
  }
}

const handlePhotoChange = (event: Event) => {
  const target = event.target as HTMLInputElement
  const file = target.files?.[0]
  
  if (!file) return

  // Validate file size (max 2MB)
  if (file.size > 2 * 1024 * 1024) {
    toast.error('Ukuran file terlalu besar. Maksimal 2MB.')
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
  if (form.value.photo_url) {
    const confirmed = confirm('Hapus foto yang sudah ada?')
    if (confirmed) {
      try {
        await deleteOfficialPhoto(form.value.photo_url)
        form.value.photo_url = ''
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
        if (form.value.photo_url) {
          await deleteOfficialPhoto(form.value.photo_url)
        }
        // Upload new photo
        await uploadOfficialPhoto(photoFile.value, officialId.value)
      } catch (uploadError) {
        console.error('Error uploading photo:', uploadError)
        // Don't fail the whole operation if photo upload fails
      }
    }

    // Update official data
    await updateOfficial(officialId.value, {
      name: form.value.name,
      position: form.value.position,
      phone: form.value.phone || null,
      email: form.value.email || null,
      bio: form.value.bio || null,
      display_order: form.value.display_order,
      is_active: form.value.is_active
    })

    toast.success('Perubahan berhasil disimpan!')
    
    // Redirect to list
    await navigateTo('/admin/officials')
  } catch (err: any) {
    console.error('Error updating official:', err)
    toast.error(err.message || 'Gagal menyimpan perubahan')
  } finally {
    submitting.value = false
  }
}

onMounted(() => {
  loadOfficial()
})
</script>
