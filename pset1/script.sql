/* Criaçao de um projeto de banco de dados para a disciplina de Design e Desenvolvimento de Banco de Dados com professor Abraantes.
Aluno:Pedro Henrique Souza Santos*/


DROP USER IF EXISTS pedro_souza;
DROP DATABASE IF EXISTS lojas_uvv;
/* Apagando o banco de dados com nome 'lojas_uvv' caso ja exista um, e apagando também o usuário 'pedro_santos' caso exista*/


/* Criando o  usuário para dar autorizações de acesso a banco de dados a ele*/
 CREATE USER pedro_souza
with createdb 
createrole 
encrypted password '3691052uvv';

/*Criando o banco de dados "lojas" com a seguintes predefinições*/
CREATE DATABASE lojas_uvv 
        WITH 
        owner = pedro_souza
        encoding = "UTF8"
        lc_collate ='pt_BR.UTF-8'
        lc_ctype = 'pt_BR.UTF-8'
        allow_connections = TRUE;


\setenv PGPASSWORD 3691052uvv
\c lojas_uvv pedro_souza;

/*Criação da esquema loja se não existir*/
CREATE SCHEMA IF NOT EXISTS lojas
AUTHORIZATION pedro_souza;

ALTER USER pedro_souza
SET SEARCH_PATH TO lojas, "$user", public;

/*Criação da tabela produtos*/
CREATE TABLE produtos (
                produto_id                  NUMERIC(38) NOT NULL,
                nome                        VARCHAR(255) NOT NULL,
                preco_unitario              NUMERIC(10,2),
                detalhes                    BYTEA,
                imagem                      BYTEA,
                imagem_ultima_atualizacao   DATE,
                imagem_mime_type            VARCHAR(512),
                imagem_arquivo              VARCHAR(512),
                imagem_charset              VARCHAR(512),
                CONSTRAINT pk_produto_id    PRIMARY KEY (produto_id)-- Criação da pk da tabela
);
 /*Nesta parte é feito um comentario sobre cada coluna explicando o que vai ser armazenado*/

COMMENT ON TABLE produtos IS 'tabela da informações dos produtos';
COMMENT ON COLUMN produtos.produto_id IS 'PK da tabela, identificação única do produto';
COMMENT ON COLUMN produtos.nome IS 'nome do produto';
COMMENT ON COLUMN produtos.preco_unitario IS 'preço unitário do produto';
COMMENT ON COLUMN produtos.detalhes IS 'detalhes do produto';
COMMENT ON COLUMN produtos.imagem IS 'imagem do produto';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'data da ultima atualização das imagens';
COMMENT ON COLUMN produtos.imagem_mime_type IS 'tipo de imagem do produto';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'arquivo da imagem do produto';
COMMENT ON COLUMN produtos.imagem_charset IS 'charset da imagem';

 /*Criação da tabela lojas*/
CREATE TABLE lojas (
                loja_id                     NUMERIC(38) NOT NULL,
                nome                        VARCHAR(255) NOT NULL,
                endereco_web                VARCHAR(100),
                endereco_fisico             VARCHAR(512) ,
                latitude_                   NUMERIC,
                longitude_                  NUMERIC,
                logo                        BYTEA,
                logo_mime_type              VARCHAR(512),
                logo_arquivo                VARCHAR(512),
                logo_charset                VARCHAR,
                logo_ultima_atualizacao     DATE,
                CONSTRAINT pK_loja_id       PRIMARY KEY (loja_id)-- Criação da pk da tabela
);
 /*Nesta parte é feito um comentario sobre cada coluna explicando o que vai ser armazenado*/
 
COMMENT ON TABLE lojas IS 'informações da loja';
COMMENT ON COLUMN lojas.loja_id IS 'Pk da tabela, identificação única de cada loja';
COMMENT ON COLUMN lojas.nome IS 'nome da loja';
COMMENT ON COLUMN lojas.endereco_web IS 'endereço web da loja';
COMMENT ON COLUMN lojas.endereco_fisico IS 'endereço fisico da loja';
COMMENT ON COLUMN lojas.latitude_ IS 'latitude das lojas';
COMMENT ON COLUMN lojas.longitude_ IS 'logintude das lojas';
COMMENT ON COLUMN lojas.logo IS 'logo da loja';
COMMENT ON COLUMN lojas.logo_mime_type IS 'tipo de logo';
COMMENT ON COLUMN lojas.logo_arquivo IS 'arquivo da logo';
COMMENT ON COLUMN lojas.logo_charset IS 'charset da logo';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'data  da ultima atualização da logo';

 /*Criação da tabela estoques*/
