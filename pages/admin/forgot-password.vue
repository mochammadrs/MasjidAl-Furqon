<template>
  <div class="min-h-screen flex items-center justify-center bg-gradient-to-br from-masjid-dark via-[#3d2a1f] to-masjid-gold/40 px-4">
    <div class="max-w-md w-full">
      <!-- Logo & Title -->
      <div class="text-center mb-8">
        <div class="inline-flex items-center justify-center w-16 h-16 bg-white rounded-lg shadow-lg mb-4 overflow-hidden">
          <img src="/images/logo-masjid.png" alt="Logo Masjid Al-Furqon" class="w-full h-full object-cover" />
        </div>
        <h1 class="text-3xl font-serif font-bold text-white mb-2">
          Lupa Password
        </h1>
        <p class="text-gray-300">
          Masukkan email untuk reset password
        </p>
      </div>

      <!-- Form Card -->
      <div class="bg-white/95 backdrop-blur-lg rounded-2xl shadow-2xl p-8">
        <form v-if="!emailSent" @submit.prevent="handleForgotPassword" class="space-y-6">
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

          <!-- Error Message -->
          <div
            v-if="error"
            class="bg-red-50 border border-red-200 text-red-600 px-4 py-3 rounded-lg text-sm"
          >
            {{ error }}
          </div>

          <!-- Submit Button -->
          <button
            type="submit"
            :disabled="loading"
            class="w-full bg-masjid-gold hover:bg-masjid-dark text-white font-semibold py-3 rounded-lg transition-all duration-300 shadow-lg hover:shadow-xl disabled:opacity-50 disabled:cursor-not-allowed"
          >
            <span v-if="loading">Mengirim...</span>
            <span v-else>Kirim Link Reset Password</span>
          </button>
        </form>

        <!-- Success Message -->
        <div v-else class="text-center py-4">
          <div class="inline-flex items-center justify-center w-16 h-16 bg-green-100 rounded-full mb-4">
            <svg class="w-8 h-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
            </svg>
          </div>
          <h3 class="text-xl font-bold text-masjid-dark mb-2">Email Terkirim!</h3>
          <p class="text-masjid-text-muted mb-6">
            Link reset password telah dikirim ke <strong>{{ email }}</strong>. 
            Silakan cek inbox atau folder spam.
          </p>
          <NuxtLink
            to="/admin/login"
            class="inline-block px-6 py-2 bg-masjid-gold hover:bg-masjid-dark text-white rounded-lg transition-colors"
          >
            Kembali ke Login
          </NuxtLink>
        </div>

        <!-- Back to Login -->
        <div v-if="!emailSent" class="mt-6 text-center">
          <NuxtLink
            to="/admin/login"
            class="text-sm text-masjid-gold hover:text-masjid-dark transition-colors"
          >
            ← Kembali ke Login
          </NuxtLink>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
definePageMeta({
  layout: false
})

const supabase = useSupabase()
const email = ref('')
const loading = ref(false)
const error = ref('')
const emailSent = ref(false)

const handleForgotPassword = async () => {
  error.value = ''
  loading.value = true

  try {
    const { error: resetError } = await supabase.auth.resetPasswordForEmail(email.value, {
      redirectTo: `${window.location.origin}/admin/reset-password`
    })

    if (resetError) throw resetError

    emailSent.value = true
  } catch (err: any) {
    console.error('Forgot password error:', err)
    error.value = err.message || 'Gagal mengirim email reset password. Silakan coba lagi.'
  } finally {
    loading.value = false
  }
}
</script>
