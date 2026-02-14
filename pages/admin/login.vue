<template>
  <div class="min-h-screen flex items-center justify-center bg-gradient-to-br from-masjid-dark via-[#3d2a1f] to-masjid-gold/40 px-4">
    <div class="max-w-md w-full">
      <!-- Logo & Title -->
      <div class="text-center mb-8">
        <div class="inline-flex items-center justify-center w-16 h-16 bg-white rounded-lg shadow-lg mb-4 overflow-hidden">
          <img src="/images/logo-masjid.png" alt="Logo Masjid Al-Furqon" class="w-full h-full object-cover" />
        </div>
        <h1 class="text-3xl font-serif font-bold text-white mb-2">
          Admin Panel
        </h1>
        <p class="text-gray-300">
          Masjid Al-Furqon Tasikmalaya
        </p>
      </div>

      <!-- Login Form Card -->
      <div class="bg-white/95 backdrop-blur-lg rounded-2xl shadow-2xl p-8">
        <form @submit.prevent="handleLogin" class="space-y-6">
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
            <div class="flex items-center justify-between mb-2">
              <label for="password" class="block text-sm font-medium text-masjid-dark">
                Password
              </label>
              <NuxtLink
                to="/admin/forgot-password"
                class="text-xs text-masjid-gold hover:text-masjid-dark transition-colors"
              >
                Lupa Password?
              </NuxtLink>
            </div>
            <input
              id="password"
              v-model="password"
              type="password"
              required
              placeholder="••••••••"
              class="w-full px-4 py-3 rounded-lg border border-masjid-border focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
            />
          </div>

          <!-- Error Message -->
          <div v-if="errorMessage" class="bg-red-50 border border-red-200 rounded-lg p-3">
            <p class="text-sm text-red-600">{{ errorMessage }}</p>
          </div>

          <!-- Login Button -->
          <button
            type="submit"
            :disabled="loginLoading"
            class="w-full bg-masjid-gold hover:bg-masjid-dark text-white font-semibold py-3 rounded-lg transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed shadow-lg hover:shadow-xl"
          >
            <span v-if="!loginLoading">Masuk</span>
            <span v-else class="flex items-center justify-center gap-2">
              <svg class="animate-spin h-5 w-5" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4" fill="none"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
              Memproses...
            </span>
          </button>
        </form>

        <!-- Info -->
        <div class="mt-6 pt-6 border-t border-masjid-border">
          <div class="flex items-center justify-center gap-2 mb-3">
            <PhLock :size="14" class="text-masjid-text-muted" />
            <p class="text-xs text-center text-masjid-text-muted">
              Akses terbatas untuk admin masjid
            </p>
          </div>
          <p class="text-sm text-center text-masjid-text-muted">
            Belum punya akun?
            <NuxtLink
              to="/admin/register"
              class="text-masjid-gold hover:text-masjid-dark font-semibold transition-colors ml-1"
            >
              Daftar di sini
            </NuxtLink>
          </p>
        </div>
      </div>

      <!-- Back to Home -->
      <div class="text-center mt-6">
        <NuxtLink 
          to="/" 
          class="text-sm text-gray-300 hover:text-white transition-colors"
        >
          ← Kembali ke Beranda
        </NuxtLink>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PhLock } from '@phosphor-icons/vue'

definePageMeta({
  layout: false,
  middleware: 'auth'
})

const email = ref('')
const password = ref('')
const loginLoading = ref(false)
const errorMessage = ref('')

const { login } = useAuth()

const handleLogin = async () => {
  loginLoading.value = true
  errorMessage.value = ''

  try {
    await login(email.value, password.value)
    await navigateTo('/admin/dashboard')
  } catch (error: any) {
    console.error('Login error:', error)
    errorMessage.value = error.message || 'Email atau password salah. Silakan coba lagi.'
  } finally {
    loginLoading.value = false
  }
}
</script>
