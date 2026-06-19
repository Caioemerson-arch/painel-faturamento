# Painel de Faturamento — Guia de Publicação

Siga os passos abaixo na ordem. Tempo estimado: **20 minutos**.

---

## Passo 1 — Criar conta no Supabase (banco de dados)

1. Acesse https://supabase.com e clique em **Start your project**
2. Crie uma conta com Google ou e-mail
3. Clique em **New project**
4. Preencha:
   - **Name:** painel-faturamento (ou qualquer nome)
   - **Database Password:** crie uma senha forte e guarde
   - **Region:** South America (São Paulo)
5. Clique em **Create new project** e aguarde (~2 minutos)

---

## Passo 2 — Criar a tabela no banco

1. No menu lateral, clique em **SQL Editor**
2. Clique em **New query**
3. Abra o arquivo `supabase_setup.sql` (que veio junto com estes arquivos)
4. Copie todo o conteúdo e cole no editor
5. Clique em **Run** (ícone ▶ ou Ctrl+Enter)
6. Você verá `Success. No rows returned` — significa que funcionou

---

## Passo 3 — Copiar as chaves do Supabase

1. No menu lateral, clique em **Project Settings** (ícone de engrenagem)
2. Clique em **API**
3. Copie dois valores:
   - **Project URL** → algo como `https://xyzxyz.supabase.co`
   - **anon public** (em Project API keys) → uma chave longa começando com `eyJ...`

4. Abra o arquivo `index.html` no Bloco de Notas (ou qualquer editor de texto)
5. Encontre as duas linhas:
   ```
   const SUPABASE_URL = 'COLE_SUA_SUPABASE_URL_AQUI';
   const SUPABASE_ANON_KEY = 'COLE_SUA_SUPABASE_ANON_KEY_AQUI';
   ```
6. Substitua pelos valores copiados. Exemplo:
   ```
   const SUPABASE_URL = 'https://xyzxyz.supabase.co';
   const SUPABASE_ANON_KEY = 'eyJhbGci...';
   ```
7. Salve o arquivo
8. **Repita o mesmo processo no arquivo `dashboard.html`** (as mesmas duas linhas aparecem lá também)

---

## Passo 4 — Criar os usuários

### Usuário administrador (quem lança os dados)

1. No Supabase, vá em **Authentication** > **Users**
2. Clique em **Add user** > **Create new user**
3. Preencha e-mail e senha do administrador
4. Clique em **Create user**
5. Na lista de usuários, clique no usuário criado
6. Role até **User Metadata** e clique em **Edit**
7. Cole o seguinte JSON e salve:
   ```json
   { "role": "admin" }
   ```

### Usuários visualizadores (só veem o painel)

1. Repita o processo acima para cada membro da equipe
2. Na etapa de metadata, use:
   ```json
   { "role": "viewer" }
   ```
   Ou simplesmente não preencha nada — o padrão é viewer

---

## Passo 5 — Publicar no Vercel (URL pública)

1. Acesse https://vercel.com e crie uma conta (pode usar Google)
2. Clique em **Add New** > **Project**
3. Como você não tem um repositório Git, use a opção mais simples:
   - Clique em **Browse** ou arraste a **pasta inteira** `painel-faturamento`
   - O Vercel aceita upload direto de pasta
4. Clique em **Deploy**
5. Em ~1 minuto, você receberá uma URL como:
   `https://painel-faturamento-xyz.vercel.app`

Essa URL é a que você compartilha com a equipe.

---

## Como usar depois de publicado

| Ação | Quem pode |
|------|-----------|
| Ver painel e gráficos | Todos (admin e viewer) |
| Lançar dados mensais | Apenas administrador |
| Editar / excluir períodos | Apenas administrador |

- Cada usuário faz login com e-mail e senha
- Os dados ficam salvos no banco e visíveis para toda a equipe em tempo real
- Para adicionar novos usuários, vá em Supabase > Authentication > Users

---

## Problemas comuns

**"Erro ao salvar"** → Verifique se a URL e a chave do Supabase foram coladas corretamente nos dois arquivos HTML

**"Página em branco"** → Abra o Console do navegador (F12) e veja a mensagem de erro

**Usuário não consegue logar** → Confirme que o e-mail e a senha foram criados corretamente no Supabase

**Gráficos não aparecem** → Aguarde o JavaScript carregar completamente; se persistir, recarregue a página
