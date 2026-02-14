<template>
  <div class="min-h-screen flex items-center justify-center bg-gradient-to-br from-masjid-dark via-[#3d2a1f] to-masjid-gold/40 px-4">
    <div class="max-w-md w-full">
      <!-- Logo & Title -->
      <div class="text-center mb-8">
        <div class="inline-flex items-center justify-center w-16 h-16 bg-white rounded-lg shadow-lg mb-4 overflow-hidden">
          <img src="/images/logo-masjid.png" alt="Logo Masjid Al-Furqon" class="w-full h-full object-cover" />
        </div>
        <h1 class="text-3xl font-serif font-bold text-white mb-2">
          Reset Password
        </h1>
        <p class="text-gray-300">
          Masukkan password baru Anda
        </p>
      </div>

      <!-- Form Card -->
      <div class="bg-white/95 backdrop-blur-lg rounded-2xl shadow-2xl p-8">
        <form v-if="!passwordReset" @submit.prevent="handleResetPassword" class="space-y-6">
          <!-- New Password Input -->
          <div>
            <label for="password" class="block text-sm font-medium text-masjid-dark mb-2">
              Password Baru
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
              Konfirmasi Password Baru
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

          <!-- Submit Button -->
          <button
            type="submit"
            :disabled="loading"
            class="w-full bg-masjid-gold hover:bg-masjid-dark text-white font-semibold py-3 rounded-lg transition-all duration-300 shadow-lg hover:shadow-xl disabled:opacity-50 disabled:cursor-not-allowed"
          >
            <span v-if="loading">Memproses...</span>
            <span v-else>Reset Password</span>
          </button>
        </form>

        <!-- Success Message -->
        <div v-else class="text-center py-4">
          <div class="inline-flex items-center justify-center w-16 h-16 bg-green-100 rounded-full mb-4">
            <svg class="w-8 h-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
            </svg>
          </div>
          <h3 class="text-xl font-bold text-masjid-dark mb-2">Password Berhasil Direset!</h3>
          <p class="text-masjid-text-muted mb-6">
            Password Anda telah berhasil diubah. Silakan login dengan password baru.
          </p>
          <NuxtLink
            to="/admin/login"
            class="inline-block px-6 py-2 bg-masjid-gold hover:bg-masjid-dark text-white rounded-lg transition-colors"
          >
            Login Sekarang
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
const password = ref('')
const confirmPassword = ref('')
const loading = ref(false)
const error = ref('')
const passwordReset = ref(false)

const handleResetPassword = async () => {
  error.value = ''

  // Validation
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
    const { error: updateError } = await supabase.auth.updateUser({
      password: password.value
    })

    if (updateError) throw updateError

    passwordReset.value = true
  } catch (err: any) {
    console.error('Reset password error:', err)
    error.value = err.message || 'Gagal reset password. Silakan coba lagi.'
  } finally {
    loading.value = false
  }
}

// Check if user has valid recovery token
onMounted(async () => {
  const { data } = await supabase.auth.getSession()
  if (!data.session) {
    error.value = 'Link reset password tidak valid atau sudah kadaluarsa. Silakan request ulang.'
  }
})
</script>
