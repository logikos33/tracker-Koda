# 🔧 CORREÇÃO URGENTE - Permitir Fraldas

## PROBLEMA:
Erro: "violates check constraint feeds_duration_check"

## SOLUÇÃO:
Execute este SQL no Supabase SQL Editor

```sql
-- Remover constraint antiga
ALTER TABLE feeds
  DROP CONSTRAINT IF EXISTS feeds_duration_check;

-- Criar nova constraint que ACEITA zero
ALTER TABLE feeds
  ADD CONSTRAINT feeds_duration_check
  CHECK (duration >= 0);
```

## ONDE EXECUTAR:

1. Vá até a aba do Supabase (já está aberta)
2. No menu lateral esquerdo, clique em "SQL Editor"
3. Apague qualquer SQL anterior
4. Copie e cole o SQL acima
5. Clique no botão "RUN" ▶️  (botão azul, canto superior direito)

## COMO SABER QUE FUNCIONOU:

Aparece mensagem: ✅ Success

E depois de 1-2 minutos, teste o botão de fralda no app!
