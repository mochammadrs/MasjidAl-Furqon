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

    <!-- Premium Form Card -->
    <div class="relative overflow-hidden">
      <!-- Background Gradient -->
      <div class="absolute inset-0 bg-gradient-to-br from-masjid-gold/5 via-masjid-cream/5 to-white rounded-2xl"></div>
      <div class="absolute -top-24 -right-24 w-48 h-48 bg-masjid-gold/10 rounded-full blur-3xl"></div>
      <div class="absolute -bottom-24 -left-24 w-48 h-48 bg-masjid-cream/10 rounded-full blur-3xl"></div>

      <div class="relative bg-white/80 backdrop-blur-xl rounded-2xl shadow-xl border border-white/60 p-8">
        <!-- Header with Icon -->
        <div class="flex items-center gap-4 mb-8 pb-6 border-b border-masjid-gold/20">
          <div class="w-12 h-12 rounded-xl bg-gradient-to-br from-masjid-gold to-masjid-dark flex items-center justify-center shadow-lg shadow-masjid-gold/20">
            <PhUser :size="24" weight="duotone" class="text-white" />
          </div>
          <div>
            <h2 class="text-2xl font-serif font-bold text-masjid-dark">
              Tambah Pengurus Baru
            </h2>
            <p class="text-sm text-gray-600 mt-1">Tambahkan pengurus masjid ke website</p>
          </div>
        </div>

        <form @submit.prevent="handleSubmit" class="space-y-6">
          <!-- Photo Upload Premium -->
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">
              Foto Pengurus
            </label>
            <div class="flex items-start gap-6">
              <!-- Preview Premium -->
              <div class="flex-shrink-0">
                <div class="relative w-32 h-32 rounded-full overflow-hidden border-4 border-masjid-gold/20 shadow-lg">
                  <div class="w-full h-full bg-gradient-to-br from-gray-100 to-gray-200 flex items-center justify-center">
                    <img
                      v-if="photoPreview"
                      :src="photoPreview"
                      alt="Preview"
                      class="w-full h-full object-cover"
                    />
                    <PhUser v-else :size="48" weight="duotone" class="text-gray-400" />
                  </div>
                </div>
              </div>
              <!-- Upload Controls Premium -->
              <div class="flex-1">
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
                  class="px-5 py-2.5 bg-gradient-to-r from-masjid-gold/10 to-masjid-cream/10 hover:from-masjid-gold/20 hover:to-masjid-cream/20 text-masjid-dark font-semibold rounded-lg border-2 border-masjid-gold/30 transition-all duration-300 shadow-sm"
                >
                  Pilih Foto
                </button>
                <p class="text-xs text-gray-600 mt-3">
                  Format: JPG, PNG. Maksimal 2MB<br>Rekomendasi: 500x500px (foto bulat)
                </p>
                <button
                  v-if="photoPreview"
                  type="button"
                  @click="removePhoto"
                  class="text-sm font-medium text-red-600 hover:text-red-700 mt-3 transition-colors"
                >
                  ✕ Hapus Foto
                </button>
              </div>
            </div>
          </div>

          <!-- Name Premium -->
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">
              Nama Lengkap <span class="text-red-500">*</span>
            </label>
            <input
              v-model="form.name"
              type="text"
              required
              placeholder="Contoh: Ustadz Ahmad Hidayat"
              class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50"
            />
          </div>

          <!-- Position Premium -->
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">
              Jabatan <span class="text-red-500">*</span>
            </label>
            <input
              v-model="form.position"
              type="text"
              required
              placeholder="Contoh: Ketua Takmir"
              class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50"
            />
          </div>

          <!-- Contact Info Grid Premium -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="space-y-2">
              <label class="block text-sm font-semibold text-masjid-dark">
                Nomor Telepon
              </label>
              <input
                v-model="form.phone"
                type="tel"
                placeholder="08123456789"
                class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50"
              />
            </div>
            <div class="space-y-2">
              <label class="block text-sm font-semibold text-masjid-dark">
                Email
              </label>
              <input
                v-model="form.email"
                type="email"
                placeholder="email@example.com"
                class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50"
              />
            </div>
          </div>

          <!-- Bio Premium -->
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">
              Biografi Singkat
            </label>
            <textarea
              v-model="form.bio"
              rows="5"
              placeholder="Jelaskan latar belakang, pendidikan, atau pengalaman..."
              class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none resize-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50"
            ></textarea>
          </div>

          <!-- Display Order Premium -->
          <div class="space-y-2">
            <label class="block text-sm font-semibold text-masjid-dark">
              Urutan Tampilan <span class="text-red-500">*</span>
            </label>
            <input
              v-model.number="form.display_order"
              type="number"
              required
              min="1"
              placeholder="1"
              class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50"
            />
            <p class="text-xs text-gray-600 mt-1">
              Semakin kecil angka, semakin tinggi urutan tampilan
            </p>
          </div>

          <!-- Status Premium Checkbox -->
          <div class="bg-gradient-to-br from-masjid-gold/5 to-masjid-cream/5 rounded-xl p-5 border border-masjid-gold/20">
            <div class="flex items-start gap-4">
              <div class="relative flex items-center justify-center">
                <input
                  v-model="form.is_active"
                  type="checkbox"
                  id="isActive"
                  class="peer w-6 h-6 appearance-none border-2 border-gray-300 rounded-lg checked:bg-masjid-gold checked:border-masjid-gold cursor-pointer transition-all duration-300 focus:ring-4 focus:ring-masjid-gold/20"
                />
                <svg class="absolute w-4 h-4 text-white pointer-events-none hidden peer-checked:block" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M5 13l4 4L19 7"/>
                </svg>
              </div>
              <div class="flex-1">
                <label for="isActive" class="text-sm font-semibold text-masjid-dark cursor-pointer block mb-1">
                  Tampilkan di website (Aktif)
                </label>
                <p class="text-xs text-gray-600">Centang untuk menampilkan pengurus ini di halaman website</p>
              </div>
            </div>
          </div>

          <!-- Premium Action Buttons -->
          <div class="flex flex-col-reverse sm:flex-row gap-4 pt-6 border-t border-masjid-gold/20">
            <NuxtLink
              to="/admin/officials"
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
                Simpan Pengurus
              </span>
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PhUser, PhFloppyDisk } from '@phosphor-icons/vue'

