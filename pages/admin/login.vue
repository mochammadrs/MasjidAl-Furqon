<template>
  <div class="min-h-screen flex items-center justify-center bg-gradient-to-br from-masjid-dark via-[#3d2a1f] to-masjid-gold/40 px-4">
    <div class="max-w-md w-full">
      <!-- Logo & Title -->
      <div class="text-center mb-8">
        <div class="inline-flex items-center justify-center w-16 h-16 bg-white rounded-lg shadow-lg mb-4 overflow-hidden">
          <img src="/images/logo-masjid.png" alt="Logo Masjid Jamie Al-Furqon" class="w-full h-full object-cover" />
        </div>
        <h1 class="text-3xl font-serif font-bold text-white mb-2">
          Admin Panel
        </h1>
        <p class="text-gray-300">
          Masjid Jamie Al-Furqon Tasikmalaya
        </p>
      </div>

      <!-- Login Form Card with Premium Design -->
      <div class="relative overflow-hidden">
        <!-- Background Gradient -->
        <div class="absolute inset-0 bg-gradient-to-br from-white via-masjid-gold/5 to-masjid-cream/10 rounded-2xl"></div>
        
        <!-- Ambient Glows -->
        <div class="absolute -top-20 -right-20 w-40 h-40 bg-masjid-gold/20 rounded-full blur-3xl"></div>
        <div class="absolute -bottom-20 -left-20 w-40 h-40 bg-masjid-cream/20 rounded-full blur-3xl"></div>

        <div class="relative bg-white/95 backdrop-blur-xl rounded-2xl shadow-2xl border border-white/60 p-8">
          <form @submit.prevent="handleLogin" class="space-y-6">
            <!-- Email Input Premium -->
            <div class="space-y-2">
              <label for="email" class="block text-sm font-semibold text-masjid-dark">
                Email
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
              <div class="flex items-center justify-between">
                <label for="password" class="block text-sm font-semibold text-masjid-dark">
                  Password
                </label>
                <NuxtLink
                  to="/admin/forgot-password"
                  class="text-xs font-medium text-masjid-gold hover:text-masjid-dark transition-colors"
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
                class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50"
              />
            </div>

            <!-- Error Message Premium -->
            <div v-if="errorMessage" class="bg-red-50/80 backdrop-blur-sm border-2 border-red-200 rounded-xl p-4">
              <p class="text-sm font-medium text-red-600">{{ errorMessage }}</p>
            </div>

            <!-- Login Button Premium -->
            <button
              type="submit"
              :disabled="loginLoading"
              class="w-full px-6 py-3.5 bg-gradient-to-r from-masjid-gold to-masjid-dark hover:from-masjid-dark hover:to-masjid-gold text-white font-semibold rounded-xl transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed shadow-lg shadow-masjid-gold/30 hover:shadow-xl hover:shadow-masjid-gold/40 hover:scale-[1.02] active:scale-[0.98]"
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
          <div class="mt-6 pt-6 border-t border-masjid-gold/20">
            <div class="flex items-center justify-center gap-2 mb-3">
              <PhLock :size="14" class="text-gray-500" />
              <p class="text-xs text-center text-gray-600">
                Akses terbatas untuk admin masjid
              </p>
            </div>
            <p class="text-sm text-center text-gray-600">
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
