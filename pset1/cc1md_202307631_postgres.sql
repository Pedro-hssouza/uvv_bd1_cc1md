
CREATE TABLE public.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                detalhes BYTEA NOT NULL,
                imagem BYTEA NOT NULL,
                imagem_ultima_atualizacao DATE NOT NULL,
                imagem_mime_type VARCHAR(512) NOT NULL,
                imagem_arquivo VARCHAR(512) NOT NULL,
                imagem_charset VARCHAR(512) NOT NULL,
                CONSTRAINT produto_id PRIMARY KEY (produto_id)
);
COMMENT ON TABLE public.produtos IS 'tabela da informações dos produtos';
COMMENT ON COLUMN public.produtos.produto_id IS 'PK da tabela, identificação única do produto';
COMMENT ON COLUMN public.produtos.nome IS 'nome do produto';
COMMENT ON COLUMN public.produtos.preco_unitario IS 'preço unitário do produto';
COMMENT ON COLUMN public.produtos.detalhes IS 'detalhes do produto';
COMMENT ON COLUMN public.produtos.imagem IS 'imagem do produto';
COMMENT ON COLUMN public.produtos.imagem_ultima_atualizacao IS 'data da ultima atualização das imagens';
COMMENT ON COLUMN public.produtos.imagem_mime_type IS 'tipo de imagem do produto';
COMMENT ON COLUMN public.produtos.imagem_arquivo IS 'arquivo da imagem do produto';
COMMENT ON COLUMN public.produtos.imagem_charset IS 'charset da imagem';


CREATE TABLE public.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereo_web VARCHAR(100) NOT NULL,
                endereo_fisico VARCHAR(512) NOT NULL,
                latitude_ NUMERIC NOT NULL,
                longitude_ NUMERIC NOT NULL,
                logo BYTEA NOT NULL,
                logo_mime_type VARCHAR(512) NOT NULL,
                logo_arquivo VARCHAR(512) NOT NULL,
                logo_charset VARCHAR NOT NULL,
                logo_ultima_atualizacao DATE NOT NULL,
                CONSTRAINT loja_id PRIMARY KEY (loja_id)
);
COMMENT ON TABLE public.lojas IS 'informações da loja';
COMMENT ON COLUMN public.lojas.loja_id IS 'Pk da tabela, identificação única de cada loja';
COMMENT ON COLUMN public.lojas.nome IS 'nome da loja';
COMMENT ON COLUMN public.lojas.endereo_web IS 'endereço web da loja';
COMMENT ON COLUMN public.lojas.endereo_fisico IS 'endereço fisico da loja';
COMMENT ON COLUMN public.lojas.latitude_ IS 'latitude das lojas';
COMMENT ON COLUMN public.lojas.longitude_ IS 'logintude das lojas';
COMMENT ON COLUMN public.lojas.logo IS 'logo da loja';
COMMENT ON COLUMN public.lojas.logo_mime_type IS 'tipo de logo';
COMMENT ON COLUMN public.lojas.logo_arquivo IS 'arquivo da logo';
COMMENT ON COLUMN public.lojas.logo_charset IS 'charset da logo';
COMMENT ON COLUMN public.lojas.logo_ultima_atualizacao IS 'data  da ultima atualização da logo';


CREATE TABLE public.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
);
COMMENT ON COLUMN public.estoques.estoque_id IS 'PK da tabela, identificação única do estoque';
COMMENT ON COLUMN public.estoques.loja_id IS 'PK da tabela lojas e nessa tabela Fk  e cria um relacionamento da tabelas';
COMMENT ON COLUMN public.estoques.produto_id IS 'PK da tabela produtos e nessa tabela Fk  e cria-se um relacionamento da tabelas';
COMMENT ON COLUMN public.estoques.quantidade IS 'quantidade do estoque';


CREATE TABLE public.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone_ VARCHAR(20) NOT NULL,
                telefone__1 VARCHAR(20) NOT NULL,
                telefone3 VARCHAR(20) NOT NULL,
                CONSTRAINT cliente_id PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE public.clientes IS 'Tabela das  informações do clientes';
COMMENT ON COLUMN public.clientes.cliente_id IS 'A coluna que cada cliente vai receber uma identificação única';
COMMENT ON COLUMN public.clientes.email IS 'o registro do email do cliente';
COMMENT ON COLUMN public.clientes.nome IS 'nome do cliente';
COMMENT ON COLUMN public.clientes.telefone_ IS 'telefone 1 do cliente';
COMMENT ON COLUMN public.clientes.telefone__1 IS 'telefone 2 do cliente';
COMMENT ON COLUMN public.clientes.telefone3 IS 'telefone 3 do cliente';


CREATE TABLE public.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereo_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envios_id PRIMARY KEY (envio_id)
);
COMMENT ON TABLE public.envios IS 'informações de envio';
COMMENT ON COLUMN public.envios.envio_id IS 'pk da tabela envios e serve para indentificação única de cada pedido';
COMMENT ON COLUMN public.envios.loja_id IS 'Pk da tabela lojas , aqui se torna um fk e serve para criar o relacionamento entre as duas';
COMMENT ON COLUMN public.envios.cliente_id IS 'Pk da tabela clientes , aqui se torna um fk e serve para criar o relacionamento entre as duas';
COMMENT ON COLUMN public.envios.endereo_entrega IS 'informações de endereço e entrega';
COMMENT ON COLUMN public.envios.status IS 'status da entrega';


CREATE TABLE public.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE public.pedidos IS 'tabela de pedido do clientes';
COMMENT ON COLUMN public.pedidos.pedido_id IS 'Identificação única de cada pedido';
COMMENT ON COLUMN public.pedidos.data_hora IS 'identificação de tempo e hora do produto';
COMMENT ON COLUMN public.pedidos.cliente_id IS 'PK da tabela cliente quem vem para cá em FK para criar um relacionamento entre as tabelas';
COMMENT ON COLUMN public.pedidos.status IS 'status do pedido';
COMMENT ON COLUMN public.pedidos.loja_id IS 'PK da tabela lojas que serve para identificação da loja e criação de relacionamento entre as tabelas';


CREATE TABLE public.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedidos_itens_pk PRIMARY KEY (pedido_id, produto_id)
);
COMMENT ON TABLE public.pedidos_itens IS 'tabela da informações de pedido dos itens';
COMMENT ON COLUMN public.pedidos_itens.pedido_id IS 'Pk da tabela e FK da tabela pois esse pedido_id seria da tabela pedidos';
COMMENT ON COLUMN public.pedidos_itens.produto_id IS 'É chave PFK que puxa da tabela produtos ';
COMMENT ON COLUMN public.pedidos_itens.numero_da_linha IS 'numero da linha do pedido';
COMMENT ON COLUMN public.pedidos_itens.preco_unitario IS 'preço unitario do item pedido';
COMMENT ON COLUMN public.pedidos_itens.quantidade IS 'quantidade do item pedido';
COMMENT ON COLUMN public.pedidos_itens.envio_id IS '(FK) envio_id é uma PK da tabela envios';


ALTER TABLE public.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES public.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES public.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES public.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES public.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES public.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES public.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE; 