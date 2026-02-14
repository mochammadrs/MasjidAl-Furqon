# 📧 Resend.com Setup Guide - Masjid Al-Furqan

**Email sistem untuk konfirmasi registrasi & reset password admin**

---

## 🎯 Kenapa Resend.com?

✅ **100% GRATIS** untuk 3,000 email/bulan  
✅ **Tidak pakai email pribadi** (tetap privat)  
✅ **Setup 5 menit** (lebih mudah dari Gmail)  
✅ **Reliability tinggi** (99.9% deliverability)  
✅ **Professional** (custom domain)  
✅ **Dashboard tracking** (monitoring email terkirim)

---

## 📋 Persiapan

- ✅ Akun GitHub (untuk login)
- ✅ Domain masjid (opsional, bisa pakai temporary dulu)
- ✅ Akses Supabase dashboard

---

## 🚀 Step 1: Daftar Resend.com

### 1.1 Buat Akun
1. Buka [resend.com](https://resend.com)
2. Klik **"Sign Up Free"**
3. Login dengan **GitHub** (paling cepat)
4. Verifikasi email jika diminta

### 1.2 Dapatkan API Key
1. Setelah login → Dashboard Resend
2. Klik **"API Keys"** di sidebar kiri
3. Klik **"Create API Key"**
4. Nama: `Masjid Al-Furqan Production`
5. Permission: **Full Access**
6. **SIMPAN API Key** → Copy ke notepad (hanya muncul 1x!)

```
Contoh API Key:
re_AbCdEfGh123456789_IjKlMnOpQrStUvWxYz
```

---

## 🔧 Step 2: Setup Custom Domain (Opsional)

> ⚠️ **Untuk testing:** Skip dulu, pakai `onboarding@resend.dev`  
> ⚠️ **Untuk production:** Harus setup domain sendiri

### 2.1 Tambah Domain
1. Dashboard Resend → **"Domains"**
2. Klik **"Add Domain"**
3. Masukkan domain: `masjidalfurqan.com`
4. Klik **"Add"**

### 2.2 Verify Domain (DNS Setup)
Resend akan tampilkan 3 DNS records yang harus ditambahkan:

#### **SPF Record (TXT)**
```
Type: TXT
Name: @
Value: v=spf1 include:resend.com ~all
TTL: 3600
```

#### **DKIM Record (TXT)**
```
Type: TXT
Name: resend._domainkey
Value: [value dari Resend, panjang banget]
TTL: 3600
```

#### **DMARC Record (TXT)**
```
Type: TXT
Name: _dmarc
Value: v=DMARC1; p=none
TTL: 3600
```

### 2.3 Tambah DNS di Provider Domain
- **Cloudflare:** DNS → Add Record → Copy paste dari atas
- **Niagahoster:** DNS Management → Custom DNS
- **GoDaddy:** DNS → Manage DNS → Add Records

### 2.4 Verify Domain
- Tunggu 5-30 menit (propagasi DNS)
- Kembali ke Resend → klik **"Verify Domain"**
- Jika sukses → ✅ Status: **Verified**

---

## ⚙️ Step 3: Konfigurasi Supabase

### 3.1 Login ke Supabase Dashboard
1. Buka [app.supabase.com](https://app.supabase.com)
2. Pilih project **Masjid Al-Furqan**
3. Klik **Settings** (⚙️ icon di sidebar kiri)

### 3.2 Setup Custom SMTP
1. Klik **Auth** → **Email Templates**
2. Scroll ke bawah → **SMTP Provider Settings**
3. Toggle **"Enable Custom SMTP"** → ✅ ON
4. Isi form:

```
SMTP Host:        smtp.resend.com
Port:             465
Username:         resend
Password:         [Paste API Key dari Step 1.2]

Sender Email:     noreply@masjidalfurqan.com
Sender Name:      Masjid Al-Furqan
```

> ⚠️ **Jika belum setup domain:** Pakai `onboarding@resend.dev` untuk Sender Email

5. Klik **"Save"**

---

## ✉️ Step 4: Customize Email Templates

### 4.1 Confirm Signup Template
1. Supabase → **Auth** → **Email Templates**
2. Pilih **"Confirm signup"**
3. Edit HTML/Text:

**Subject:** `Konfirmasi Email - Masjid Al-Furqan`

**Body (HTML):**
```html
<h2>Assalamu'alaikum {{ .Email }}</h2>

<p>Terima kasih telah mendaftar sebagai admin Masjid Al-Furqan Digital.</p>

<p>Silakan klik tombol di bawah untuk mengaktifkan akun Anda:</p>

<p>
  <a href="{{ .ConfirmationURL }}" 
     style="background-color: #059669; color: white; padding: 12px 24px; text-decoration: none; border-radius: 6px; display: inline-block;">
    Konfirmasi Email
  </a>
</p>

<p>Atau copy link berikut ke browser:</p>
<p>{{ .ConfirmationURL }}</p>

<p>Link ini berlaku selama 24 jam.</p>

<hr>
<p style="color: #666; font-size: 12px;">
  Masjid Al-Furqan Digital<br>
  Jl. [Alamat Masjid]<br>
  Email: info@masjidalfurqan.com
</p>
```

4. Klik **"Save"**

### 4.2 Reset Password Template
1. Pilih **"Reset password"**
2. **Subject:** `Reset Password - Masjid Al-Furqan`
3. **Body:**

```html
<h2>Assalamu'alaikum {{ .Email }}</h2>

<p>Anda menerima email ini karena ada permintaan reset password untuk akun admin Masjid Al-Furqan Digital.</p>

<p>Klik tombol di bawah untuk membuat password baru:</p>

<p>
  <a href="{{ .ConfirmationURL }}" 
     style="background-color: #dc2626; color: white; padding: 12px 24px; text-decoration: none; border-radius: 6px; display: inline-block;">
    Reset Password
  </a>
</p>

<p>Atau copy link berikut ke browser:</p>
<p>{{ .ConfirmationURL }}</p>

<p>Link ini berlaku selama 1 jam.</p>

<p><strong>Jika Anda tidak meminta reset password, abaikan email ini.</strong></p>

<hr>
<p style="color: #666; font-size: 12px;">
  Masjid Al-Furqan Digital<br>
  Jl. [Alamat Masjid]<br>
  Email: info@masjidalfurqan.com
</p>
```

4. Klik **"Save"**

---

## 🧪 Step 5: Testing Email

### 5.1 Test Registration Email
1. Buka website local: `http://localhost:3000/admin/register`
2. Isi form dengan email kamu
3. Klik **"Daftar"**
4. **Cek inbox email** → harus terima email konfirmasi
5. Klik link konfirmasi → redirect ke login

**✅ Berhasil:** Email masuk dalam 10-30 detik  
**❌ Gagal:** Cek spam folder, atau cek Resend dashboard untuk error logs

### 5.2 Test Reset Password Email
1. Buka: `http://localhost:3000/admin/forgot-password`
2. Masukkan email yang sudah terdaftar
3. Klik **"Kirim Link Reset Password"**
4. **Cek inbox email** → harus terima email reset
5. Klik link reset → buat password baru

### 5.3 Cek Resend Dashboard
1. Buka [resend.com/emails](https://resend.com/emails)
2. Lihat semua email yang terkirim
3. Status harus: **Delivered** ✅
4. Jika **Bounced/Failed** → cek error message

---

## 📊 Monitoring Email

### Resend Dashboard
- **Emails Sent:** Total email terkirim
- **Delivery Rate:** Persentase sukses (target: > 95%)
- **Bounce Rate:** Email gagal (target: < 5%)
- **Logs:** Detail setiap email (klik untuk lihat content)

### Quota Free Plan
- ✅ **3,000 email/bulan** (± 100 email/hari)
- ✅ **100 email/hari** max
- ✅ Unlimited domains
- ✅ Email tracking & logs

**Cukup untuk:**
- 50-100 admin register/bulan
- 100-200 password reset/bulan
- Website masjid scale kecil-menengah

---

## 🔐 Security Best Practices

### 1. API Key Security
- ❌ **JANGAN** commit API key ke GitHub
- ✅ Simpan di **environment variable** (Supabase dashboard)
- ✅ Regenerate API key setiap 6 bulan

### 2. Domain Authentication
- ✅ Setup SPF, DKIM, DMARC (prevent spoofing)
- ✅ Use custom domain (bukan onboarding@resend.dev)
- ✅ Monitor bounce rate di dashboard

### 3. Rate Limiting
- ✅ Resend otomatis limit 100 email/hari (free plan)
- ✅ Supabase auth limit: 4 request/jam per IP (default)
- ✅ Monitor suspicious activity di logs

---

## 🆘 Troubleshooting

### Email tidak masuk inbox
1. **Cek spam folder** (kadang masuk spam pertama kali)
2. **Verify domain** (jika pakai custom domain)
3. **Cek Resend logs** → lihat delivery status
4. **Whitelist sender** di email client

### API Key tidak berfungsi
1. Copy ulang API key (pastikan tidak ada spasi)
2. Regenerate API key baru
3. Update di Supabase SMTP settings

### Domain verification failed
1. Tunggu 30 menit (DNS propagasi)
2. Cek DNS records dengan [mxtoolbox.com](https://mxtoolbox.com)
3. Pastikan SPF, DKIM, DMARC sudah benar
4. Contact support Resend (fast response!)

### Quota email habis
1. **Free plan:** 3000/bulan, 100/hari
2. **Upgrade:** $20/bulan → 50,000 email
3. **Alternative:** Buat akun Resend baru (temporary)

---

## 💰 Pricing (Jika Perlu Upgrade)

| Plan | Price | Emails/Month | Emails/Day |
|------|-------|--------------|------------|
| **Free** | $0 | 3,000 | 100 |
| **Pro** | $20/mo | 50,000 | 1,000 |
| **Business** | $80/mo | 200,000 | 5,000 |

**Kapan upgrade?**
- Website punya 500+ users
- Butuh dedicated IP address
- Perlu priority support

---

## ✅ Checklist Setup

**Resend.com:**
- [ ] Daftar akun Resend dengan GitHub
- [ ] Create API Key → simpan di notepad
- [ ] (Opsional) Add custom domain + verify DNS
- [ ] Test kirim email dari Resend dashboard

**Supabase:**
- [ ] Enable Custom SMTP di Auth settings
- [ ] Input SMTP credentials (smtp.resend.com, port 465)
- [ ] Paste API Key sebagai password
- [ ] Set sender email + name
- [ ] Customize email templates (Confirm + Reset)
- [ ] Save settings

**Testing:**
- [ ] Test registration → cek email konfirmasi
- [ ] Test forgot password → cek email reset
- [ ] Verify email masuk inbox (bukan spam)
- [ ] Click links → confirm berfungsi
- [ ] Cek Resend dashboard → status Delivered

**Production:**
- [ ] Setup custom domain (masjidalfurqan.com)
- [ ] Verify domain di Resend (SPF, DKIM, DMARC)
- [ ] Update sender email ke domain sendiri
- [ ] Test ulang semua flow
- [ ] Monitor delivery rate di dashboard

---

## 📚 Resources

- **Resend Docs:** [resend.com/docs](https://resend.com/docs)
- **Supabase SMTP:** [supabase.com/docs/guides/auth/auth-smtp](https://supabase.com/docs/guides/auth/auth-smtp)
- **DNS Checker:** [dnschecker.org](https://dnschecker.org)
- **Email Tester:** [mail-tester.com](https://mail-tester.com)

---

## 🎯 Kesimpulan

Resend.com adalah **solusi terbaik** untuk email system Masjid Al-Furqan karena:

1. ✅ **Gratis 3000 email/bulan** (cukup untuk scale kecil-menengah)
2. ✅ **Email pribadi tetap privat** (tidak tercampur dengan system emails)
3. ✅ **Professional** (pakai custom domain)
4. ✅ **Deliverability tinggi** (99.9% masuk inbox, bukan spam)
5. ✅ **Easy setup** (5 menit vs 30 menit Gmail App Password)
6. ✅ **Monitoring & logs** (track semua email)

**Setup time:** 15 menit (termasuk custom domain)  
**Total cost:** Rp 0/bulan (untuk 3000 email)

---

**Siap production!** 🚀
