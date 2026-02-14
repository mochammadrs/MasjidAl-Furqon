# 🕌 MLP PLAN: MASJID AL-FURQON (FINAL UI VERSION)

> **Document Status:** Active / Locked V2
> **Role:** Fullstack Engineer (Solo)
> **Theme:** "Golden Sanctuary" (Cream, Gold, Dark Coffee)
> **Reference:** UI Screenshots (Feb 8, 2026)
> **Stack:** Nuxt 3 (SSR) + Tailwind CSS + Supabase

---

## 1. Project Identity & Vision
* **Project Name:** Masjid Al-Furqon Digital Ecosystem.
* **Tagline:** "Membangun Umat Berakhlak Mulia".
* **Visual Style:** Mewah, Hangat, Bersih. Dominasi warna Cream & Emas dengan kontras Cokelat Tua.
* **Key Value:** Informasi Realtime, Transparansi Donasi, dan Manajemen Kegiatan yang Rapi.

---

## 2. Tech Stack (Final Decision)
* **Frontend Framework:** **Nuxt 3** (Universal Rendering/SSR).
    * *Alasan:* SEO Friendly untuk pencarian Google & Performa tinggi.
* **Styling:** **Tailwind CSS** (Custom Config sesuai Screenshot).
* **Backend & Database:** **Supabase** (PostgreSQL).
    * *Fitur:* Auth (Email+Password untuk Admin), Database (Kegiatan/Pengurus), Storage (Upload Foto), Realtime Subscriptions.
* **Prayer API:** **MyQuran API** (Wrapper Kemenag) - Tasikmalaya (ID: 1209).
* **State Management:** **Pinia** (Untuk data reaktif seperti Jadwal Sholat & Countdown).
* **Icons:** `phosphor-icons` atau `heroicons` (Outline style).
* **Deployment:** **Netlify** (Custom Domain).
* **Location:** Tasikmalaya, West Java (Lat: -7.329991, Lng: 108.136580).

---

## 3. Design System (Based on Screenshots)

### Color Palette (Tailwind Config)
* **`masjid-cream`**: `#FDFBF7` (Background Utama Halaman - Warm White).
* **`masjid-gold`**: `#C6A87C` (Background TopBar, Tombol, Border Highlight).
* **`masjid-gold-light`**: `#EADBC8` (Background Section Label / Pill).
* **`masjid-dark`**: `#2E1F18` (Background Footer & Text Headings - Dark Coffee).
* **`masjid-card`**: `#FFFFFF` (Background Kartu Kegiatan/Jadwal).
* **`masjid-text-muted`**: `#795548` (Teks Deskripsi/Paragraf).
* **`masjid-border`**: `#E5E7EB` (Garis tipis pada kartu).

### Typography
* **Headings:** Serif Modern (*Playfair Display* / *Merriweather*) — Memberikan kesan institusi terpercaya dan elegan.
* **Body:** Sans-serif Clean (*Plus Jakarta Sans* / *Inter*) — Keterbacaan tinggi untuk konten panjang.

---

## 4. Functional Requirements (Detailed Scope)

### A. Header & Hero (The Hook)
1.  **Navbar:** Logo di kiri, Menu di kanan. Background solid putih dengan shadow.
2.  **Hero Section:** Background image gelap/lantern dengan teks sambutan "Selamat Datang di Masjid Al-Furqon".
3.  **Hero Overlay Stats:** 4 Kartu *Glassmorphism* (Semi-transparan) yang melayang di atas Hero Image (Statistik: Kajian Rutin, Jamaah Aktif, Program TPA, Kegiatan Sosial).

### B. Prayer & Stats Engine
1.  **Smart Prayer Widget:**
    * Tampilan 5 kotak waktu sholat berjejer horizontal.
    * **Active State Logic:** Waktu sholat berikutnya otomatis memiliki *Border Gold*, *Background Putih*, dan shadow, sedangkan waktu lain tampak flat/transparan.
    * **Info Detail:** Menampilkan Jam Adzan + Countdown menuju waktu sholat berikutnya.
    * **Data Source:** MyQuran API (Tasikmalaya - Kota ID: 1209).
