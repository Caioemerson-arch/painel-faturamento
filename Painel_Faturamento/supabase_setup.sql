-- Execute este script no SQL Editor do Supabase
-- Acesse: seu projeto > SQL Editor > New Query

-- 1. Cria a tabela de faturamento
CREATE TABLE IF NOT EXISTS faturamento (
  id          BIGSERIAL PRIMARY KEY,
  mes         INT NOT NULL CHECK (mes BETWEEN 0 AND 11),
  ano         INT NOT NULL,
  meta        NUMERIC DEFAULT 0,
  services    JSONB DEFAULT '[]',
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE (mes, ano)
);

-- 2. Atualiza updated_at automaticamente
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_updated_at
BEFORE UPDATE ON faturamento
FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- 3. Habilita Row Level Security
ALTER TABLE faturamento ENABLE ROW LEVEL SECURITY;

-- 4. Qualquer usuário autenticado pode LER
CREATE POLICY "leitura para autenticados"
ON faturamento FOR SELECT
TO authenticated
USING (true);

-- 5. Apenas administradores podem ESCREVER
-- (role = 'admin' definida nos metadados do usuário)
CREATE POLICY "escrita apenas admin"
ON faturamento FOR ALL
TO authenticated
USING (
  (auth.jwt() -> 'user_metadata' ->> 'role') = 'admin'
)
WITH CHECK (
  (auth.jwt() -> 'user_metadata' ->> 'role') = 'admin'
);
