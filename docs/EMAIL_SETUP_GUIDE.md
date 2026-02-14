# 📧 Setup Email Authentication - Masjid Al-Furqan

## 🎯 Tujuan
Setup email confirmation & password reset menggunakan SMTP yang proper untuk production.

---

## 📋 Yang Sudah Dibuat

### 1. **Halaman Forgot Password** (`/admin/forgot-password`)
- Form input email
- Kirim link reset password via email
- Success confirmation

### 2. **Halaman Reset Password** (`/admin/reset-password`)
- Form password baru + konfirmasi
- Validasi password match
- Auto-redirect ke login setelah sukses

### 3. **Update Login Page**
- Link "Lupa Password?" di form login
- Link "Daftar di sini" untuk register

---

## 🚀 Setup Email di Supabase

### Step 1: Pilih SMTP Provider

**Rekomendasi untuk Production:**

#### **A. Gmail SMTP** (Gratis, Max 500 email/day)
- ✅ Mudah setup
- ✅ Reliable
- ❌ Limit 500 email/day
- 💡 **Cocok untuk**: Small-medium website

#### **B. SendGrid** (Gratis 100 email/day)
- ✅ Professional
- ✅ Email analytics
- ❌ Perlu registrasi & verifikasi domain
- 💡 **Cocok untuk**: Production dengan analytics

#### **C. Resend** (Gratis 3,000 email/month)
- ✅ Modern & simple
- ✅ No credit card required
- ✅ Easy verification
- 💡 **Cocok untuk**: Modern stack

**Rekomendasi: Pakai Gmail untuk sekarang, nanti upgrade ke SendGrid/Resend kalau traffic naik.**

---

## 📧 Setup Gmail SMTP (Recommended)

### Step 1: Create App Password di Gmail

1. **Login ke Gmail** yang mau dipakai (misal: `masjid.alfurqan@gmail.com`)

2. **Enable 2-Step Verification**:
   - Buka https://myaccount.google.com/security
   - Klik **2-Step Verification**
   - Follow steps untuk enable

3. **Generate App Password**:
   - Buka https://myaccount.google.com/apppasswords
   - Select app: **Mail**
   - Select device: **Other** (ketik: "Masjid Website")
   - Klik **Generate**
   - **COPY** 16-digit password (contoh: `abcd efgh ijkl mnop`)
   - **SIMPAN** password ini (nanti dipakai di Supabase)

### Step 2: Configure di Supabase

1. **Buka Supabase Dashboard** → https://app.supabase.com

2. **Pilih Project** Masjid Al-Furqan

3. **Settings** → **Authentication** → **SMTP Settings**

4. **Enable Custom SMTP**:
   ```
   ☑️ Enable Custom SMTP
   ```

5. **Isi SMTP Configuration**:
   ```
   SMTP Host:     smtp.gmail.com
   SMTP Port:     587
   Username:      masjid.alfurqan@gmail.com  (email Gmail kamu)
   Password:      abcd efgh ijkl mnop        (App Password dari Step 1)
   Sender Email:  masjid.alfurqan@gmail.com
   Sender Name:   Masjid Al-Furqon Tasikmalaya
   ```

6. **Save SMTP Settings**

### Step 3: Test Email

1. **Klik tab** "Email Templates"

2. **Test Email**:
   - Pilih template: **Confirm signup**
   - Klik **Send test email**
   - Masukkan email kamu untuk test
   - Klik **Send**
   - **Cek inbox** (atau spam folder)

3. **Jika email masuk** = ✅ SMTP berhasil!

---

## 🎨 Customize Email Templates (Optional tapi Recommended)

### 1. Confirmation Email (Saat Register)

**Path**: Supabase Dashboard → Authentication → Email Templates → **Confirm signup**

```html
<h2>Selamat Datang, Admin Masjid Al-Furqon!</h2>

<p>Terima kasih telah mendaftar sebagai administrator di sistem Masjid Al-Furqon Tasikmalaya.</p>

<p>Untuk mengaktifkan akun Anda, silakan klik tombol di bawah ini:</p>

<a href="{{ .ConfirmationURL }}" 
   style="display: inline-block; padding: 12px 24px; background-color: #D4AF37; color: white; text-decoration: none; border-radius: 6px; font-weight: bold;">
  Konfirmasi Email
</a>

<p>Atau copy-paste link berikut ke browser:</p>
<p>{{ .ConfirmationURL }}</p>

<p style="color: #666; font-size: 12px; margin-top: 30px;">
  Email ini dikirim otomatis oleh sistem Masjid Al-Furqon. Jika Anda tidak mendaftar, abaikan email ini.
</p>
```

### 2. Password Reset Email

**Path**: Supabase Dashboard → Authentication → Email Templates → **Reset password**

```html
<h2>Reset Password - Masjid Al-Furqon</h2>

<p>Anda menerima email ini karena ada permintaan untuk reset password akun administrator.</p>

<p>Untuk membuat password baru, silakan klik tombol di bawah ini:</p>

<a href="{{ .ConfirmationURL }}" 
   style="display: inline-block; padding: 12px 24px; background-color: #D4AF37; color: white; text-decoration: none; border-radius: 6px; font-weight: bold;">
  Reset Password
</a>

<p>Atau copy-paste link berikut ke browser:</p>
<p>{{ .ConfirmationURL }}</p>

<p style="color: #666; font-size: 12px; margin-top: 30px;">
  Link ini akan kadaluarsa dalam 1 jam. Jika Anda tidak meminta reset password, abaikan email ini.
</p>
```

