<template>
  <div class="min-h-screen flex items-center justify-center bg-gradient-to-br from-masjid-dark via-[#3d2a1f] to-masjid-gold/40 px-4">
    <div class="max-w-md w-full">
      <!-- Logo & Title -->
      <div class="text-center mb-8">
        <div class="inline-flex items-center justify-center w-16 h-16 bg-white rounded-lg shadow-lg mb-4 overflow-hidden">
          <img src="/images/logo-masjid.png" alt="Logo Masjid Jamie Al-Furqon" class="w-full h-full object-cover" />
        </div>
        <h1 class="text-3xl font-serif font-bold text-white mb-2">
          Daftar Admin
        </h1>
        <p class="text-gray-300">
          Masjid Jamie Al-Furqon Tasikmalaya
        </p>
      </div>

      <!-- Register Form Card with Premium Design -->
      <div class="relative overflow-hidden">
        <!-- Background Gradient -->
        <div class="absolute inset-0 bg-gradient-to-br from-white via-masjid-gold/5 to-masjid-cream/10 rounded-2xl"></div>
        
        <!-- Ambient Glows -->
        <div class="absolute -top-20 -right-20 w-40 h-40 bg-masjid-gold/20 rounded-full blur-3xl"></div>
        <div class="absolute -bottom-20 -left-20 w-40 h-40 bg-masjid-cream/20 rounded-full blur-3xl"></div>

        <div class="relative bg-white/95 backdrop-blur-xl rounded-2xl shadow-2xl border border-white/60 p-8">
          <form @submit.prevent="handleRegister" class="space-y-5">
            <!-- Display Name Input Premium -->
            <div class="space-y-2">
              <label for="displayName" class="block text-sm font-semibold text-masjid-dark">
                Nama Lengkap <span class="text-red-500">*</span>
              </label>
              <input
                id="displayName"
                v-model="displayName"
                type="text"
                required
                placeholder="Ahmad Rizky"
                class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50"
              />
            </div>

            <!-- Email Input Premium -->
            <div class="space-y-2">
              <label for="email" class="block text-sm font-semibold text-masjid-dark">
                Email <span class="text-red-500">*</span>
              </label>
              <input
                id="email"
                v-model="email"
                type="email"
                required
                placeholder="admin@masjid-alfurqan.com"
                class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50"
              />
            </div>

            <!-- Password Input Premium -->
            <div class="space-y-2">
              <label for="password" class="block text-sm font-semibold text-masjid-dark">
                Password <span class="text-red-500">*</span>
              </label>
              <input
                id="password"
                v-model="password"
                type="password"
                required
                placeholder="••••••••"
                minlength="6"
                class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50"
              />
              <p class="text-xs text-gray-600 mt-1">Minimal 6 karakter</p>
            </div>

            <!-- Confirm Password Input Premium -->
            <div class="space-y-2">
              <label for="confirmPassword" class="block text-sm font-semibold text-masjid-dark">
                Konfirmasi Password <span class="text-red-500">*</span>
              </label>
              <input
                id="confirmPassword"
                v-model="confirmPassword"
                type="password"
                required
                placeholder="••••••••"
                class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50"
              />
            </div>

            <!-- Error Message Premium -->
            <div
              v-if="error"
              class="bg-red-50/80 backdrop-blur-sm border-2 border-red-200 text-red-600 px-4 py-3 rounded-xl text-sm font-medium"
            >
              {{ error }}
            </div>

            <!-- Success Message Premium -->
            <div
              v-if="success"
              class="bg-green-50/80 backdrop-blur-sm border-2 border-green-200 text-green-600 px-4 py-3 rounded-xl text-sm font-medium"
            >
              {{ success }}
            </div>

            <!-- Register Button Premium -->
            <button
              type="submit"
              :disabled="loading"
              class="w-full px-6 py-3.5 bg-gradient-to-r from-masjid-gold to-masjid-dark hover:from-masjid-dark hover:to-masjid-gold text-white font-semibold rounded-xl transition-all duration-300 shadow-lg shadow-masjid-gold/30 hover:shadow-xl hover:shadow-masjid-gold/40 disabled:opacity-50 disabled:cursor-not-allowed hover:scale-[1.02] active:scale-[0.98]"
            >
              <span v-if="loading" class="flex items-center justify-center gap-2">
                <svg class="animate-spin h-5 w-5" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4" fill="none"></circle>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                </svg>
                Mendaftar...
              </span>
              <span v-else>Daftar Sekarang</span>
            </button>
          </form>

          <!-- Login Link -->
          <div class="mt-6 pt-6 border-t border-masjid-gold/20 text-center">
            <p class="text-sm text-gray-600">
              Sudah punya akun?
              <NuxtLink
                to="/admin/login"
                class="text-masjid-gold hover:text-masjid-dark font-semibold transition-colors ml-1"
              >
                Login di sini
              </NuxtLink>
            </p>
          </div>
        </div>
      </div>

      <!-- Footer Note -->
      <div class="text-center mt-6 text-sm text-gray-300">
        <p>Hanya untuk administrator masjid</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
definePageMeta({
  layout: false
})

const { register } = useAuth()
const router = useRouter()

const displayName = ref('')
const email = ref('')
const password = ref('')
const confirmPassword = ref('')
const loading = ref(false)
const error = ref('')
const success = ref('')

const handleRegister = async () => {
  error.value = ''
  success.value = ''

  // Validation
  if (!displayName.value.trim()) {
    error.value = 'Nama lengkap harus diisi'
    return
  }

  if (password.value.length < 6) {
    error.value = 'Password minimal 6 karakter'
    return
  }

  if (password.value !== confirmPassword.value) {
    error.value = 'Password dan konfirmasi password tidak cocok'
    return
  }

  loading.value = true

  try {
    await register(email.value, password.value, displayName.value)
    success.value = 'Pendaftaran berhasil! Silakan cek email untuk verifikasi.'
    
    // Redirect to login after 2 seconds
    setTimeout(() => {
      router.push('/admin/login')
    }, 2000)
  } catch (err: any) {
    console.error('Registration error:', err)
    
    if (err.message?.includes('already registered')) {
      error.value = 'Email sudah terdaftar'
    } else if (err.message?.includes('invalid email')) {
      error.value = 'Format email tidak valid'
    } else {
      error.value = err.message || 'Pendaftaran gagal. Silakan coba lagi.'
    }
  } finally {
    loading.value = false
  }
}
</script>