CREATE TABLE estoques (
                estoque_id                  NUMERIC(38) NOT NULL,
                loja_id                     NUMERIC(38) NOT NULL,
                produto_id                  NUMERIC(38) NOT NULL,
                quantidade                  NUMERIC(38),
                CONSTRAINT pk_estoque_id    PRIMARY KEY (estoque_id)-- Criação da pk da tabela
            );
 /*Nesta parte é feito um comentario sobre cada coluna explicando o que vai ser armazenado*/

COMMENT ON COLUMN estoques.estoque_id IS 'PK da tabela, identificação única do estoque';
COMMENT ON COLUMN estoques.loja_id IS 'PK da tabela lojas e nessa tabela Fk  e cria um relacionamento da tabelas';
COMMENT ON COLUMN estoques.produto_id IS 'PK da tabela produtos e nessa tabela Fk  e cria-se um relacionamento da tabelas';
COMMENT ON COLUMN estoques.quantidade IS 'quantidade do estoque';

 /*Criação da tabela clientes*/
CREATE TABLE clientes (
                cliente_id                  NUMERIC(38) NOT NULL,
                email                       VARCHAR(255) NOT NULL,
                nome                        VARCHAR(255) NOT NULL,
                telefone1                   VARCHAR(20),
                telefone2                   VARCHAR(20),
                telefone3                   VARCHAR(20),
                CONSTRAINT pk_cliente_id    PRIMARY KEY (cliente_id)-- Criação da pk da tabela
            );
 /*Nesta parte é feito um comentario sobre cada coluna explicando o que vai ser armazenado*/

COMMENT ON TABLE clientes IS 'Tabela das  informações do clientes';
COMMENT ON COLUMN clientes.cliente_id IS 'A coluna que cada cliente vai receber uma identificação única';
COMMENT ON COLUMN clientes.email IS 'o registro do email do cliente';
COMMENT ON COLUMN clientes.nome IS 'nome do cliente';
COMMENT ON COLUMN clientes.telefone1 IS 'telefone 1 do cliente';
COMMENT ON COLUMN clientes.telefone2 IS 'telefone 2 do cliente';
COMMENT ON COLUMN clientes.telefone3 IS 'telefone 3 do cliente';

 /*Criação da tabela envios*/
CREATE TABLE envios (
                envio_id                    NUMERIC(38) NOT NULL,
                loja_id                     NUMERIC(38) NOT NULL,
                cliente_id                  NUMERIC(38) NOT NULL,
                endereco_entrega            VARCHAR(512),
                status                      VARCHAR(15),
                CONSTRAINT pK_envios_id     PRIMARY KEY (envio_id)-- Criação da pk da tabela
            );
 /*Nesta parte é feito um comentario sobre cada coluna explicando o que vai ser armazenado*/

COMMENT ON TABLE envios IS 'informações de envio';
COMMENT ON COLUMN envios.envio_id IS 'pk da tabela envios e serve para indentificação única de cada pedido';
COMMENT ON COLUMN envios.loja_id IS 'Pk da tabela lojas , aqui se torna um fk e serve para criar o relacionamento entre as duas';
COMMENT ON COLUMN envios.cliente_id IS 'Pk da tabela clientes , aqui se torna um fk e serve para criar o relacionamento entre as duas';
COMMENT ON COLUMN envios.endereco_entrega IS 'informações de endereço e entrega';
COMMENT ON COLUMN envios.status IS 'status da entrega';

 /*Criação da tabela pedidos*/
