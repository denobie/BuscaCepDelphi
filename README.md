# BuscaCepDelphi
Projeto para buscar CEP pelo próprio CEP ou por Estado/Cidade/Endereço no ViaCep.com.br podendo obter o retorno por JSON ou XML.
Esse Projeto visa resolver o seguinte caso de uso:

1. Possibilitar armazenar os resultados das consultas em uma tabela.
2. Possibilitar que as consultas possam ser feitas tanto por CEP quanto por Endereço Completo.
3. A aplicação deverá conter possibilidades do resultado da consulta VIACEP, ser por JSON e outra por XML, sendo assim desenvolva métodos que possibilite que o result possa vir tanto por JSON quanto por XML
4. Permitir navegar através dos registros já inseridos, e caso seja feita a consulta de um CEP ou Endereço que já exista cadastrado, deverá perguntar ao usuário se deseja atualizar os dados encontrados.

# Tecnologias Utilizadas
Delphi 12 Community Edition com FireDAC para conexão ao Banco de Dados.
Banco de Dados PostgreSQL 16.4.

# Informações Técnicas do Projeto
Arquitetura Utilizada: Factory.
Design Pattern Aplicado: Abstract Factory.
Boas Práticas Aplicadas: Interfaces, Clean Code, Solid, Heranças, Abstração, Orientação a objetos,
conceito de Service.

Criado uma Factory para Componentes de Conexão com Banco de Dados sendo abstraído para iConexao,
onde pode ser implementado integrações futuras para componentes como Zeos, Unidac, etc.

Criado uma Factory para a interface de busca de cep, onde é definido o objeto que irá buscar o CEP
tratando o retorno quando for JSON ou XML.

Criado uma Factory para a interface de Endereco, onde retorna uma service que irá fazer toda a
parte de integração com o Banco de Dados.

Obs: Algumas factories só possuem uma interface, pois não surgiu a demanda de novas funcionalidades.

# Requisitos Técnicos
Banco de Dados PostgreSQL 16 (Utilizada versão 16.4). Você pode restaurar o backup do Banco que está [aqui](https://github.com/denobie/BuscaCepDelphi/blob/main/bin/buscaCEP.bkp) ou utilizar o script de criação das tabelas que está [aqui](https://github.com/denobie/BuscaCepDelphi/blob/main/bin/ScriptTabela.sql).
Nome do Banco Utilizar foi buscaCep.
Exemplo Comando para Restaurar: pg_restore -U <usuario> -d <database> -h <host> -p <porta> -v <caminho do buscaCEP.bkp>

Copiar o executável do projeto, o buscaCep.ini e a [libpq.dll](https://github.com/denobie/BuscaCepDelphi/blob/main/bin/libpq.dll)  para conexão com o PostgreSQL para a mesma pasta. Ou pode baixar o projeto e executar o executável direto da pasta bin.

No buscaCep.ini está as informações para conectar ao Banco de Dados altere para suas informações caso necessite;

```INI
[Database]
DriverName=PG
Server=127.0.0.1
Database=buscaCep
User_Name=postgres
Password=deno
Port=5432
```

# Mode de Usar
O Sistema possui 3 abas sendo elas:
1. Buscar CEP.
Nessa aba é possível buscar um Endereço através do seu CEP ou visulizar o CEP cadastrado no Banco de Dados.

1.1. Para Buscar o CEP informe o CEP deseja no campo CEP, escolha qual o Tipo de Retorno desejado e clique em Consultar CEP.
* Caso o CEP seja válido e existente, será aberto uma tela com os Dados do Endereço e o mesmo será cadastrado na tabela Endereco.
* Caso seja um CEP inválido, difernete de 8 numeros, irá mostrar um mensagem avisando que o CEP é inválido.
* Caso o CEP não exista no Banco de Dados e nem na base do ViaCep será mostrado uma mensagem de que o CEP é inexistente.
* Caso o CEP já exista no Banco de Dados, será mostrado uma mensagem perguntando se deseja visulizar o CEP já cadastrado ou se deseja atualizar. Escolhido a opção Atualziar o Endereço vinculado ao CEP será atualizado.

1.2. Para visulizar, informe o CEP desejado e clique no botão Listar CEP.

2. Buscar Endereço
Nessa aba é possível buscar um Endereço através da combinação UF(Estado), Cidade e descrição do endereço(logradouro) e listar os Endereços já cadastrados para essa combinação.
Caso retorne mais de um CEP para essa combinação, o usuário será direcionado para a aba CEPs Cadastrados onde será listado todos os CEPs para a combinação.

2.1. Para Buscar o CEP por Endereço selecio a UF, informe a Cidade e o Endereço, escolha qual o Tipo de Retorno desejado e clique em Consultar CEPs.
* Caso o Endereço seja válido e existente, será aberto uma tela com os Dados do Endereço caso retorno apenas 1 CEP caso retorne mais de 1 CEP o usuário será redirecionado para a Aba CEPs Cadastrados onde será listados todos os CEPs encontrados e em ambos os casos os CEPs serão cadastrados na tabela Endereco.
* Caso a combinação do Endereço seja inválida uf, cidade e endereco menores que 3 letras, irá mostrar um mensagem avisando que o Endereço é inválido.
* Caso a combinação do Endereço não exista no Banco de Dados e nem na base do ViaCep será mostrado uma mensagem de que o CEP é inexistente.
* Caso a combinação do Endereço já exista no Banco de Dados, será mostrado uma mensagem perguntando se deseja listar os CEPs já cadastrados ou se deseja atualizar. Escolhido a opção Atualziar, os Endereços retornados serão atualizados.

2.2. Para visulizar, informe a combinação do Endereço desejado e clique no botão Listar Endereços.

3. CEPs Cadastrados
Essa aba irá listar todos os Endereços cadastrados no Banco de Dados cliando em Listar Todos Endereços.
Com um duplo clique no registro da Grid é possível abrir os dados do Endereço selecionado.
Clicando com o botão direito sobre a Grid é possível excluir o Endereço selecionado.

