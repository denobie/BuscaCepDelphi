--Você pode criar o Banco de Dados da maneira que preferir com encode UTF-8.

--Adicionar a extensão unaccent ao Banco de Dados
CREATE EXTENSION IF NOT EXISTS unaccent;

--Essa tabela deverá ser criado no schema PUBLIC do Banco.

CREATE TABLE endereco (
	codigo numeric(10) NOT NULL,
	cep varchar(8) NULL,
	logradouro varchar(250) NULL,
	complemento varchar(250) NULL,
	unidade varchar(250) NULL,
	bairro varchar(250) NULL,
	localidade varchar(250) NULL,
	uf varchar(2) NULL,
	regiao varchar(50) NULL,
	codigo_ibge numeric(10) NULL,
	codigo_gia varchar(50) NULL,
	ddd numeric(2) NULL,
	siafi varchar(10) NULL,
	CONSTRAINT pk_endereco PRIMARY KEY (codigo)
);
CREATE INDEX idx_endereco_cep ON endereco (cep);

--Caso ocorra problemas de sequence criar a mesma.
--Obs: O sistema já está tratando para criar a sequence automaticamente.
create sequence seqcodendereco;