# Setup Storage Buckets di Supabase

Ikuti langkah-langkah berikut untuk membuat storage buckets:

## 📦 Cara Setup Storage Buckets:

1. **Buka Supabase Dashboard**: https://supabase.com/dashboard/project/pgfeiswjetnjqkzgqghu

2. **Masuk ke Storage**:
   - Klik menu **"Storage"** di sidebar kiri
   - Klik tombol **"Create a new bucket"**

3. **Buat 4 Buckets Berikut**:

### Bucket 1: `photos`
- **Name**: `photos`
- **Public bucket**: ✅ **CENTANG** (agar foto bisa diakses publik)
- **File size limit**: 5MB
- **Allowed MIME types**: `image/*`
- Klik **"Create bucket"**

4. **Setelah bucket `photos` dibuat, buat folder di dalamnya**:
   - Klik bucket `photos`
   - Klik **"Create folder"**
   - Buat 4 folder:
     - `activities` (untuk foto kegiatan)
     - `officials` (untuk foto pengurus)
     - `gallery` (untuk galeri foto)
     - `hero` (untuk hero image masjid)

## ✅ Verifikasi:

Setelah selesai, Anda harus punya:
```
📦 photos (public bucket)
   📁 activities/
   📁 officials/
   📁 gallery/
   📁 hero/
```

## 🔧 Setup Policies (Opsional - untuk keamanan extra):

Di tab **"Policies"** pada bucket `photos`, pastikan policy-nya:
- **SELECT (read)**: Public (semua orang bisa baca)
- **INSERT/UPDATE/DELETE**: Authenticated users only (hanya admin yang login)

Supabase biasanya sudah auto-set policy untuk public bucket, jadi langkah ini optional.

---

**Setelah selesai, screenshot bucket `photos` dengan 4 folder di dalamnya!** 📸
