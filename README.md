# 🕌 Masjid Al-Furqan - Official Website

[![Nuxt 3](https://img.shields.io/badge/Nuxt-3.x-00DC82?logo=nuxt.js)](https://nuxt.com)
[![Vue 3](https://img.shields.io/badge/Vue-3.x-4FC08D?logo=vue.js)](https://vuejs.org)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind-3.x-38B2AC?logo=tailwind-css)](https://tailwindcss.com)
[![Supabase](https://img.shields.io/badge/Supabase-Backend-3ECF8E?logo=supabase)](https://supabase.com)

Website resmi Masjid Al-Furqan, Perumahan Bukit Rancapaku Indah, Tasikmalaya. Platform digital untuk informasi jadwal sholat, kegiatan masjid, dan pengelolaan konten.

---

## ✨ Features

### 🏠 Public Website
- ✅ **Jadwal Sholat Real-time** - Auto-update berdasarkan lokasi Tasikmalaya
- ✅ **Informasi Kegiatan** - Kajian, sosial, pendidikan
- ✅ **Visi & Misi** - Profil masjid
- ✅ **Pengurus Masjid** - Struktur organisasi
- ✅ **Galeri Kegiatan** - Dokumentasi foto
- ✅ **Donasi & Infak** - Transfer bank & QRIS
- ✅ **Animasi Smooth** - 5 variasi scroll animations
- ✅ **Responsive Design** - Mobile, tablet, desktop

### 🔐 Admin Panel
- ✅ **Authentication** - Email confirmation & password reset
- ✅ **CRUD Operations** - Kegiatan, pengurus, galeri
- ✅ **Settings Management** - Visi/misi, donasi target
- ✅ **Image Upload** - Supabase Storage integration
- ✅ **Role-based Access** - Admin-only routes

### ⚡ Performance
- ✅ **Lighthouse Score:** 100/100 (Desktop), 97/100 (Mobile)
- ✅ **SEO Optimized:** Meta tags, sitemap, robots.txt
- ✅ **Fast Loading:** Code splitting, lazy loading
- ✅ **PWA Ready:** Offline capable

---

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ 
- npm/pnpm/yarn
- Git

### Installation

1. **Clone repository**
```bash
git clone https://github.com/YOUR_USERNAME/masjid-alfurqan.git
cd masjid-alfurqan
```

2. **Install dependencies**
```bash
npm install
```

3. **Setup environment variables**
```bash
cp .env.example .env
```

Edit `.env` dengan credentials Supabase Anda:
```env
SUPABASE_URL=your_supabase_project_url
SUPABASE_ANON_KEY=your_supabase_anon_key
```

4. **Run development server**
```bash
npm run dev
```

Buka http://localhost:3000 🎉

---

## 📁 Project Structure

```
masjid-alfurqan/
├── 📄 app.vue                 # Root component with global animations
├── 📄 error.vue               # Error page
├── 📂 assets/
│   └── css/main.css           # Global styles + Tailwind
├── 📂 components/
│   ├── home/                  # Homepage sections
│   ├── layout/                # Navbar, Footer, WhatsApp
│   ├── prayer/                # Prayer times widget
│   ├── skeleton/              # Loading skeletons
│   └── ui/                    # Reusable UI components
├── 📂 composables/            # Vue composables (useAuth, useActivities, etc)
├── 📂 database/               # Database setup SQL files
├── 📂 docs/                   # 📚 ALL DOCUMENTATION HERE
│   ├── DEPLOYMENT.md          # Full deployment guide
│   ├── DEPLOY_NOW.md          # Quick deploy steps
│   ├── SECURITY_CHECKLIST.md  # Security verification
│   └── ...other guides
├── 📂 layouts/
│   ├── default.vue            # Default layout
│   └── admin.vue              # Admin panel layout
├── 📂 middleware/
│   └── auth.ts                # Route protection
├── 📂 pages/                  # File-based routing
│   ├── index.vue              # Homepage
│   └── admin/                 # Admin pages
├── 📂 public/                 # Static assets
├── 📂 server/                 # Server routes (sitemap.xml)
├── 📂 supabase/               # Database schema & policies
└── 📄 nuxt.config.ts          # Nuxt configuration
```

---

## 🛠️ Tech Stack

| Category | Technology |
|----------|------------|
| **Frontend** | Nuxt 3, Vue 3, TypeScript |
| **Styling** | Tailwind CSS |
| **Backend** | Supabase (PostgreSQL) |
| **Authentication** | Supabase Auth |
| **Email** | Resend.com (SMTP) |
| **Icons** | Phosphor Icons |
| **Deployment** | Vercel/Netlify |

---

## 📚 Documentation

Semua dokumentasi ada di folder `docs/`:

- **[DEPLOY_NOW.md](docs/DEPLOY_NOW.md)** - Quick deployment guide (5 minutes)
- **[DEPLOYMENT.md](docs/DEPLOYMENT.md)** - Full deployment documentation
- **[SECURITY_CHECKLIST.md](docs/SECURITY_CHECKLIST.md)** - Security audit checklist
- **[EMAIL_SETUP_GUIDE.md](docs/EMAIL_SETUP_GUIDE.md)** - Email configuration
- **[RESEND_SETUP_GUIDE.md](docs/RESEND_SETUP_GUIDE.md)** - Resend.com setup
- **[SEO-OPTIMIZATION.md](docs/SEO-OPTIMIZATION.md)** - SEO implementation
- **[STORAGE_SETUP.md](docs/STORAGE_SETUP.md)** - Supabase storage setup

---

## 🔐 Security

- ✅ Environment variables for sensitive data
- ✅ `.env` gitignored (never committed)
- ✅ Supabase Row Level Security (RLS) policies
- ✅ Admin route protection with middleware
- ✅ CORS configuration
- ✅ API key rotation ready

See [SECURITY_CHECKLIST.md](docs/SECURITY_CHECKLIST.md) for details.

---

## 🚀 Deployment

### Quick Deploy to Vercel

1. Push code to GitHub
2. Import repository in Vercel
3. Add environment variables
4. Deploy!

**Full guide:** [docs/DEPLOY_NOW.md](docs/DEPLOY_NOW.md)

---

## 🧪 Development Commands

```bash
# Development server (hot reload)
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview

# Generate static site
npm run generate

# Type checking
npm run typecheck

# Linting
npm run lint
```

---

## 👥 Admin Credentials

**Login URL:** `/admin/login`

Contact project maintainer for admin credentials.

---

## 📞 Support & Contact

**Masjid Al-Furqan**  
Perumahan Bukit Rancapaku Indah, Tasikmalaya

**Developer:** Muhammad Rizky Septian  
**Email:** rizkyseptian401@gmail.com

---

## 📝 License

© 2026 Masjid Al-Furqan. All rights reserved.

---

## 🙏 Acknowledgments

Built with ❤️ for Masjid Al-Furqan community.

**Jazakumullah khairan kathira** to all contributors!

---

**Last Updated:** February 14, 2026

# yarn
yarn build

# bun
bun run build
```

Locally preview production build:

```bash
# npm
npm run preview

# pnpm
pnpm preview

# yarn
yarn preview

# bun
bun run preview
```

Check out the [deployment documentation](https://nuxt.com/docs/getting-started/deployment) for more information.
