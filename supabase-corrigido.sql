-- 🚀 SQL CORRIGIDO para Supabase
-- Execute isso no SQL Editor

-- =====================================================
-- 1. CRIAR TABELAS
-- =====================================================

CREATE TABLE IF NOT EXISTS medications (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  name TEXT NOT NULL,
  dosage TEXT NOT NULL,
  frequency TEXT,
  instructions TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS medication_logs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  medication_id UUID REFERENCES medications(id) ON DELETE CASCADE,
  dosage_given TEXT NOT NULL,
  log_date TIMESTAMP WITH TIME ZONE NOT NULL,
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- =====================================================
-- 2. HABILITAR ROW LEVEL SECURITY
-- =====================================================

ALTER TABLE medications ENABLE ROW LEVEL SECURITY;
ALTER TABLE medication_logs ENABLE ROW LEVEL SECURITY;

-- =====================================================
-- 3. CRIAR POLÍTICAS (SEM IF NOT EXISTS)
-- =====================================================

CREATE POLICY "Users can view own medications"
  ON medications FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own medications"
  ON medications FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own medications"
  ON medications FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own medications"
  ON medications FOR DELETE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can view own medication_logs"
  ON medication_logs FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own medication_logs"
  ON medication_logs FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own medication_logs"
  ON medication_logs FOR DELETE
  USING (auth.uid() = user_id);

-- =====================================================
-- 4. CRIAR ÍNDICES
-- =====================================================

CREATE INDEX IF NOT EXISTS idx_medications_user ON medications(user_id);
CREATE INDEX IF NOT EXISTS idx_medication_logs_user ON medication_logs(user_id, log_date DESC);

-- =====================================================
-- 5. ATUALIZAR TABELA FEEDS
-- =====================================================

-- Remover constraint antigo
ALTER TABLE feeds
  DROP CONSTRAINT IF EXISTS feeds_type_check;

-- Adicionar constraint atualizado
ALTER TABLE feeds
  ADD CONSTRAINT feeds_type_check
  CHECK (type IN ('materno', 'formula', 'medicamento', 'fralda'));

-- =====================================================
-- 6. VERIFICAR
-- =====================================================

SELECT
  'medications' as tabela,
  COUNT(*) as total
FROM medications
UNION ALL
SELECT
  'medication_logs' as tabela,
  COUNT(*) as total
FROM medication_logs;
