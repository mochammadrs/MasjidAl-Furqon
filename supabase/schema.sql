-- =====================================================
-- MASJID AL-FURQON DATABASE SCHEMA
-- Sprint 2: The Brain (Logic & Backend)
-- =====================================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =====================================================
-- 1. SETTINGS TABLE
-- Menyimpan konfigurasi dinamis website
-- =====================================================
CREATE TABLE IF NOT EXISTS settings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  key TEXT UNIQUE NOT NULL,
  value TEXT NOT NULL,
  description TEXT,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert default settings
INSERT INTO settings (key, value, description) VALUES
  ('donation_target', '150000000', 'Target donasi pembangunan gedung tahfizh (dalam Rupiah)'),
  ('donation_collected', '45000000', 'Total donasi terkumpul (dalam Rupiah)'),
  ('whatsapp_contact', '628123456789', 'Nomor WhatsApp untuk konfirmasi donasi'),
  ('hero_title', 'Selamat Datang di Masjid Al-Furqon', 'Judul utama hero section'),
  ('hero_subtitle', 'Membangun umat yang berakhlak mulia melalui pendidikan, dakwah, dan kepedulian sosial', 'Subtitle hero section'),
  ('meta_description', 'Masjid Al-Furqon Tasikmalaya - Pusat kegiatan ibadah, pendidikan, dan sosial untuk umat Islam', 'Meta description untuk SEO')
ON CONFLICT (key) DO NOTHING;

-- =====================================================
-- 2. ACTIVITIES TABLE
-- Menyimpan data kegiatan masjid
-- =====================================================
CREATE TABLE IF NOT EXISTS activities (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  date DATE NOT NULL,
  time TEXT,
  location TEXT DEFAULT 'Masjid Al-Furqon',
  image_url TEXT,
  category TEXT CHECK (category IN ('kajian', 'sosial', 'pendidikan', 'ramadhan', 'lainnya')) DEFAULT 'lainnya',
  is_published BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert sample activities
INSERT INTO activities (title, description, date, time, category, image_url) VALUES
  ('Kajian Rutin Ahad Pagi', 'Kajian tafsir Al-Quran dengan Ustadz Ahmad Fauzi', '2026-02-09', '07:00 - 08:30', 'kajian', NULL),
  ('Santunan Anak Yatim', 'Program bulanan santunan untuk 50 anak yatim di Tasikmalaya', '2026-02-15', '09:00 - 11:00', 'sosial', NULL),
  ('Halaqah TPA', 'Pembelajaran Al-Quran untuk anak-anak usia 7-12 tahun', '2026-02-10', '15:30 - 17:00', 'pendidikan', NULL);

-- =====================================================
-- 3. OFFICIALS TABLE
-- Menyimpan data pengurus masjid
-- =====================================================
CREATE TABLE IF NOT EXISTS officials (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  position TEXT NOT NULL,
  photo_url TEXT,
  phone TEXT,
  email TEXT,
  bio TEXT,
  display_order INTEGER DEFAULT 0,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert sample officials
INSERT INTO officials (name, position, display_order, phone) VALUES
  ('H. Abdul Rahman, S.Ag', 'Ketua Takmir', 1, '628123456789'),
  ('Ustadz Ahmad Fauzi, Lc', 'Wakil Ketua', 2, '628234567890'),
  ('Drs. Muhammad Soleh', 'Sekretaris', 3, '628345678901'),
  ('H. Burhanuddin, SE', 'Bendahara', 4, '628456789012');

-- =====================================================
-- 4. GALLERY TABLE
-- Menyimpan foto-foto kegiatan masjid
-- =====================================================
CREATE TABLE IF NOT EXISTS gallery (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title TEXT NOT NULL,
  description TEXT,
  image_url TEXT NOT NULL,
  category TEXT CHECK (category IN ('kegiatan', 'masjid', 'ramadhan', 'sosial', 'pendidikan')) DEFAULT 'kegiatan',
  uploaded_by UUID REFERENCES auth.users(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- =====================================================
-- 5. ROW LEVEL SECURITY (RLS) POLICIES
-- =====================================================

-- Enable RLS on all tables
ALTER TABLE settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE activities ENABLE ROW LEVEL SECURITY;
ALTER TABLE officials ENABLE ROW LEVEL SECURITY;
ALTER TABLE gallery ENABLE ROW LEVEL SECURITY;

-- SETTINGS POLICIES
-- Public: Read only
CREATE POLICY "Settings are viewable by everyone"
  ON settings FOR SELECT
  USING (true);

-- Authenticated: Full access (untuk admin)
CREATE POLICY "Settings are editable by authenticated users"
  ON settings FOR ALL
  USING (auth.role() = 'authenticated');

-- ACTIVITIES POLICIES
-- Public: Read published activities only
CREATE POLICY "Published activities are viewable by everyone"
  ON activities FOR SELECT
  USING (is_published = true);

-- Authenticated: Full access
CREATE POLICY "Activities are fully accessible by authenticated users"
  ON activities FOR ALL
  USING (auth.role() = 'authenticated');

-- OFFICIALS POLICIES
-- Public: Read active officials only
CREATE POLICY "Active officials are viewable by everyone"
  ON officials FOR SELECT
  USING (is_active = true);

-- Authenticated: Full access
CREATE POLICY "Officials are fully accessible by authenticated users"
  ON officials FOR ALL
  USING (auth.role() = 'authenticated');

-- GALLERY POLICIES
-- Public: Read all
CREATE POLICY "Gallery is viewable by everyone"
  ON gallery FOR SELECT
  USING (true);

-- Authenticated: Full access
CREATE POLICY "Gallery is fully accessible by authenticated users"
  ON gallery FOR ALL
  USING (auth.role() = 'authenticated');

-- =====================================================
-- 6. FUNCTIONS & TRIGGERS
-- Auto-update updated_at timestamp
-- =====================================================

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply trigger to tables
CREATE TRIGGER update_settings_updated_at BEFORE UPDATE ON settings
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_activities_updated_at BEFORE UPDATE ON activities
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_officials_updated_at BEFORE UPDATE ON officials
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- =====================================================
-- DONE! Database schema ready 🚀
-- Next: Setup Storage Buckets di Supabase Dashboard
-- =====================================================