**Klik "Save"** setelah edit template.

---

## ⚙️ Configuration Settings

### 1. Email Confirmation Settings

**Path**: Supabase Dashboard → Authentication → Providers → **Email**

**Setting untuk Production:**
```
☑️ Enable email provider
☑️ Confirm email              ← PENTING! Enable ini
☐ Secure email change
```

**Penjelasan:**
- ✅ **Confirm email**: User HARUS confirm email sebelum bisa login
- ❌ Jika disabled: User langsung aktif tanpa confirm (TIDAK AMAN untuk production!)

### 2. Redirect URLs (Penting!)

**Path**: Supabase Dashboard → Authentication → URL Configuration

**Tambahkan Redirect URLs:**
```
http://localhost:3000/admin/reset-password    (Development)
http://localhost:3000/admin/login             (Development)
https://masjid-alfurqan.netlify.app/admin/reset-password    (Production)
https://masjid-alfurqan.netlify.app/admin/login             (Production)
```

⚠️ **Ganti** `masjid-alfurqan.netlify.app` dengan URL production kamu nanti!

### 3. Site URL

**Path**: Supabase Dashboard → Authentication → URL Configuration

```
Site URL: https://masjid-alfurqan.netlify.app  (Production URL)
```

Untuk sekarang bisa pakai: `http://localhost:3000`

---

## 🔄 Testing Flow

### Test 1: Register & Email Confirmation

1. Buka `http://localhost:3000/admin/register`
2. Isi form:
   - Nama: "Test Admin"
   - Email: (email kamu yang valid)
   - Password: "123456"
3. Klik **Daftar**
4. **Cek email** → Klik link konfirmasi
5. **Auto-redirect** ke login
6. Login dengan email & password
7. Masuk dashboard → **Lihat display name** "Test Admin" (bukan email)

### Test 2: Forgot Password

1. Buka `http://localhost:3000/admin/login`
2. Klik **"Lupa Password?"**
3. Masukkan email admin
4. Klik **Kirim Link Reset Password**
5. **Cek email** → Klik link reset
6. Masukkan password baru
7. Login dengan password baru

---

## 🌐 Alternative: SendGrid Setup (For Production)

Jika nanti mau upgrade ke SendGrid:

### 1. Create SendGrid Account
- Sign up: https://signup.sendgrid.com/
- Verify email
- Complete onboarding

### 2. Create API Key
- Settings → API Keys → Create API Key
- Name: "Masjid Al-Furqon Website"
- Permissions: **Full Access**
- Copy API Key

### 3. Verify Domain (Optional)
- Settings → Sender Authentication → Verify Domain
- Follow DNS setup instructions

### 4. Configure di Supabase
```
SMTP Host:     smtp.sendgrid.net
SMTP Port:     587
Username:      apikey  (literally the word "apikey")
Password:      SG.xxx... (SendGrid API Key)
Sender Email:  noreply@masjid-alfurqan.com
Sender Name:   Masjid Al-Furqon Tasikmalaya
```

---

## 📊 Email Limits & Monitoring

### Gmail SMTP Limits:
- **Max**: 500 emails/day
- **Per minute**: ~20 emails
- **Monitoring**: Gmail → Settings → Forwarding and POP/IMAP

### SendGrid Free Tier:
- **Max**: 100 emails/day
- **Analytics**: Dashboard dengan open rate, click rate, etc.
- **Monitoring**: SendGrid Dashboard

### Estimasi Kebutuhan Email:
```
Registrasi admin: ~1-5 email/bulan (jarang)
Reset password:   ~2-10 email/bulan
Total estimate:   ~20 email/bulan
```

💡 Gmail SMTP **lebih dari cukup** untuk kebutuhan website masjid!

---

## ✅ Checklist Setup

### Development (Sekarang):
- [ ] Enable 2FA di Gmail
- [ ] Generate App Password Gmail
- [ ] Configure SMTP di Supabase
- [ ] Test kirim email
- [ ] Test register dengan email confirmation
- [ ] Test forgot password flow
- [ ] Customize email templates (optional)

### Before Production:
- [ ] Ganti Site URL ke production
- [ ] Add production redirect URLs
- [ ] Test semua flow di production
- [ ] Monitor email delivery

---

## 🆘 Troubleshooting

### Email tidak terkirim?
1. **Cek SMTP credentials** → Re-generate App Password
2. **Cek spam folder**
3. **Test email** dari Supabase dashboard
4. **Cek logs**: Supabase → Logs → Filter: "auth"

### Link reset password tidak work?
1. **Cek redirect URL** sudah terdaftar di Supabase
2. **Cek URL** di email apakah benar domain-nya
3. **Cek browser console** untuk error

### User tidak bisa login setelah register?
1. **Pastikan email sudah di-confirm**
2. **Cek**: Supabase → Authentication → Users → Status harus "confirmed"
3. **Manual confirm**: Klik user → Send confirmation email

---

## 🎉 Selesai!

Setelah setup SMTP, flow-nya jadi:
1. **Register** → Email confirmation dikirim
2. **Confirm email** → Account active
3. **Login** → Masuk dashboard
4. **Lupa password** → Reset via email

Simple, aman, dan professional! ✨

**Next**: Test semua flow, lalu siap production! 🚀
