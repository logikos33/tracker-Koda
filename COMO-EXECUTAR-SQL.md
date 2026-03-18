# 🚀 Guia Passo a Passo - Executar SQL no Supabase

## Situação Atual:
- ✅ Supabase aberto no navegador
- ✅ Dashboard visível
- ✅ SQL pronto para executar

## PASSO A PASSO COM IMAGENS:

### 1. NO MENU LATERAL (ESQUERDA):
```
┌─────────────────────┐
│ ⭐                 │
│ Database           │  ← CLIQUE AQUI
│ 🔐 Authentication  │
│ 📊 API             │
│ 📝 SQL Editor      │  ← OU AQUI
│ ⚙️ Settings        │
└─────────────────────┘
```

### 2. NO SQL EDITOR:
```
┌─────────────────────────────────────────┐
│  SQL Editor                    ▾       │
│  ┌───────────────────────────────┐   │
│  │  1. New Query            +    │   │
│  └───────────────────────────────┘   │
│                                  │
│  ┌───────────────────────────────┐   │
│  │  Editor de SQL                │   │
│  │  [Cole o SQL aqui]            │   │
│  │                               │   │
│  │                               │   │
│  └───────────────────────────────┘   │
│                                  │
│  ▼ NEW QUERY BUTTON               │
│  ┌───────────────────┐           │
│  │  RUN ▶️           │  ← CLIQUE AQUI│
│  └───────────────────┘           │
└─────────────────────────────────────┘
```

## SQL PARA COPIAR:

```sql
-- PASSO 1: Criar tabelas de medicamentos
CREATE TABLE IF NOT EXISTS medications (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  name TEXT NOT NULL,
  dosage TEXT NOT NULL,
  frequency TEXT,
  instructions TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- PASSO 2: Criar tabela de logs
CREATE TABLE IF NOT EXISTS medication_logs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  medication_id UUID REFERENCES medications(id) ON DELETE CASCADE,
  dosage_given TEXT NOT NULL,
  log_date TIMESTAMP WITH TIME ZONE NOT NULL,
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- PASSO 3: Habilitar segurança
ALTER TABLE medications ENABLE ROW LEVEL SECURITY;
ALTER TABLE medication_logs ENABLE ROW LEVEL SECURITY;

-- PASSO 4: Criar políticas de segurança
CREATE POLICY IF NOT EXISTS "Users can view own medications"
  ON medications FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY IF NOT EXISTS "Users can insert own medications"
  ON medications FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY IF NOT EXISTS "Users can update own medications"
  ON medications FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY IF NOT EXISTS "Users can delete own medications"
  ON medications FOR DELETE USING (auth.uid() = user_id);

CREATE POLICY IF NOT EXISTS "Users can view own medication_logs"
  ON medication_logs FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY IF NOT EXISTS "Users can insert own medication_logs"
  ON medication_logs FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY IF NOT EXISTS "Users can delete own medication_logs"
  ON medication_logs FOR DELETE USING (auth.uid() = user_id);

-- PASSO 5: Criar índices
CREATE INDEX IF NOT EXISTS idx_medications_user ON medications(user_id);
CREATE INDEX IF NOT EXISTS idx_medication_logs_user ON medication_logs(user_id, log_date DESC);

-- PASSO 6: Atualizar tabela feeds para suportar fraldas e medicamentos
ALTER TABLE feeds DROP CONSTRAINT IF EXISTS feeds_type_check;

ALTER TABLE feeds ADD CONSTRAINT feeds_type_check
  CHECK (type IN ('materno', 'formula', 'medicamento', 'fralda'));
```

## RESULTADO ESPERADO:

Após clicar em RUN, você deve ver:

```
┌────────────────────────────────────┐
│ ✅ Success                         │
│                                    │
│ Rows affected: 0                   │
│                                    │
│ ┌──────────┬───────┬─────────┐   │
│ │ table_name│ rows  │         │   │
│ ├──────────┼───────┼─────────┤   │
│ │medications│  0    │         │   │
│ │medication_logs│ 0│         │   │
│ │feeds      │  X    │         │   │
│ └──────────┴───────┴─────────┘   │
└────────────────────────────────────┘
```

## DICA IMPORTANTE:

Se aparecer erro de **"constraint already exists"**, está OK!
Significa que você já executou antes. Continue!

## DEPOIS DO SQL:

1. ✅ Aguarde 1-2 minutos
2. ✅ Acesse: https://logikos33.github.io/tracker-mamadas/
3. ✅ Faça login (ou crie conta)
4. ✅ Teste as novas funcionalidades!

---

**DÚVIDAS?**

Se estiver travado, me diga o que está vendo na tela que eu te ajudo! 😊
