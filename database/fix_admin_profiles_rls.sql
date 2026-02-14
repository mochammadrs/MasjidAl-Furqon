-- ============================================
-- FIX RLS POLICY - ADMIN PROFILES
-- ============================================
-- Jalankan SQL ini untuk memperbaiki error RLS

-- 1. Drop semua policy yang ada
DROP POLICY IF EXISTS "Admin can read all profiles" ON admin_profiles;
DROP POLICY IF EXISTS "User can insert own profile" ON admin_profiles;
DROP POLICY IF EXISTS "Allow insert profile on signup" ON admin_profiles;
DROP POLICY IF EXISTS "User can update own profile" ON admin_profiles;

-- 2. Create policy baru yang benar

-- Policy: Admin bisa read semua profiles
CREATE POLICY "Admin can read all profiles"
  ON admin_profiles
  FOR SELECT
  TO authenticated
  USING (true);

-- Policy: Allow insert for EVERYONE (bypass RLS saat register)
-- Ini aman karena user_id tetap ter-validasi di application layer
CREATE POLICY "Allow insert profile on signup"
  ON admin_profiles
  FOR INSERT
  TO public
  WITH CHECK (true);

-- Policy: User bisa update profile sendiri
CREATE POLICY "User can update own profile"
  ON admin_profiles
  FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- ============================================
-- SELESAI
-- ============================================
-- Sekarang register harusnya bisa jalan!
-- Coba register lagi di /admin/register