2.  **Stats Counter:** Baris angka besar dengan animasi *count-up* (29th Tahun Berdiri, 800+ Keluarga, 150+ Santri).

### C. Content Sections
1.  **About Section:** Layout 2 Kolom.
    * Kiri: Foto Masjid + *Floating Card* Visi Misi.
    * Kanan: Teks Deskripsi + 3 Poin Keunggulan (Komunitas Hangat, Kajian Berkualitas, Peduli Sesama) dengan ikon.
2.  **Activity Grid:** Tampilan kartu kegiatan grid 3 kolom.
    * **Badge Kategori:** Label warna-warni (Biru untuk "Kajian Dewasa", Orange untuk "Pendidikan Anak", Abu untuk "Sosial").
    * **Info:** Judul, Jam, Pemateri, dan Poster.
3.  **Organization Structure:** Grid foto pengurus DKM (Foto bulat/kotak dengan nama dan jabatan).

### D. Donation & Footer
1.  **Donation Hub:**
    * **Bank Card:** Info No. Rekening BSI/Muamalat dengan style *Gold Gradient*.
    * **Fundraising Progress:** Bar chart visual (Target vs Terkumpul) untuk proyek khusus (misal: "Pembangunan Gedung Tahfizh"). Menampilkan persentase dan nominal terkumpul.
2.  **Gallery Grid:** Dokumentasi foto kegiatan dengan layout *Masonry* (susunan bata tidak rata) agar estetik.
3.  **Interactive Features:**
    * **WhatsApp Floating Button:** Tombol melayang untuk kontak langsung ke admin masjid.
    * **Share Jadwal Sholat:** Tombol download/share jadwal sholat sebagai image.
4.  **Footer:** Background Cokelat Tua (`#2E1F18`). 3 Kolom (Profile Masjid, Menu Cepat, Sosmed) + Copyright.

### E. Admin Features (Supabase CMS)
1.  **Authentication:** 
    * Email + Password login (`/admin/login`).
    * Fitur registrasi admin baru (untuk pergantian kepengurusan).
2.  **Activity Manager:** CRUD Kegiatan (Judul, Kategori, Tanggal, Poster).
3.  **Settings Manager:** Fitur untuk mengedit *Nominal Donasi* (Target & Terkumpul) dan pengaturan site metadata.
4.  **Officials Manager:** CRUD Data Pengurus DKM.

---

## 5. Database Schema (Supabase)

1.  **`settings`** (Dynamic Config):
    * `key` (text - Primary Key): `fundraising_title`, `fundraising_target`, `fundraising_current`, `whatsapp_contact`, `og_image`, `meta_description`.
    * `value` (text/json): Isi teks atau nominal uang.
2.  **`activities`**:
    * `id`, `title`, `category` (Enum: Kajian, TPA, Sosial, Ibadah), `category_color` (Hex code), `date`, `time`, `lecturer`, `poster_url`, `created_at`, `updated_at`.
3.  **`officials`** (Pengurus):
    * `id`, `name`, `position` (Jabatan), `photo_url`, `order_rank`, `created_at`.
4.  **`gallery`**:
    * `id`, `image_url`, `caption`, `created_at`.
5.  **`users`** (Admin - Managed by Supabase Auth):
    * `id`, `email`, `role` (default: 'admin'), `created_at`.

---

## 6. Clean Architecture Structure

