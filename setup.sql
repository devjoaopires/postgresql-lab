-- Execute a partir da raiz do repositório:
-- psql -d postgresql_lab -f setup.sql

\set ON_ERROR_STOP on

\echo '1/7 - Criando tabelas'
\ir schema/01_tables.sql

\echo '2/7 - Aplicando constraints'
\ir schema/02_constraints.sql

\echo '3/7 - Criando relacionamentos'
\ir schema/03_relationships.sql

\echo '4/7 - Criando indices'
\ir schema/04_indexes.sql

\echo '5/7 - Criando functions'
\ir functions/functions.sql

\echo '6/7 - Criando triggers'
\ir functions/triggers.sql

\echo '7/7 - Inserindo dataset ficticio'
\ir examples/ecommerce.sql

\echo 'PostgreSQL Lab configurado com sucesso.'
