/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./components/**/*.{js,vue,ts}",
    "./layouts/**/*.vue",
    "./pages/**/*.vue",
    "./plugins/**/*.{js,ts}",
    "./app.vue",
  ],
  theme: {
    extend: {
      colors: {
        'masjid-cream': '#FDFBF7',
        'masjid-gold': '#C6A87C',
        'masjid-gold-light': '#EADBC8',
        'masjid-dark': '#2E1F18',
        'masjid-card': '#FFFFFF',
        'masjid-text-muted': '#795548',
        'masjid-border': '#E5E7EB',
      },
      fontFamily: {
        'serif': ['Playfair Display', 'Georgia', 'serif'],
        'sans': ['Plus Jakarta Sans', 'Inter', 'system-ui', 'sans-serif'],
      },
    },
  },
  plugins: [],
}

