# BuscaCepDelphi  

Projeto para buscar CEP por meio do próprio CEP ou por Estado/Cidade/Endereço utilizando a API do ViaCep.com.br, com suporte para retorno em JSON ou XML.  

## Objetivo  

Este projeto visa atender os seguintes casos de uso:  

1. Armazenar os resultados das consultas em uma tabela.  
2. Permitir consultas tanto por CEP quanto por endereço completo.  
3. Oferecer suporte para retorno dos dados em JSON e XML, implementando métodos específicos para cada formato.  
4. Permitir a navegação pelos registros já inseridos. Caso um CEP ou endereço já cadastrado seja consultado novamente, o sistema deverá perguntar ao usuário se deseja atualizar os dados existentes.  

## Tecnologias Utilizadas  

- **Linguagem:** Delphi 12 Community Edition  
- **Banco de Dados:** PostgreSQL 16.4  
- **Conexão com o Banco:** FireDAC  

## Arquitetura e Boas Práticas  

- **Arquitetura:** Factory  
- **Design Pattern Aplicado:** Abstract Factory  
- **Boas Práticas:** Interfaces, Clean Code, SOLID, Herança, Abstração e Orientação a Objetos  
- **Componentes:**  
  - Factory para componentes de conexão com o banco de dados, abstraída por `iConexao`, permitindo futuras integrações com Zeos, Unidac, etc.  
  - Factory para a interface de busca de CEP, que gerencia o retorno dos dados em JSON ou XML.  
  - Factory para a interface de endereço, responsável pela integração com o banco de dados.  

> **Observação:** Algumas factories possuem apenas uma implementação, pois ainda não houve demanda por novas funcionalidades.  

## Requisitos Técnicos  

- **Banco de Dados:** PostgreSQL 16 (utilizada versão 16.4).  
- **Criação do Banco:** Você pode restaurar o backup disponível [aqui](https://github.com/denobie/BuscaCepDelphi/blob/main/bin/buscaCEP.bkp) ou utilizar o script de criação das tabelas [aqui](https://github.com/denobie/BuscaCepDelphi/blob/main/bin/ScriptTabela.sql).  
- **Nome do Banco:** `buscaCep`  

### Exemplo de comando para restaurar o banco:  

```sh
pg_restore -U <usuario> -d <database> -h <host> -p <porta> -v <caminho do buscaCEP.bkp>
```  

Para executar o sistema:  

1. Copie o executável do projeto (`buscaCep.exe`), o arquivo `buscaCep.ini` e a [libpq.dll](https://github.com/denobie/BuscaCepDelphi/blob/main/bin/libpq.dll) para a mesma pasta.  
2. Alternativamente, baixe o projeto e execute diretamente da pasta `bin`.  
3. O arquivo `buscaCep.ini` contém as configurações para conexão ao banco de dados:  

```ini
[Database]
DriverName=PG
Server=127.0.0.1
Database=buscaCep
User_Name=postgres
Password=deno
Port=5432
```  

---

## Como Usar  

O sistema possui **três abas principais**:  

### 1. Buscar CEP  

Permite buscar um endereço através do seu CEP ou visualizar os CEPs cadastrados no banco de dados.  

#### 1.1 Como consultar um CEP  

1. Informe o CEP no campo correspondente.  
2. Escolha o tipo de retorno (JSON ou XML).  
3. Clique em **Consultar CEP**.  

**Resultados possíveis:**  

- Se o CEP for válido e existir no ViaCep, os dados do endereço serão exibidos e salvos no banco de dados.  
- Se o CEP for inválido (diferente de 8 números), uma mensagem de erro será exibida.  
- Se o CEP não existir nem no banco de dados nem no ViaCep, uma mensagem informará que o CEP é inexistente.  
- Se o CEP já estiver cadastrado no banco de dados, será perguntado se deseja visualizar ou atualizar os dados existentes.  

#### 1.2 Como listar um CEP já cadastrado  

1. Informe o CEP desejado.  
2. Clique no botão **Listar CEP**.  

---

### 2. Buscar Endereço  

Permite buscar um endereço pela combinação **UF (Estado) + Cidade + Logradouro** e listar os registros cadastrados.  

#### 2.1 Como consultar um CEP por endereço  

1. Selecione a UF.  
2. Informe a cidade e o logradouro.  
3. Escolha o tipo de retorno (JSON ou XML).  
4. Clique em **Consultar CEPs**.  

**Resultados possíveis:**  

- Se apenas um CEP for encontrado, os dados do endereço serão exibidos e cadastrados no banco.  
- Se mais de um CEP for encontrado, o usuário será redirecionado para a aba **CEPs Cadastrados**, onde todos os resultados serão listados.  
- Se a combinação de endereço for inválida (UF, cidade ou logradouro com menos de 3 caracteres), uma mensagem de erro será exibida.  
- Se a combinação não existir no banco nem no ViaCep, uma mensagem informará que o CEP é inexistente.  
- Se a combinação já estiver cadastrada, será perguntado se deseja listar os CEPs já existentes ou atualizar os dados.  

#### 2.2 Como listar endereços já cadastrados  

1. Informe a combinação de endereço desejada.  
2. Clique no botão **Listar Endereços**.  

---

### 3. CEPs Cadastrados  

Exibe todos os endereços cadastrados no banco de dados.  

- Clique em **Listar Todos Endereços** para visualizar os registros.  
- **Duplo clique** em um registro abre os detalhes do endereço.  
- **Botão direito** sobre um registro permite excluir o endereço selecionado.  