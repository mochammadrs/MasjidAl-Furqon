-- =====================================================
-- FIX RLS POLICIES - Allow authenticated users to manage data
-- Jalankan SQL ini di Supabase SQL Editor
-- =====================================================

-- Drop ALL existing policies first
DROP POLICY IF EXISTS "Activities are fully accessible by authenticated users" ON activities;
DROP POLICY IF EXISTS "Officials are fully accessible by authenticated users" ON officials;
DROP POLICY IF EXISTS "Gallery is fully accessible by authenticated users" ON gallery;
DROP POLICY IF EXISTS "Settings are editable by authenticated users" ON settings;

-- Drop new policies if they exist (from previous runs)
DROP POLICY IF EXISTS "Admin can insert activities" ON activities;
DROP POLICY IF EXISTS "Admin can update activities" ON activities;
DROP POLICY IF EXISTS "Admin can delete activities" ON activities;
DROP POLICY IF EXISTS "Admin can insert officials" ON officials;
DROP POLICY IF EXISTS "Admin can update officials" ON officials;
DROP POLICY IF EXISTS "Admin can delete officials" ON officials;
DROP POLICY IF EXISTS "Admin can insert gallery" ON gallery;
DROP POLICY IF EXISTS "Admin can update gallery" ON gallery;
DROP POLICY IF EXISTS "Admin can delete gallery" ON gallery;
DROP POLICY IF EXISTS "Admin can insert settings" ON settings;
DROP POLICY IF EXISTS "Admin can update settings" ON settings;
DROP POLICY IF EXISTS "Admin can delete settings" ON settings;

-- ACTIVITIES - New comprehensive policies
CREATE POLICY "Admin can insert activities"
  ON activities FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Admin can update activities"
  ON activities FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Admin can delete activities"
  ON activities FOR DELETE
  TO authenticated
  USING (true);

-- OFFICIALS - New comprehensive policies
CREATE POLICY "Admin can insert officials"
  ON officials FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Admin can update officials"
  ON officials FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Admin can delete officials"
  ON officials FOR DELETE
  TO authenticated
  USING (true);

-- GALLERY - New comprehensive policies
CREATE POLICY "Admin can insert gallery"
  ON gallery FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Admin can update gallery"
  ON gallery FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Admin can delete gallery"
  ON gallery FOR DELETE
  TO authenticated
  USING (true);

-- SETTINGS - New comprehensive policies
CREATE POLICY "Admin can insert settings"
  ON settings FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Admin can update settings"
  ON settings FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Admin can delete settings"
  ON settings FOR DELETE
  TO authenticated
  USING (true);

-- =====================================================
-- DONE! Policies updated for admin access
-- =====================================================
