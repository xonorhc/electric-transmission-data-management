#!/bin/bash
set -e

# Função para percorrer pastas e subpastas executando arquivos SQL em ordem
run_sql_recursive() {
  local search_path=$1
  echo ">> Explorando: $search_path"

  # 'find' busca todos os .sql, 'sort' garante a ordem numérica/alfabética
  find "$search_path" -name "*.sql" | sort | while read -r file; do
    echo "   [Executando] $file"
    psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f "$file"
  done
}

echo ">> Iniciando provisionamento do banco: $POSTGRES_DB"

# 1. Extensões (Rodar primeiro o setup do FDW que criamos)
run_sql_recursive "/docker-entrypoint-initdb.d/00_extensions"

# 2. Schemas e Subpastas (02_catalogs, 03_water_system, etc)
run_sql_recursive "/docker-entrypoint-initdb.d/01_schema"

# 3. Funções
run_sql_recursive "/docker-entrypoint-initdb.d/02_functions"

# 4. Dados (Seeds)
run_sql_recursive "/docker-entrypoint-initdb.d/03_seeds"

# 5. Migrations (se houver)
if [ -d "/docker-entrypoint-initdb.d/04_migrations" ]; then
  run_sql_recursive "/docker-entrypoint-initdb.d/04_migrations"
fi

echo ">> Finalizado com sucesso!"
