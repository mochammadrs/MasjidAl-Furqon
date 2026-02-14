<template>
  <div class="min-h-screen flex items-center justify-center bg-gradient-to-br from-masjid-dark via-[#3d2a1f] to-masjid-gold/40 px-4">
    <div class="max-w-md w-full">
      <!-- Logo & Title -->
      <div class="text-center mb-8">
        <div class="inline-flex items-center justify-center w-16 h-16 bg-white rounded-lg shadow-lg mb-4 overflow-hidden">
          <img src="/images/logo-masjid.png" alt="Logo Masjid Al-Furqon" class="w-full h-full object-cover" />
        </div>
        <h1 class="text-3xl font-serif font-bold text-white mb-2">
          Daftar Admin
        </h1>
        <p class="text-gray-300">
          Masjid Al-Furqon Tasikmalaya
        </p>
      </div>

      <!-- Register Form Card -->
      <div class="bg-white/95 backdrop-blur-lg rounded-2xl shadow-2xl p-8">
        <form @submit.prevent="handleRegister" class="space-y-6">
          <!-- Display Name Input -->
          <div>
            <label for="displayName" class="block text-sm font-medium text-masjid-dark mb-2">
              Nama Lengkap
            </label>
            <input
              id="displayName"
              v-model="displayName"
              type="text"
              required
              placeholder="Ahmad Rizky"
              class="w-full px-4 py-3 rounded-lg border border-masjid-border focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
            />
          </div>

          <!-- Email Input -->
          <div>
            <label for="email" class="block text-sm font-medium text-masjid-dark mb-2">
              Email
            </label>
            <input
              id="email"
              v-model="email"
              type="email"
              required
              placeholder="admin@masjid-alfurqan.com"
              class="w-full px-4 py-3 rounded-lg border border-masjid-border focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
            />
          </div>

          <!-- Password Input -->
          <div>
            <label for="password" class="block text-sm font-medium text-masjid-dark mb-2">
              Password
            </label>
            <input
              id="password"
              v-model="password"
              type="password"
              required
              placeholder="••••••••"
              minlength="6"
              class="w-full px-4 py-3 rounded-lg border border-masjid-border focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
            />
            <p class="text-xs text-masjid-text-muted mt-1">Minimal 6 karakter</p>
          </div>

          <!-- Confirm Password Input -->
          <div>
            <label for="confirmPassword" class="block text-sm font-medium text-masjid-dark mb-2">
              Konfirmasi Password
            </label>
            <input
              id="confirmPassword"
              v-model="confirmPassword"
              type="password"
              required
              placeholder="••••••••"
              class="w-full px-4 py-3 rounded-lg border border-masjid-border focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
            />
          </div>

          <!-- Error Message -->
          <div
            v-if="error"
            class="bg-red-50 border border-red-200 text-red-600 px-4 py-3 rounded-lg text-sm"
          >
            {{ error }}
          </div>

          <!-- Success Message -->
          <div
            v-if="success"
            class="bg-green-50 border border-green-200 text-green-600 px-4 py-3 rounded-lg text-sm"
          >
            {{ success }}
          </div>

          <!-- Register Button -->
          <button
            type="submit"
            :disabled="loading"
            class="w-full bg-masjid-gold hover:bg-masjid-dark text-white font-semibold py-3 rounded-lg transition-all duration-300 shadow-lg hover:shadow-xl disabled:opacity-50 disabled:cursor-not-allowed"
          >
            <span v-if="loading">Mendaftar...</span>
            <span v-else>Daftar Sekarang</span>
          </button>
        </form>

        <!-- Login Link -->
        <div class="mt-6 text-center">
          <p class="text-sm text-masjid-text-muted">
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