```text
/masjid-alfurqan
├── components/
│   ├── layout/
│   │   ├── Navbar.vue           # Solid White Navbar
│   │   ├── AppFooter.vue        # Dark Brown Footer
│   │   └── WhatsAppButton.vue   # Floating Contact Button
│   ├── home/
│   │   ├── HeroSection.vue      # Image + Overlay Cards
│   │   ├── StatsRow.vue         # Counter Animation
│   │   ├── ActivityGrid.vue     # Card with Badges
│   │   └── DonationRow.vue      # Bank Info + Progress Bar
│   ├── prayer/
│   │   ├── PrayerWidget.vue     # 5 Card Row (Active Logic)
│   │   └── SharePrayerButton.vue # Share/Download Schedule
│   └── ui/
│       ├── SectionLabel.vue     # Pill Shape Label
│       ├── BaseButton.vue       # Gold Button
│       └── Badge.vue            # Category Badge
├── composables/
│   ├── usePrayerTimes.ts        # MyQuran API Integration
│   ├── useSiteConfig.ts         # Fetch Settings from Supabase
│   ├── useActivities.ts         # Fetch Activities
│   └── useShare.ts              # Share/Download Logic
├── pages/
│   ├── admin/                   # CMS Area (Protected)
│   │   ├── index.vue            # Dashboard
│   │   ├── login.vue            # Email+Password Auth
│   │   ├── register.vue         # New Admin Registration
│   │   ├── activities.vue       # CRUD Kegiatan
│   │   ├── officials.vue        # CRUD Pengurus
│   │   └── settings.vue         # Edit Donasi & Metadata
│   └── index.vue                # Main Landing Page
├── server/api/                  # Backend Routes
│   └── prayer.ts                # MyQuran API Proxy
├── middleware/
│   └── auth.ts                  # Admin Route Protection
└── nuxt.config.ts

```

---

## 7. Sprint Execution Plan

### 🏃 Sprint 1: Visual Structure (Frontend Focus)
**Goal:** Pixel Perfect dengan Screenshot Desain (Static Data).

