-- ============================================
-- ADMIN PROFILES TABLE
-- ============================================
-- Tabel untuk menyimpan profil admin (display_name, dll)
-- Satu user hanya bisa punya satu profil (UNIQUE constraint)

CREATE TABLE IF NOT EXISTS admin_profiles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  display_name TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id)
);

-- ============================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================
-- Enable RLS untuk keamanan
ALTER TABLE admin_profiles ENABLE ROW LEVEL SECURITY;

-- Policy: Admin bisa read semua profiles
CREATE POLICY "Admin can read all profiles"
  ON admin_profiles
  FOR SELECT
  TO authenticated
  USING (true);

-- Policy: Allow insert for any authenticated user (termasuk baru register)
-- Karena saat signUp, user langsung dapat auth token
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
-- TRIGGER FOR UPDATED_AT
-- ============================================
-- Auto-update timestamp saat ada perubahan
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_admin_profiles_updated_at
  BEFORE UPDATE ON admin_profiles
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- INDEX
-- ============================================
-- Index untuk performa query by user_id
CREATE INDEX idx_admin_profiles_user_id ON admin_profiles(user_id);

-- ============================================
-- SELESAI
-- ============================================
-- Sekarang table admin_profiles sudah siap digunakan!
-- 
-- Cara pakai:
-- 1. Copy semua SQL di atas
-- 2. Buka Supabase Dashboard → SQL Editor
-- 3. Paste dan klik "Run"
-- 4. Table akan ter-create dengan semua security policies
