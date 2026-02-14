# Setup Admin Display Name Feature

## 📋 Yang Sudah Dibuat

### 1. **Database Table: `admin_profiles`**
File: `database/create_admin_profiles.sql`

Struktur:
- `id` - UUID primary key
- `user_id` - Foreign key ke auth.users
- `display_name` - Nama yang ditampilkan (bukan email)
- `created_at` - Timestamp created
- `updated_at` - Auto-update saat ada perubahan

### 2. **Halaman Register Admin**
File: `pages/admin/register.vue`

Fitur:
- Form dengan Nama Lengkap, Email, Password
- Validasi (min 6 karakter, password match)
- Auto-create profile saat register
- Redirect ke login setelah sukses

### 3. **Update Composable `useAuth`**
File: `composables/useAuth.ts`

Perubahan:
- Tambah `profile` state untuk admin_profiles
- Tambah `displayName` computed (fallback ke email)
- Update `login()` untuk fetch profile
- Update `register()` untuk create profile
- Update `checkAuth()` untuk fetch profile

### 4. **Update Admin Layout**
File: `layouts/admin.vue`

Perubahan:
- Display name instead of email di header
- Initial dari nama lengkap (bukan email)

### 5. **Update Login Page**
File: `pages/admin/login.vue`

Perubahan:
- Tambah link "Daftar di sini" ke `/admin/register`

## 🚀 Cara Setup di Supabase

### Step 1: Restore Project Supabase
1. Buka https://app.supabase.com
2. Resume project yang di-pause
3. Tunggu sampai aktif (2-5 menit)

### Step 2: Create Table `admin_profiles`
1. Buka **Supabase Dashboard**
2. Pilih project masjid (pgfeiswjetnjqkzgqghu)
3. Klik **SQL Editor** di sidebar kiri
4. Klik **New Query**
5. Copy semua isi file `database/create_admin_profiles.sql`
6. Paste di SQL Editor
7. Klik **Run** atau tekan `Ctrl+Enter`
8. Tunggu sampai muncul "Success. No rows returned"

### Step 3: Restart Dev Server
```bash
# Kill server yang lama
# Lalu start ulang
npm run dev
```

### Step 4: Test Register
1. Buka http://localhost:3000/admin/register
2. Isi form:
   - Nama Lengkap: "Ahmad Rizky"
   - Email: "admin@masjid.com"
   - Password: "123456"
   - Konfirmasi Password: "123456"
3. Klik "Daftar Sekarang"
4. Cek email untuk konfirmasi (jika enabled)
5. Login dengan email & password

### Step 5: Verifikasi Display Name
1. Login ke admin panel
2. Lihat pojok kanan atas
3. Seharusnya muncul "Ahmad Rizky" (bukan email)
4. Initial juga "A" (dari Ahmad)

## 📊 Struktur Data

### Tabel: `admin_profiles`
```
┌─────────────────────────────────────┬──────────────────────┐
│ id (UUID)                           │ user_id (UUID)       │
├─────────────────────────────────────┼──────────────────────┤
│ auto-generated                      │ auth.users.id        │
└─────────────────────────────────────┴──────────────────────┘

┌─────────────────────────────────────┬──────────────────────┐
│ display_name (TEXT)                 │ created_at           │
├─────────────────────────────────────┼──────────────────────┤
│ "Ahmad Rizky"                       │ 2026-02-10 ...       │
└─────────────────────────────────────┴──────────────────────┘
```

### Relasi dengan `auth.users`
```
auth.users (Supabase Auth)
    ↓ (user_id)
admin_profiles (Custom Table)
```

## 🔒 Security (RLS Policies)

1. **Read**: Semua admin bisa lihat semua profiles
2. **Insert**: User hanya bisa create profile untuk dirinya sendiri
3. **Update**: User hanya bisa update profile sendiri
4. **Delete**: Cascade delete (jika user dihapus, profile ikut terhapus)

## ✅ Checklist

- [x] Create SQL migration file
- [x] Create register page
- [x] Update useAuth composable
- [x] Update admin layout
- [x] Add register link in login page
- [ ] **RUN SQL di Supabase** ⚠️ PENTING!
- [ ] Test register flow
- [ ] Test display name muncul

## 🎯 Next Steps

1. **Jalankan SQL di Supabase** (Step 2 di atas)
2. **Test register** admin baru
3. **Verifikasi** display name muncul di header

Setelah setup selesai, fitur display name akan otomatis aktif! 🚀
