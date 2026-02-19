<template>
  <div class="min-h-screen flex items-center justify-center bg-gradient-to-br from-masjid-dark via-[#3d2a1f] to-masjid-gold/40 px-4">
    <div class="max-w-md w-full">
      <!-- Logo & Title -->
      <div class="text-center mb-8">
        <div class="inline-flex items-center justify-center w-16 h-16 bg-white rounded-lg shadow-lg mb-4 overflow-hidden">
          <img src="/images/logo-masjid.png" alt="Logo Masjid Jamie Al-Furqon" class="w-full h-full object-cover" />
        </div>
        <h1 class="text-3xl font-serif font-bold text-white mb-2">
          Lupa Password
        </h1>
        <p class="text-gray-300">
          Masukkan email untuk reset password
        </p>
      </div>

      <!-- Form Card with Premium Design -->
      <div class="relative overflow-hidden">
        <!-- Background Gradient -->
        <div class="absolute inset-0 bg-gradient-to-br from-white via-masjid-gold/5 to-masjid-cream/10 rounded-2xl"></div>
        
        <!-- Ambient Glows -->
        <div class="absolute -top-20 -right-20 w-40 h-40 bg-masjid-gold/20 rounded-full blur-3xl"></div>
        <div class="absolute -bottom-20 -left-20 w-40 h-40 bg-masjid-cream/20 rounded-full blur-3xl"></div>

        <div class="relative bg-white/95 backdrop-blur-xl rounded-2xl shadow-2xl border border-white/60 p-8">
          <form v-if="!emailSent" @submit.prevent="handleForgotPassword" class="space-y-6">
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

            <!-- Error Message Premium -->
            <div
              v-if="error"
              class="bg-red-50/80 backdrop-blur-sm border-2 border-red-200 text-red-600 px-4 py-3 rounded-xl text-sm font-medium"
            >
              {{ error }}
            </div>

            <!-- Submit Button Premium -->
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
                Mengirim...
              </span>
              <span v-else>Kirim Link Reset Password</span>
            </button>
          </form>

          <!-- Success Message Premium -->
          <div v-else class="text-center py-4">
            <div class="inline-flex items-center justify-center w-20 h-20 bg-gradient-to-br from-green-400 to-green-600 rounded-full shadow-lg shadow-green-500/30 mb-4">
              <svg class="w-10 h-10 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M5 13l4 4L19 7"></path>
              </svg>
            </div>
            <h3 class="text-2xl font-serif font-bold text-masjid-dark mb-3">Email Terkirim!</h3>
            <p class="text-gray-600 mb-6 leading-relaxed">
              Link reset password telah dikirim ke <strong class="text-masjid-dark">{{ email }}</strong>. 
              <br>Silakan cek inbox atau folder spam.
            </p>
            <NuxtLink
              to="/admin/login"
              class="inline-block px-8 py-3 bg-gradient-to-r from-masjid-gold to-masjid-dark hover:from-masjid-dark hover:to-masjid-gold text-white font-semibold rounded-xl transition-all duration-300 shadow-lg shadow-masjid-gold/30 hover:shadow-xl hover:scale-105"
            >
              Kembali ke Login
            </NuxtLink>
          </div>

          <!-- Back to Login -->
          <div v-if="!emailSent" class="mt-6 pt-6 border-t border-masjid-gold/20 text-center">
            <NuxtLink
              to="/admin/login"
              class="text-sm font-medium text-masjid-gold hover:text-masjid-dark transition-colors inline-flex items-center gap-1"
            >
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
              </svg>
              Kembali ke Login
            </NuxtLink>
          </div>
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
