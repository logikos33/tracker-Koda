# 🎮 MODO DEMO - Tracker do Koda

## 📋 O que é o Modo Demo?

O **Modo Demo** permite que visitantes experimentem o aplicativo **sem precisar criar uma conta**. É perfeito para:

- ✅ Divulgação em redes sociais
- ✅ Testar o aplicativo antes de criar conta
- ✅ Apresentações e demonstrações
- ✅ Share em grupos de pais/mães

## ⚠️ Limitações do Modo Demo

- Dados são **compartilhados** entre todos os usuários demo
- Dados podem ser **limpos a qualquer momento**
- Limite de **50 registros por dia**
- Sem sincronização entre dispositivos
- Dados **temporários** (retidos por 7 dias)

## 🚀 Como Configurar

### 1. Criar Usuário Demo no Supabase

1. Acesse o [Supabase Dashboard](https://supabase.com/dashboard)
2. Selecione seu projeto
3. Vá em **Authentication** → **Users**
4. Clique em **Add user** → **Create new user**
5. Preencha:
   - **Email**: `demo@tracker-koda.com`
   - **Password**: (escolha uma senha forte)
   - **Auto Confirm User**: ✅ ON
6. Clique em **Create user**

### 2. Atualizar Credenciais Demo

Edite o arquivo `js/config-demo.js`:

```javascript
const DEMO_USER = {
    email: 'demo@tracker-koda.com',  // ← Email criado no Supabase
    password: 'sua_senha_aqui',       // ← Senha definida
    name: 'Visitante Demo',
    isDemo: true
};
```

⚠️ **IMPORTANTE**: Nunca commit senhas reais no Git! Use variáveis de ambiente em produção.

### 3. Deploy da Branch Demo

```bash
# Na branch demo
git checkout demo

# Push para o GitHub
git push origin demo

# Configure GitHub Pages para usar a branch demo:
# Settings → Pages → Branch: demo
```

## 📱 Como Usar

### Como Visitante

1. Acesse a URL demo do app
2. Na tela de login, clique em **"🎮 Experimentar Demo Grátis"**
3. Pronto! Você está no modo demo

### Criar Conta Real

No modo demo, há um botão **"Crie uma conta grátis!"** que leva para o registro.

## 🔧 Como Funciona

### Fluxo de Autenticação Demo

```
Visitante clica em "Experimentar Demo"
    ↓
Define isDemoMode = true no localStorage
    ↓
Tenta fazer login com usuário demo (demo@tracker-koda.com)
    ↓
Se sucesso → App funciona normalmente
Se falha → Modo local (dados no navegador)
```

### Isolamento de Dados

Todos os usuários demo usam o **mesmo usuário Supabase** (`demo@tracker-koda.com`), então:

- ✅ Todos veem os mesmos dados
- ✅ Todos podem adicionar/editar/deletar
- ⚠️ Dados são compartilhados (não é privado!)

## 🎨 Personalização

### Alterar Mensagens Demo

Edite `js/config-demo.js`:

```javascript
const DEMO_MESSAGES = {
    welcome: 'Sua mensagem aqui',
    warning: 'Seu aviso aqui',
    // ...
};
```

### Alterar Cores do Botão Demo

Edite `css/styles.css` → `.btn-demo`:

```css
.btn-demo {
    background: linear-gradient(135deg, #SEU_GRADIENTE);
    /* ... */
}
```

### Alterar Limite de Dados

```javascript
const DEMO_CONFIG = {
    dataRetentionDays: 7,  // ← Dias para reter dados
    maxFeedsPerDay: 50     // ← Limite diário
};
```

## 🛡️ Segurança

### Boas Práticas

1. **Nunca** use o usuário demo para dados reais
2. **Limpe** periodicamente os dados do usuário demo
3. **Monitorar** registros para detectar spam/abuso
4. **Limitar** funcionalidades sensíveis no modo demo

### Limpeza Automática

Opcionalmente, crie uma função no Supabase para limpar dados demo antigos:

```sql
-- Limpar feeds demo com mais de 7 dias
DELETE FROM feeds
WHERE user_id = 'demo-user-id'
  AND created_at < NOW() - INTERVAL '7 days';
```

## 📊 Estatísticas e Monitoramento

### Acompanhar Uso Demo

Crie queries para monitorar:

```sql
-- Total de registros demo
SELECT COUNT(*) FROM feeds WHERE user_id = 'demo-user-id';

-- Registros por dia
SELECT DATE(created_at), COUNT(*)
FROM feeds
WHERE user_id = 'demo-user-id'
GROUP BY DATE(created_at)
ORDER BY DATE(created_at) DESC
LIMIT 7;
```

## 🐛 Troubleshooting

### Erro: "Demo login failed"

**Causa**: Usuário demo não existe ou senha incorreta

**Solução**:
1. Verifique se criou o usuário no Supabase
2. Verifique se as credenciais em `config-demo.js` estão corretas

### Dados não estão salvando

**Causa**: Modo local sem Supabase

**Solução**:
1. Verifique console para erros
2. Confirme que usuário demo existe no Supabase

### Botão demo não aparece

**Causa**: Branch demo não está ativa

**Solução**:
```bash
git checkout demo
git push origin demo
```

## 📚 Recursos Adicionais

- [Supabase Auth Documentation](https://supabase.com/docs/guides/auth)
- [GitHub Pages Documentation](https://docs.github.com/pages)
- [Documentação Principal](README.md)

---

**Versão**: 2.0.0
**Branch**: `demo`
**Autor**: Tracker do Koda Team
