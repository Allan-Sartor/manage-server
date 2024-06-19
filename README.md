# Gerenciador de Unidades de Negócio

Este projeto é uma API desenvolvida para gerenciar unidades de negócios, clientes, inventários, transações e planos de assinatura. Ele é projetado para ser utilizado por pequenas empresas para gerenciar suas operações diárias, incluindo vendas, compras, despesas e receitas. A API é construída usando Ruby on Rails e inclui autenticação baseada em token usando Devise Token Auth.

## Funcionalidades Principais

### Autenticação

- **Usuário (User)**: Gerencia a autenticação e registro de usuários utilizando Devise e Devise Token Auth.
  - **Registro**: Permite que novos usuários se registrem.
  - **Login/Logout**: Permite que usuários façam login e logout.
  - **Recuperação de Senha**: Permite que usuários recuperem suas senhas.

### Unidades de Negócio (Business Units)

- **Criação**: Usuários podem criar unidades de negócio vinculadas a seus perfis.
- **Listagem**: Usuários podem listar todas as unidades de negócio vinculadas ao seu perfil.
- **Visualização**: Usuários podem visualizar detalhes de uma unidade de negócio específica.
- **Atualização**: Usuários podem atualizar informações das unidades de negócio.
- **Exclusão**: Usuários podem excluir unidades de negócio, desde que não tenham transações ou clientes associados, e que não seja a única unidade de negócio do usuário.

### Clientes (Clients)

- **Criação**: Usuários podem adicionar clientes a suas unidades de negócio.
- **Listagem**: Usuários podem listar todos os clientes de suas unidades de negócio.
- **Visualização**: Usuários podem visualizar detalhes de um cliente específico.
- **Atualização**: Usuários podem atualizar informações dos clientes.
- **Exclusão**: Usuários podem excluir clientes.

### Inventário

#### Categorias de Inventário (Inventory Categories)

- **Criação**: Usuários podem criar categorias de inventário.
- **Listagem**: Usuários podem listar todas as categorias de inventário de suas unidades de negócio.

#### Itens de Inventário (Inventory Items)

- **Criação**: Usuários podem adicionar itens ao inventário, vinculando-os a categorias específicas.
- **Listagem**: Usuários podem listar todos os itens do inventário de suas unidades de negócio.

### Transações (Transactions)

- **Criação**: Usuários podem registrar transações (vendas, compras, despesas, receitas, ajustes de inventário) para suas unidades de negócio.
- **Listagem**: Usuários podem listar todas as transações de suas unidades de negócio.
- **Visualização**: Usuários podem visualizar detalhes de uma transação específica.
- **Atualização**: Usuários podem atualizar informações de transações.
- **Exclusão**: Usuários podem excluir transações.

### Planos (Plans)

- **Criação**: Administradores podem criar novos planos de assinatura.
- **Listagem**: Todos os usuários podem listar os planos disponíveis.
- **Visualização**: Todos os usuários podem visualizar detalhes de um plano específico.
- **Atualização**: Administradores podem atualizar informações dos planos de assinatura.

## Modelos e Relacionamentos

### User

- **Associações**:
  - `has_many :business_units`

### BusinessUnit

- **Associações**:
  - `belongs_to :user`
  - `belongs_to :plan`
  - `has_many :clients`
  - `has_many :transactions`
  - `has_many :inventory_items`

- **Validações**:
  - Validação de CNPJ
  - Validação de presença e unicidade de diversos atributos

### Client

- **Associações**:
  - `belongs_to :business_unit`

- **Validações**:
  - `name`: presence
  - `email`: presence, format

### InventoryCategory

- **Associações**:
  - `belongs_to :business_unit`
  - `has_many :inventory_items`

- **Validações**:
  - `name`: presence

### InventoryItem

- **Associações**:
  - `belongs_to :business_unit`
  - `belongs_to :inventory_category`
  - `has_many :transactions`

- **Validações**:
  - `name`: presence
  - `quantity`: presence, numericality
  - `price`: presence, numericality
  - `item_type`: presence

### Plan

- **Associações**:
  - `has_many :business_units`

- **Validações**:
  - `name`: presence
  - `price`: presence, numericality
  - `duration`: presence, inclusion
  - `discount`: numericality, if: :annual_plan?
  - `periodicity`: presence, inclusion
  - `max_business_units`: presence, numericality

### Transaction

- **Associações**:
  - `belongs_to :business_unit`
  - `belongs_to :client`, optional
  - `belongs_to :inventory_item`, optional

- **Validações**:
  - `amount`: presence, numericality
  - `description`: presence
  - `transaction_type`: presence, inclusion
  - `payment_type`: presence
  - `transaction_scope`: presence, inclusion
  - `status`: presence, inclusion

## API Endpoints

### Autenticação

- **POST /auth/sign_in**: Login do usuário
- **POST /auth/sign_out**: Logout do usuário
- **POST /auth**: Registro do usuário
- **POST /auth/password**: Recuperação de senha

### Business Units

- **GET /api/v1/business_units**: Lista todas as unidades de negócio do usuário
- **GET /api/v1/business_units/:id**: Detalhes de uma unidade de negócio
- **POST /api/v1/business_units**: Cria uma nova unidade de negócio
- **PATCH /api/v1/business_units/:id**: Atualiza uma unidade de negócio
- **DELETE /api/v1/business_units/:id**: Exclui uma unidade de negócio

### Clients

- **GET /api/v1/clients**: Lista todos os clientes
- **GET /api/v1/clients/:id**: Detalhes de um cliente
- **POST /api/v1/clients**: Cria um novo cliente
- **PATCH /api/v1/clients/:id**: Atualiza um cliente
- **DELETE /api/v1/clients/:id**: Exclui um cliente

### Inventory Categories

- **GET /api/v1/inventory_categories**: Lista todas as categorias de inventário
- **POST /api/v1/inventory_categories**: Cria uma nova categoria de inventário

### Inventory Items

- **GET /api/v1/inventory_items**: Lista todos os itens de inventário
- **POST /api/v1/inventory_items**: Cria um novo item de inventário

### Plans

- **GET /api/v1/plans**: Lista todos os planos
- **GET /api/v1/plans/:id**: Detalhes de um plano
- **PATCH /api/v1/plans/:id**: Atualiza um plano

### Transactions

- **GET /api/v1/transactions**: Lista todas as transações
- **GET /api/v1/transactions/:id**: Detalhes de uma transação
- **POST /api/v1/transactions**: Cria uma nova transação
- **PATCH /api/v1/transactions/:id**: Atualiza uma transação
- **DELETE /api/v1/transactions/:id**: Exclui uma transação

## Conclusão

Este projeto fornece uma API robusta para gerenciar operações diárias de pequenas empresas, incluindo a gestão de unidades de negócio, clientes, inventários, transações e planos de assinatura. A API é segura e escalável, com suporte para autenticação baseada em token e validações rigorosas para garantir a integridade dos dados.
