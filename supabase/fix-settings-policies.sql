-- =====================================================
-- FIX SETTINGS RLS POLICIES & CREATE DEFAULT DATA
-- Jalankan SQL ini di Supabase SQL Editor
-- =====================================================

-- 1. Drop existing policies
DROP POLICY IF EXISTS "Admin can insert settings" ON settings;
DROP POLICY IF EXISTS "Admin can update settings" ON settings;
DROP POLICY IF EXISTS "Admin can delete settings" ON settings;
DROP POLICY IF EXISTS "Public can view settings" ON settings;

-- 2. Create new policies
-- Public dapat melihat settings
CREATE POLICY "Public can view settings"
  ON settings FOR SELECT
  USING (true);

-- Authenticated admin dapat INSERT
CREATE POLICY "Admin can insert settings"
  ON settings FOR INSERT
  TO authenticated
  WITH CHECK (true);

-- Authenticated admin dapat UPDATE
CREATE POLICY "Admin can update settings"
  ON settings FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Authenticated admin dapat DELETE
CREATE POLICY "Admin can delete settings"
  ON settings FOR DELETE
  TO authenticated
  USING (true);

-- 3. Insert default settings (jika belum ada)
INSERT INTO settings (key, value, description) VALUES
  ('donation_collected', '45000000', 'Jumlah donasi yang sudah terkumpul (dalam Rupiah)'),
  ('donation_target', '150000000', 'Target donasi pembangunan gedung tahfizh (dalam Rupiah)'),
  ('whatsapp_number', '6281234567890', 'Nomor WhatsApp untuk floating button dan konfirmasi donasi'),
  ('masjid_email', 'masjid@alfurqan.com', 'Email resmi masjid'),
  ('masjid_name', 'Masjid Al-Furqon', 'Nama lengkap masjid'),
  ('masjid_address', 'Jl. Contoh No. 123, Tasikmalaya, Jawa Barat', 'Alamat lengkap masjid')
ON CONFLICT (key) DO NOTHING;

-- =====================================================
-- SELESAI! 
-- =====================================================
-- Settings table sudah siap digunakan
-- Silakan buka /admin/settings untuk mengedit nilai-nilainya