CREATE TABLE pedidos (
                pedido_id                   NUMERIC(38) NOT NULL,
                data_hora                   TIMESTAMP   NOT NULL,
                cliente_id                  NUMERIC(38) NOT NULL,
                status                      VARCHAR(15) NOT NULL,
                loja_id                     NUMERIC(38) NOT NULL,
                CONSTRAINT pK_pedido_id     PRIMARY KEY (pedido_id)-- Criação da pk da tabela
            );
 /*Nesta parte é feito um comentario sobre cada coluna explicando o que vai ser armazenado*/

COMMENT ON TABLE pedidos IS 'tabela de pedido do clientes';
COMMENT ON COLUMN pedidos.pedido_id IS 'Identificação única de cada pedido';
COMMENT ON COLUMN pedidos.data_hora IS 'identificação de tempo e hora do produto';
COMMENT ON COLUMN pedidos.cliente_id IS 'PK da tabela cliente quem vem para cá em FK para criar um relacionamento entre as tabelas';
COMMENT ON COLUMN pedidos.status IS 'status do pedido';
COMMENT ON COLUMN pedidos.loja_id IS 'PK da tabela lojas que serve para identificação da loja e criação de relacionamento entre as tabelas';

/*Criação da tabela pedidos_itens*/
CREATE TABLE pedidos_itens (
                pedido_id                       NUMERIC(38) NOT NULL,
                produto_id                      NUMERIC(38) NOT NULL,
                numero_da_linha                 NUMERIC(38) NOT NULL,
                preco_unitario                  NUMERIC(10,2) NOT NULL,
                quantidade                      NUMERIC(38) NOT NULL,
                envio_id                        NUMERIC(38),
                CONSTRAINT pK_pedidos_itens     PRIMARY KEY (pedido_id, produto_id)-- Criação da pk da tabela
                );
/*Nesta parte é feito um comentario sobre cada coluna explicando o que vai ser armazenado*/

COMMENT ON TABLE pedidos_itens IS 'tabela da informações de pedido dos itens';
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'Pk da tabela e FK da tabela pois esse pedido_id seria da tabela pedidos';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'É chave PFK que puxa da tabela produtos ';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'numero da linha do pedido';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'preço unitario do item pedido';
COMMENT ON COLUMN pedidos_itens.quantidade IS 'quantidade do item pedido';
COMMENT ON COLUMN pedidos_itens.envio_id IS '(FK) envio_id é uma PK da tabela envios';


ALTER TABLE estoques ADD CONSTRAINT fk_produtos_estoques
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT fk_produtos_pedidos_itens
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT fk_lojas_pedidos
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT fk_lojas_envios
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE estoques ADD CONSTRAINT fk_lojas_estoques
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT fk_clientes_pedidos
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT fk_clientes_envios
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT fk_envios_pedidos_itens
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT fk_pedidos_pedidos_itens
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE; 

/*São as criações da das constraints das tabelas*/

ALTER TABLE produtos
     ADD CONSTRAINT cc_produtos_preco_unitario
            CHECK( preco_unitario > 0 );
-- Essa Constraint impedem que valores negativos seja inseridos:

ALTER TABLE  envios
        ADD CONSTRAINT cc_envios_status
            CHECK( status in('ENVIADO','TRANSITO','ENTREGUE','CRIADO') );
-- Essa constraint ela impede que outro elementos seja inseridos que não seja os citados dentro do parênteses:

ALTER TABLE estoques
    ADD CONSTRAINT cc_estoques_quantidade
            CHECK( quantidade > 0 );
    -- Essa Constraint impede que seja inserido valores de quantidade do estoque seja negativo:

ALTER TABLE pedidos_itens
    ADD CONSTRAINT cc_pedidos_itens_preco_unitario
        CHECK( preco_unitario > 0 );
-- Essa Constraint impedem que valores negativos seja inseridos:

ALTER TABLE pedidos_itens
    ADD CONSTRAINT cc_pedidos_itens_quantidade
            CHECK( quantidade > 0 );
-- Essa Constraint impede que os valor de quantidade seja negativo:


ALTER TABLE  pedidos
    ADD CONSTRAINT cc_pedidos_status
            CHECK( status in('COMPLETO','CANCELADO','ABERTO','REEMBOLSADO','PAGO','ENVIADO') );
-- Essa constraint ela impede que outro elementos seja inseridos que não seja os citados dentro do parênteses:

        