definePageMeta({
  layout: 'admin',
  middleware: 'auth'
})

const { createOfficial, uploadOfficialPhoto } = useOfficials()
const toast = useToast()

const form = ref({
  name: '',
  position: '',
  phone: '',
  email: '',
  bio: '',
  display_order: 1,
  is_active: true
})

const photoInput = ref<HTMLInputElement>()
const photoFile = ref<File | null>(null)
const photoPreview = ref<string>('')
const submitting = ref(false)

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

const removePhoto = () => {
  photoFile.value = null
  photoPreview.value = ''
  if (photoInput.value) {
    photoInput.value.value = ''
  }
}

const handleSubmit = async () => {
  submitting.value = true

  try {
    // Create official without photo first
    const official = await createOfficial({
      name: form.value.name,
      position: form.value.position,
      phone: form.value.phone || null,
      email: form.value.email || null,
      bio: form.value.bio || null,
      display_order: form.value.display_order,
      is_active: form.value.is_active
    })

    // Upload photo if exists
    if (photoFile.value && official?.id) {
      try {
        await uploadOfficialPhoto(photoFile.value, official.id)
      } catch (uploadError) {
        console.error('Error uploading photo:', uploadError)
        // Don't fail the whole operation if photo upload fails
      }
    }

    toast.success('Pengurus berhasil ditambahkan!')
    
    // Redirect to list
    await navigateTo('/admin/officials')
  } catch (err: any) {
    console.error('Error creating official:', err)
    toast.error(err.message || 'Gagal menyimpan data pengurus')
  } finally {
    submitting.value = false
  }
}
</script>