* [ ] **Setup Foundation:**
    * [ ] Init Nuxt 3 & Install Tailwind CSS.
    * [ ] Config `tailwind.config.ts`: Masukkan warna `masjid-gold` (#C6A87C), `masjid-cream` (#FDFBF7), dan `masjid-dark` (#2E1F18).
    * [ ] Setup Fonts: *Playfair Display* (Headings) & *Plus Jakarta Sans* (Body) via Google Fonts.
    * [ ] Install dependencies: Supabase Client, Pinia, Phosphor Icons.
* [ ] **Layouting:**
    * [ ] Buat `Navbar.vue`: Solid white background dengan shadow.
    * [ ] Buat `AppFooter.vue`: Background Cokelat Tua dengan 3 kolom.
    * [ ] Buat `WhatsAppButton.vue`: Floating button di kanan bawah.
* [ ] **Hero & Stats (Complex):**
    * [ ] Implementasi `HeroSection.vue`: Background image gelap + Teks Sambutan.
    * [ ] **Challenge:** Buat *Overlay Stats Grid* (4 kartu glassmorphism) yang melayang di atas perbatasan Hero dan konten bawahnya (menggunakan negative margin/Z-index).
* [ ] **Widgets UI:**
    * [ ] Buat `PrayerWidget.vue`: Styling kartu jadwal sholat. Fokus pada *Active State* (Border Gold + Background Putih).
    * [ ] Buat `SharePrayerButton.vue`: Tombol share/download jadwal.
    * [ ] Buat `DonationRow.vue`: Styling *Progress Bar* (Target vs Terkumpul) dan Kartu Rekening Gradient.

### 🏃 Sprint 2: The Brain (Logic & Backend)
**Goal:** Membuat data menjadi dinamis & Admin Panel.

* [ ] **Supabase Setup:**
    * [ ] Create Project.
    * [ ] Create Table `settings` (Donasi, WhatsApp, Metadata).
    * [ ] Create Table `activities` (Enum: Kajian, TPA, Sosial, Ibadah).
    * [ ] Create Table `officials` (Data Pengurus DKM).
    * [ ] Create Table `gallery` (Dokumentasi foto kegiatan).
    * [ ] Setup Storage Buckets: `/photos/activities`, `/photos/officials`, `/photos/gallery`, `/photos/hero`.
    * [ ] Enable Row Level Security (RLS) & Policies.
* [ ] **Prayer Engine:**
    * [ ] Integrasi **MyQuran API** (Tasikmalaya - ID: 1209) di `usePrayerTimes.ts`.
    * [ ] Logic Countdown: Hitung selisih waktu sekarang dengan waktu sholat berikutnya.
    * [ ] Error handling & fallback jika API gagal.
* [ ] **Dynamic Content:**
    * [ ] Fetch *Progress Bar Donasi* (Target & Terkumpul) dari tabel `settings`.
    * [ ] Fetch *WhatsApp Contact* dari tabel `settings`.
    * [ ] Fetch *Activities* dengan filter kategori.
    * [ ] Fetch *Officials* dengan sorting by `order_rank`.
* [ ] **Admin Features:**
    * [ ] Halaman Login (`/admin/login`) - Email+Password Auth.
    * [ ] Halaman Register (`/admin/register`) - Untuk admin baru.
    * [ ] Middleware Auth (Proteksi rute admin).
    * [ ] CRUD Activities dengan upload poster.
    * [ ] CRUD Officials dengan upload foto.

### 🏃 Sprint 3: Polish, Content & Deploy
**Goal:** Finishing Touch & Go Live.

* [ ] **Content Injection:**
    * [ ] Input data kegiatan & pengurus dummy/asli via Admin.
    * [ ] Upload foto-foto galeri masonry.
    * [ ] Input setting: Nominal donasi, WhatsApp contact, Meta description.
* [ ] **Interactivity:**
    * [ ] Animasi *Count Up* pada angka statistik (0 -> 800+).
    * [ ] Transisi halus saat *hover* pada Activity Card.
    * [ ] Implement WhatsApp floating button dengan smooth animation.
    * [ ] Implement Share/Download jadwal sholat feature.
* [ ] **SEO Optimization:**
    * [ ] Setup meta tags (OG Image, Description, Keywords).
    * [ ] Generate sitemap.xml & robots.txt.
    * [ ] Structured data (JSON-LD) untuk Organization & Event.
* [ ] **Error Handling:**
    * [ ] Skeleton loading untuk fetch data dari Supabase.
    * [ ] Fallback UI kalau MyQuran API gagal (tampilkan waktu default).
    * [ ] 404 Page custom dengan navigasi kembali.
* [ ] **Analytics (Optional):**
    * [ ] Setup Google Analytics atau privacy-friendly alternative.
* [ ] **Responsive Check:**
    * [ ] Pastikan *Overlay Hero* menumpuk vertikal (stack) dengan rapi di layar HP.
    * [ ] Pastikan tabel/grid jadwal sholat bisa di-scroll horizontal di layar kecil.
    * [ ] Test di berbagai device (Mobile, Tablet, Desktop).
* [ ] **Performance:**
    * [ ] Optimize images (WebP format, lazy loading).
    * [ ] Check Lighthouse score (Target: >90 Performance & SEO).
* [ ] **Deploy:** 
    * [ ] Push ke GitHub.
    * [ ] Connect ke **Netlify** dengan custom domain.
    * [ ] Setup environment variables (Supabase keys).
    * [ ] SSL Certificate & DNS configuration.

---

## 8. Definition of Done (DoD)

Sebuah fitur atau sprint dianggap selesai jika memenuhi kriteria berikut:

* [ ] **Visual Accuracy:** Tampilan 100% sesuai screenshot referensi (Warna Cream/Gold, Footer Cokelat, Font Serif).
* [ ] **Jadwal Sholat:** Waktu sholat akurat via MyQuran API (Tasikmalaya), dan penanda "Waktu Berikutnya" berpindah otomatis.
* [ ] **Dynamic Control:** Admin bisa mengubah *Angka Donasi*, *Data Kegiatan*, dan *Pengurus* tanpa menyentuh kodingan.
* [ ] **Interactive Features:** WhatsApp floating button berfungsi, Share jadwal sholat berfungsi.
* [ ] **Mobile Responsive:** Layout tidak pecah di ukuran layar 360px (Android standar) hingga 1920px.
* [ ] **Error Handling:** Semua API call memiliki fallback UI (skeleton/error state).
* [ ] **SEO Ready:** Meta tags lengkap, sitemap generated, structured data implemented.
* [ ] **Clean Code:** Tidak ada error TypeScript (`nuxi typecheck` passed) dan tidak ada `console.log` sisa debugging.
* [ ] **Performance:** Skor Lighthouse (Performance & SEO) hijau (>90).
* [ ] **Deployment:** Live di Netlify dengan custom domain & SSL aktif.