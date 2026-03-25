-- ============================================================
-- SOBA YONETIM SISTEMI - Supabase RLS (Row Level Security)
-- ============================================================
-- Bu SQL'i Supabase Dashboard > SQL Editor'de calistirin.
-- Tum tablolarda RLS'i aktiflestirir ve kullanici bazli erisim saglar.
-- Her kullanici SADECE kendi verilerini gorebilir/duzenleyebilir.
-- ============================================================

-- 1) TUM TABLOLARDA RLS'I AKTIFLESTIR
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE cari ENABLE ROW LEVEL SECURITY;
ALTER TABLE suppliers ENABLE ROW LEVEL SECURITY;
ALTER TABLE sales ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE kasa ENABLE ROW LEVEL SECURITY;
ALTER TABLE bank_transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE match_rules ENABLE ROW LEVEL SECURITY;
ALTER TABLE monitor_rules ENABLE ROW LEVEL SECURITY;
ALTER TABLE monitor_log ENABLE ROW LEVEL SECURITY;
ALTER TABLE returns ENABLE ROW LEVEL SECURITY;

-- 2) MEVCUT POLICY'LERI TEMIZLE (varsa)
DO $$
DECLARE
    tbl TEXT;
    pol RECORD;
BEGIN
    FOR tbl IN SELECT unnest(ARRAY[
        'products','cari','suppliers','sales','orders',
        'kasa','bank_transactions','match_rules',
        'monitor_rules','monitor_log','returns'
    ]) LOOP
        FOR pol IN SELECT policyname FROM pg_policies WHERE tablename = tbl LOOP
            EXECUTE format('DROP POLICY IF EXISTS %I ON %I', pol.policyname, tbl);
        END LOOP;
    END LOOP;
END $$;

-- 3) HER TABLO ICIN SELECT / INSERT / UPDATE / DELETE POLICY'LERI

-- === PRODUCTS ===
CREATE POLICY "products_select" ON products FOR SELECT
    USING (auth.uid() = user_id);
CREATE POLICY "products_insert" ON products FOR INSERT
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "products_update" ON products FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "products_delete" ON products FOR DELETE
    USING (auth.uid() = user_id);

-- === CARI ===
CREATE POLICY "cari_select" ON cari FOR SELECT
    USING (auth.uid() = user_id);
CREATE POLICY "cari_insert" ON cari FOR INSERT
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "cari_update" ON cari FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "cari_delete" ON cari FOR DELETE
    USING (auth.uid() = user_id);

-- === SUPPLIERS ===
CREATE POLICY "suppliers_select" ON suppliers FOR SELECT
    USING (auth.uid() = user_id);
CREATE POLICY "suppliers_insert" ON suppliers FOR INSERT
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "suppliers_update" ON suppliers FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "suppliers_delete" ON suppliers FOR DELETE
    USING (auth.uid() = user_id);

-- === SALES ===
CREATE POLICY "sales_select" ON sales FOR SELECT
    USING (auth.uid() = user_id);
CREATE POLICY "sales_insert" ON sales FOR INSERT
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "sales_update" ON sales FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "sales_delete" ON sales FOR DELETE
    USING (auth.uid() = user_id);

-- === ORDERS ===
CREATE POLICY "orders_select" ON orders FOR SELECT
    USING (auth.uid() = user_id);
CREATE POLICY "orders_insert" ON orders FOR INSERT
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "orders_update" ON orders FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "orders_delete" ON orders FOR DELETE
    USING (auth.uid() = user_id);

-- === KASA ===
CREATE POLICY "kasa_select" ON kasa FOR SELECT
    USING (auth.uid() = user_id);
CREATE POLICY "kasa_insert" ON kasa FOR INSERT
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "kasa_update" ON kasa FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "kasa_delete" ON kasa FOR DELETE
    USING (auth.uid() = user_id);

-- === BANK_TRANSACTIONS ===
CREATE POLICY "bank_select" ON bank_transactions FOR SELECT
    USING (auth.uid() = user_id);
CREATE POLICY "bank_insert" ON bank_transactions FOR INSERT
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "bank_update" ON bank_transactions FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "bank_delete" ON bank_transactions FOR DELETE
    USING (auth.uid() = user_id);

-- === MATCH_RULES ===
CREATE POLICY "match_select" ON match_rules FOR SELECT
    USING (auth.uid() = user_id);
CREATE POLICY "match_insert" ON match_rules FOR INSERT
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "match_update" ON match_rules FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "match_delete" ON match_rules FOR DELETE
    USING (auth.uid() = user_id);

-- === MONITOR_RULES ===
CREATE POLICY "monrules_select" ON monitor_rules FOR SELECT
    USING (auth.uid() = user_id);
CREATE POLICY "monrules_insert" ON monitor_rules FOR INSERT
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "monrules_update" ON monitor_rules FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "monrules_delete" ON monitor_rules FOR DELETE
    USING (auth.uid() = user_id);

-- === MONITOR_LOG ===
CREATE POLICY "monlog_select" ON monitor_log FOR SELECT
    USING (auth.uid() = user_id);
CREATE POLICY "monlog_insert" ON monitor_log FOR INSERT
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "monlog_update" ON monitor_log FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "monlog_delete" ON monitor_log FOR DELETE
    USING (auth.uid() = user_id);

-- === RETURNS ===
CREATE POLICY "returns_select" ON returns FOR SELECT
    USING (auth.uid() = user_id);
CREATE POLICY "returns_insert" ON returns FOR INSERT
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "returns_update" ON returns FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);
CREATE POLICY "returns_delete" ON returns FOR DELETE
    USING (auth.uid() = user_id);

-- ============================================================
-- DOGRULAMA: RLS durumunu kontrol et
-- ============================================================
SELECT
    schemaname,
    tablename,
    rowsecurity
FROM pg_tables
WHERE tablename IN (
    'products','cari','suppliers','sales','orders',
    'kasa','bank_transactions','match_rules',
    'monitor_rules','monitor_log','returns'
)
ORDER BY tablename;
