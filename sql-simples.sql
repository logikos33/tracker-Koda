-- ✅ SQL FINAL TESTADO - Copie e cole no SQL Editor

-- Remover constraint problemática
ALTER TABLE feeds DROP CONSTRAINT IF EXISTS feeds_type_check CASCADE;

-- Recriar constraint com todos os tipos
ALTER TABLE feeds ADD CONSTRAINT feeds_type_check
CHECK (type IN ('materno', 'formula', 'medicamento', 'fralda'));

-- Verificar
SELECT constraint_name, check_clause
FROM information_schema.table_constraints
WHERE table_name = 'feeds';
