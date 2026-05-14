# Gestão de Ativos de Transmissão de Energia (Electric Transmission Data Management)

Este projeto implementa um modelo de dados geoespacial robusto para a gestão de ativos em sistemas de transmissão de energia elétrica. O modelo é focado em alta disponibilidade, integridade de rede e suporte a operações complexas de engenharia e manutenção.

## Tecnologias Utilizadas

* **SQL**: Linguagem principal para definição de esquemas e manipulação de dados.
* **PostgreSQL 15 / PostGIS 3.3**: Banco de dados relacional com extensões espaciais para suporte a geometrias de redes elétricas.
* **Docker & Docker Compose**: Orquestração de ambiente para garantir paridade entre desenvolvimento e produção.
* **Bash**: Scripts de automação para inicialização (`init.sh`) e reconstrução de containers (`rebuild_container.sh`).

## Estrutura do Projeto

O projeto está organizado para facilitar a manutenção e evolução do esquema:

* **`/db/00_extensions`**: Habilitação de extensões necessárias (ex: `postgis`, `pgcrypto`).
* **`/db/01_schema`**:
* `01_schemas.sql`: Definição dos namespaces (`domains`, `utility_network`, etc.).
* `02_domains`: Tabelas de domínio e tipos (ex: status de construção, tipos de condutores, níveis de tensão).
* `03_datasets`: Definição das tabelas principais como `electric_transmission_assembly`, `device`, `junction` e `line`.


* **`/db/02_functions`**: Gatilhos (triggers) e funções para regras de negócio e validação de topologia.
* **`/db/03_seeds`**: Dados iniciais para popular as tabelas de domínio.

## Modelagem de Dados

O modelo segue princípios de **Utility Network**, segmentando os ativos em:

1. **Assemblies**: Agrupamentos complexos de equipamentos (ex: Vão de Alta Tensão/Bay).
2. **Devices**: Equipamentos operacionais (ex: Transformadores, Disjuntores, Geradores).
3. **Junctions**: Pontos de conexão e anexos físicos (ex: Pontos de conexão de cabos, anexos em estruturas).
4. **Lines**: Condutores e cabos (aéreos, subterrâneos ou submersos) com detalhes técnicos de resistência e material.
5. **Structure**: Modelagem física de suporte (Postes, Torres, Estações e Limites de Subestações).

## Como Iniciar

### Pré-requisitos

* Docker e Docker Compose instalados.
* Porta `5440` livre (configuração padrão no `.env`).

### Instalação

1. Clone o repositório:
```bash
git clone <url-do-repositorio>
cd electric-transmission-data-management

```


2. Configure as variáveis de ambiente (opcional):
```bash
cp .env.example .env

```


3. Inicie o ambiente:
```bash
docker-compose up -d

```


*O script `db/init.sh` será executado automaticamente pelo container para criar a estrutura e carregar os dados iniciais.*
4. Para reconstruir o banco do zero:
```bash
./rebuild_container.sh

```



## Configurações de Banco de Dados (Padrão)

* **Host**: `localhost`
* **Porta**: `5440`
* **Database**: `postgis`
* **User**: `postgres`
* **Password**: `secret`

---

*Este projeto utiliza Geometrias (Point, LineString, Polygon) com o SRID 4326 (WGS84) para representação geográfica dos ativos.*
