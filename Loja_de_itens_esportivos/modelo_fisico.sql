========================
   MODELO RELACIONAL
========================

--> TABLES
------------------------ 

CREATE TABLE estados (
    est_id      NUMBER(6) NOT NULL,
    est_sigla   CHAR(2 CHAR) NOT NULL,
    est_nome  VARCHAR2(30 CHAR) NOT NULL
);

CREATE TABLE cidades (
    cid_id      NUMBER(6) NOT NULL,
    cid_nome    VARCHAR2(50 CHAR) NOT NULL,
    cid_est_id  NUMBER(6) NOT NULL
);

CREATE TABLE clientes (
    cli_id      NUMBER(6) NOT NULL,
    cli_nome    VARCHAR2(50 CHAR) NOT NULL,
    cli_cpf     VARCHAR2(14 CHAR) NOT NULL,
    cli_genero  VARCHAR2(15 CHAR) NOT NULL
);

CREATE TABLE cliente_contatos (
    clc_id        NUMBER(6, 2) NOT NULL,
    clc_telefone  VARCHAR2(14 CHAR) NOT NULL,
    clc_email     VARCHAR2(30 CHAR) NOT NULL,
    clc_cli_id    NUMBER(6) NOT NULL
);

CREATE TABLE departamentos (
    dep_id         NUMBER(6) NOT NULL,
    dep_nome       VARCHAR2(20 CHAR) NOT NULL,
    dep_descricao  VARCHAR2(255 CHAR)
);

CREATE TABLE lojas (
    loj_id        NUMBER(6) NOT NULL,
    loj_nome      VARCHAR2(255 CHAR) NOT NULL,
    loj_endereco  VARCHAR2(255 CHAR) NOT NULL,
    loj_telefone  VARCHAR2(14 CHAR) NOT NULL,
    loj_email     VARCHAR2(30 CHAR),
    loj_cid_id    NUMBER(6) NOT NULL
);

CREATE TABLE tipo_produtos (
    tip_id         NUMBER(6) NOT NULL,
    tip_descricao  VARCHAR2(255 CHAR) NOT NULL,
    tip_dep_id     NUMBER(6) NOT NULL
);

CREATE TABLE produtos (
    pro_id                NUMBER(6) NOT NULL,
    pro_nome              VARCHAR2(50 CHAR) NOT NULL,
    pro_preco_tabela      NUMBER(8, 2) NOT NULL,
    pro_tip_id            NUMBER(6) NOT NULL
);

CREATE TABLE vendas (
    vnd_id           NUMBER(6) NOT NULL,
    vnd_data         DATE NOT NULL,
    vnd_valor_total  NUMBER(8, 2) NOT NULL,
    vnd_vdr_id       NUMBER(6) NOT NULL,
    vnd_cli_id       NUMBER(6) NOT NULL
);

CREATE TABLE vendedores (
    vdr_id       NUMBER(6) NOT NULL,
    vdr_nome     VARCHAR2(50 CHAR) NOT NULL,
    vdr_salario  NUMBER(8, 2) NOT NULL,
    vdr_loj_id   NUMBER(6) NOT NULL
);

CREATE TABLE lojas_produtos (
    lop_loj_id  NUMBER(6) NOT NULL,
    lop_pro_id  NUMBER(6) NOT NULL
);


CREATE TABLE vendas_produtos (
    vnp_pro_id       NUMBER(6) NOT NULL,
    vnp_vnd_id       NUMBER(6) NOT NULL,
    vnp_quantidade   NUMBER(6) NOT NULL,
    vnp_preco_venda  NUMBER(8, 2) NOT NULL
);


--> CONSTRAINTS PK
------------------------

ALTER TABLE estados ADD CONSTRAINT pk_est PRIMARY KEY ( est_id );

ALTER TABLE cidades ADD CONSTRAINT pk_cid PRIMARY KEY ( cid_id );

ALTER TABLE cliente_contatos ADD CONSTRAINT pk_clc PRIMARY KEY ( clc_id );

ALTER TABLE clientes ADD CONSTRAINT pk_cli PRIMARY KEY ( cli_id );

ALTER TABLE departamentos ADD CONSTRAINT pk_dep PRIMARY KEY ( dep_id );

ALTER TABLE lojas ADD CONSTRAINT pk_loj PRIMARY KEY ( loj_id );

ALTER TABLE produtos ADD CONSTRAINT pk_pro PRIMARY KEY ( pro_id );

ALTER TABLE lojas_produtos ADD CONSTRAINT pk_lop PRIMARY KEY ( lop_loj_id,
                                                               lop_pro_id );

ALTER TABLE tipo_produtos ADD CONSTRAINT pk_tip PRIMARY KEY ( tip_id );

ALTER TABLE vendedores ADD CONSTRAINT pk_vdr PRIMARY KEY ( vdr_id );

ALTER TABLE vendas ADD CONSTRAINT pk_vnd PRIMARY KEY ( vnd_id );

ALTER TABLE vendas_produtos ADD CONSTRAINT vnp_pk PRIMARY KEY ( vnp_pro_id,
                                                                vnp_vnd_id );

--> CONSTRAINTS FK
------------------------

ALTER TABLE cidades
    ADD CONSTRAINT fk_cid_est FOREIGN KEY ( cid_est_id )
        REFERENCES estados ( est_id );

ALTER TABLE cliente_contatos
    ADD CONSTRAINT fk_clc_cli FOREIGN KEY ( clc_cli_id )
        REFERENCES clientes ( cli_id );

ALTER TABLE lojas
    ADD CONSTRAINT fk_loj_cid FOREIGN KEY ( loj_cid_id )
        REFERENCES cidades ( cid_id );

ALTER TABLE lojas_produtos
    ADD CONSTRAINT fk_lop_loj FOREIGN KEY ( lop_loj_id )
        REFERENCES lojas ( loj_id );

ALTER TABLE lojas_produtos
    ADD CONSTRAINT fk_lop_pro FOREIGN KEY ( lop_pro_id )
        REFERENCES produtos ( pro_id );

ALTER TABLE tipo_produtos
    ADD CONSTRAINT fk_tip_dep FOREIGN KEY ( tip_dep_id )
        REFERENCES departamentos ( dep_id );

ALTER TABLE vendedores
    ADD CONSTRAINT fk_vdr_loj FOREIGN KEY ( vdr_loj_id )
        REFERENCES lojas ( loj_id );

ALTER TABLE vendas
    ADD CONSTRAINT fk_vnd_cli FOREIGN KEY ( vnd_cli_id )
        REFERENCES clientes ( cli_id );

ALTER TABLE vendas
    ADD CONSTRAINT fk_vnd_vdr FOREIGN KEY ( vnd_vdr_id )
        REFERENCES vendedores ( vdr_id );

ALTER TABLE vendas_produtos
    ADD CONSTRAINT fk_vnp_pro FOREIGN KEY ( vnp_pro_id )
        REFERENCES produtos ( pro_id );

ALTER TABLE vendas_produtos
    ADD CONSTRAINT fk_vnp_vnd FOREIGN KEY ( vnp_vnd_id )
        REFERENCES vendas ( vnd_id );

ALTER TABLE produtos
    ADD CONSTRAINT fk_pro_tip FOREIGN KEY ( pro_tip_id )
        REFERENCES tipo_produtos ( tip_id );


--> SEQUENCIES
------------------------

create sequence SEQ_CID nocycle nocache;

create sequence SEQ_EST nocycle nocache;

create sequence SEQ_LOJ nocycle nocache;

create sequence SEQ_PRO nocycle nocache;

create sequence SEQ_DEP nocycle nocache;

create sequence SEQ_TIP nocycle nocache;

create sequence SEQ_VDR nocycle nocache;

create sequence SEQ_VND nocycle nocache;

create sequence SEQ_CLI nocycle nocache;

create sequence SEQ_CLC nocycle nocache;


--> TRIGGERS
------------------------

CREATE TRIGGER TG_SEQ_CID BEFORE INSERT ON cidades FOR EACH ROW
begin
    :new.cid_id := SEQ_CID.nextval;
end;
/

CREATE TRIGGER TG_SEQ_EST BEFORE INSERT ON estados FOR EACH ROW
begin
    :new.est_id := SEQ_EST.nextval;
end;
/

CREATE TRIGGER TG_SEQ_LOJ BEFORE INSERT ON lojas FOR EACH ROW
begin
    :new.loj_id := SEQ_LOJ.nextval;
end;
/

CREATE TRIGGER TG_SEQ_PRO BEFORE INSERT ON produtos FOR EACH ROW
begin
    :new.pro_id := SEQ_PRO.nextval;
end;
/

CREATE TRIGGER TG_SEQ_DEP BEFORE INSERT ON departamentos FOR EACH ROW
begin
    :new.dep_id := SEQ_DEP.nextval;
end;
/

CREATE TRIGGER TG_SEQ_TIP BEFORE INSERT ON tipo_produtos FOR EACH ROW
begin
    :new.tip_id := SEQ_TIP.nextval;
end;
/

CREATE TRIGGER TG_SEQ_VDR BEFORE INSERT ON vendedores FOR EACH ROW
begin
    :new.vdr_id := SEQ_VDR.nextval;
end;
/

CREATE TRIGGER TG_SEQ_VND BEFORE INSERT ON vendas FOR EACH ROW
begin
    :new.vnd_id := SEQ_VND.nextval;
end;
/

CREATE TRIGGER TG_SEQ_CLI BEFORE INSERT ON clientes FOR EACH ROW
begin
    :new.cli_id := SEQ_CLI.nextval;
end;
/

CREATE TRIGGER TG_SEQ_CLC BEFORE INSERT ON cliente_contatos FOR EACH ROW
begin
    :new.clc_id := SEQ_CLC.nextval;
end;
/


--> INSERTS
------------------------

-- ESTADOS

INSERT INTO estados (est_sigla, est_regiao)
VALUES('SP','Sudeste');

INSERT INTO estados (est_sigla, est_regiao)
VALUES('MG','Sudeste');

-- CIDADES

INSERT INTO cidades (cid_nome, cid_est_id)
VALUES ('São Paulo',1);

INSERT INTO cidades (cid_nome, cid_est_id)
VALUES ('São José dos Campos',1);

INSERT INTO cidades (cid_nome, cid_est_id)
VALUES ('Uberlândia',2);

-- LOJAS

INSERT INTO lojas (loj_nome, loj_endereco, loj_telefone, loj_email, loj_cid_id)
VALUES ('XPTO-SP','Rua Jose Olmar, 322','(11)5687-0908','xptosp_oficial@xpto.com',1);

INSERT INTO lojas (loj_nome, loj_endereco, loj_telefone, loj_email, loj_cid_id)
VALUES ('XPTO-SC','Av. Rodolfo Guimarães, 34','(12)5645-9921','xptosc_oficial@xpto.com',2);

INSERT INTO lojas (loj_nome, loj_endereco, loj_telefone, loj_email, loj_cid_id)
VALUES ('XPTO-MG','Rua 18 de Abril, 105','(34)1254-0227','xptomg_oficial@xpto.com',3);

-- DEPARTAMENTOS

INSERT INTO departamentos (dep_nome, dep_descricao)
VALUES ('Vestuário','Roupas esportivas');

INSERT INTO departamentos (dep_nome, dep_descricao)
VALUES ('Acessórios','Acessórios esportivos');

INSERT INTO departamentos (dep_nome, dep_descricao)
VALUES ('Equipamentos','Equipamentos esportivos');

INSERT INTO departamentos (dep_nome, dep_descricao)
VALUES ('Alimentos','Alimentos como energeticos e proteínas');

INSERT INTO departamentos (dep_nome, dep_descricao)
VALUES ('Calçados','Calçados esportivos');

-- TIPO_PRODUTOS

INSERT INTO tipo_produtos (tip_descricao,tip_dep_id)
VALUES ('Regata de corrida feminina',1);

INSERT INTO tipo_produtos (tip_descricao,tip_dep_id)
VALUES ('Tênis de corrida',5);

INSERT INTO tipo_produtos (tip_descricao,tip_dep_id)
VALUES ('Joelheras',2);

INSERT INTO tipo_produtos (tip_descricao,tip_dep_id)
VALUES ('Blusa de ginástica masculina',1);

INSERT INTO tipo_produtos (tip_descricao,tip_dep_id)
VALUES ('Proteína X0',4);

INSERT INTO tipo_produtos (tip_descricao,tip_dep_id)
VALUES ('Arco e flechas',3);

-- PRODUTOS

INSERT INTO produtos (pro_nome, pro_preco_tabela, pro_tip_id)
VALUES ('Regata rosa feminina',22.90,1);

INSERT INTO produtos (pro_nome, pro_preco_tabela, pro_tip_id)
VALUES ('Tênis de corrida',45.50,2);

INSERT INTO produtos (pro_nome, pro_preco_tabela, pro_tip_id)
VALUES ('Joelheras',14.75,3);

INSERT INTO produtos (pro_nome, pro_preco_tabela, pro_tip_id)
VALUES ('Blusa de ginástica masculina',38.90,4);

INSERT INTO produtos (pro_nome, pro_preco_tabela, pro_tip_id)
VALUES ('Proteína X0',68.90,5);

INSERT INTO produtos (pro_nome, pro_preco_tabela, pro_tip_id)
VALUES ('Arco e flechas',348.90,6);

-- VENDEDORES

INSERT INTO vendedores (vdr_nome, vdr_salario, vdr_loj_id)
VALUES ('Ricardo Ramos',1450.0,1);

INSERT INTO vendedores (vdr_nome, vdr_salario, vdr_loj_id)
VALUES ('Hinata Shoyo',1450.0,1);

INSERT INTO vendedores (vdr_nome, vdr_salario, vdr_loj_id)
VALUES ('Ellena Souza',1550.0,2);

INSERT INTO vendedores (vdr_nome, vdr_salario, vdr_loj_id)
VALUES ('Bianca Gomes',1250.0,2);

INSERT INTO vendedores (vdr_nome, vdr_salario, vdr_loj_id)
VALUES ('Edmundo Willtons',1550.0,3);

INSERT INTO vendedores (vdr_nome, vdr_salario, vdr_loj_id)
VALUES ('Sara Ferreira',1550.0,3);

INSERT INTO vendedores (vdr_nome, vdr_salario, vdr_loj_id)
VALUES ('Guilherme da Silva',1250.0,2);

INSERT INTO vendedores (vdr_nome, vdr_salario, vdr_loj_id)
VALUES ('Iago Rodrigues',1450.0,2);

INSERT INTO vendedores (vdr_nome, vdr_salario, vdr_loj_id)
VALUES ('Richard Pereira',1450.0,1);

-- LOJAS_PRODUTOS

INSERT INTO lojas_produtos VALUES (1,5);

INSERT INTO lojas_produtos VALUES (1,2);

INSERT INTO lojas_produtos VALUES (2,3);

INSERT INTO lojas_produtos VALUES (3,6);

INSERT INTO lojas_produtos VALUES (2,1);

INSERT INTO lojas_produtos VALUES (2,4);

INSERT INTO lojas_produtos VALUES (3,2);

INSERT INTO lojas_produtos VALUES (3,1);

INSERT INTO lojas_produtos VALUES (1,4);

INSERT INTO lojas_produtos VALUES (1,6);

-- CLIENTES

INSERT INTO clientes(cli_nome,cli_cpf,cli_genero)
VALUES ('Felipe Neto','42.055.515-94','Masculino');

INSERT INTO clientes(cli_nome,cli_cpf,cli_genero)
VALUES ('Gilberto Oliveira','35.765.433-87','Masculino');

INSERT INTO clientes(cli_nome,cli_cpf,cli_genero)
VALUES ('Jessica Belo','33.097.455-65','Feminino');

INSERT INTO clientes(cli_nome,cli_cpf,cli_genero)
VALUES ('Danilo Matos','24.457.775-45','Masculino');

INSERT INTO clientes(cli_nome,cli_cpf,cli_genero)
VALUES ('Marcely Pereira','94.137.005-45','Indefinido');

-- CLIENTE_CONTATOS

INSERT INTO cliente_contatos(clc_telefone,clc_email,clc_cli_id)
VALUES ('(11)98878-3476','felipe.neto@gmail.com',1);

INSERT INTO cliente_contatos(clc_telefone,clc_email,clc_cli_id)
VALUES ('(12)93478-7776','gil.oliva27@gmail.com',2);

INSERT INTO cliente_contatos(clc_telefone,clc_email,clc_cli_id)
VALUES ('(11)90878-9876','jes.belo@gmail.com',3);

INSERT INTO cliente_contatos(clc_telefone,clc_email,clc_cli_id)
VALUES ('(34)9235-7890','matos88danilo@gmail.com',4);

INSERT INTO cliente_contatos(clc_telefone,clc_email,clc_cli_id)
VALUES ('(11)9895-7019','marlype@outloook.com',5);

-- VENDAS

INSERT INTO vendas (vnd_data,vnd_valor_total,vnd_vdr_id,vnd_cli_id)
VALUES ('02-08-2019',22.90,1,1);

INSERT INTO vendas (vnd_data,vnd_valor_total,vnd_vdr_id,vnd_cli_id)
VALUES ('09-03-2019',137.80,2,2);

INSERT INTO vendas (vnd_data,vnd_valor_total,vnd_vdr_id,vnd_cli_id)
VALUES ('22-12-2019',194.50,5,3);

INSERT INTO vendas (vnd_data,vnd_valor_total,vnd_vdr_id,vnd_cli_id)
VALUES ('12-06-2019',348.90,3,4);

INSERT INTO vendas (vnd_data,vnd_valor_total,vnd_vdr_id,vnd_cli_id)
VALUES ('18-08-2019',45.50,1,3);

-- VENDAS_PRODUTOS

INSERT INTO vendas_produtos (vnp_quantidade, vnp_preco_venda, vnp_pro_id, vnp_vnd_id)
VALUES (1,22.90,1,1);

INSERT INTO vendas_produtos (vnp_quantidade, vnp_preco_venda, vnp_pro_id, vnp_vnd_id)
VALUES (2,137.80,2,2);

INSERT INTO vendas_produtos (vnp_quantidade, vnp_preco_venda, vnp_pro_id, vnp_vnd_id)
VALUES (5,194.50,4,3);

INSERT INTO vendas_produtos (vnp_quantidade, vnp_preco_venda, vnp_pro_id, vnp_vnd_id)
VALUES (1,348.90,4,4);

INSERT INTO vendas_produtos (vnp_quantidade, vnp_preco_venda, vnp_pro_id, vnp_vnd_id)
VALUES (1,45.50,5,5);


commit;


=======================================
 MODELO MULTIDIMENCIONAL - STAR SCHEMA
=======================================

--> TABLES
------------------------

CREATE TABLE dim_cliente (
    cli_cod       NUMBER(6) NOT NULL,
    cli_nome      VARCHAR2(50 CHAR) NOT NULL,
    cli_cpf       VARCHAR2(14 CHAR) NOT NULL,
    cli_genero    VARCHAR2(15 CHAR) NOT NULL,
    cli_telefone  VARCHAR2(14 CHAR) NOT NULL,
    cli_email     VARCHAR2(30 CHAR)
);

CREATE TABLE dim_loja (
    loja_cod       NUMBER(6) NOT NULL,
    loja_nome      VARCHAR2(50 CHAR) NOT NULL,
    loja_endereco  VARCHAR2(255 CHAR) NOT NULL,
    loja_telefone  VARCHAR2(14 CHAR) NOT NULL,
    loja_email     VARCHAR2(30 CHAR) NOT NULL,
    loja_cidade    VARCHAR2(50 CHAR) NOT NULL,
    loja_estado    CHAR(2 CHAR) NOT NULL
);

CREATE TABLE dim_tempo (
    tmp_dia       VARCHAR2(10 CHAR) NOT NULL,
    tmp_mes       VARCHAR2(15 CHAR) NOT NULL,
    tmp_bimestre  CHAR(6 CHAR) NOT NULL,
    tmp_semestre  CHAR(6 CHAR) NOT NULL,
    tmp_ano       VARCHAR2(4 CHAR) NOT NULL
);

CREATE TABLE dim_produto (
    pro_cod             NUMBER(6) NOT NULL,
    pro_nome            VARCHAR2(50 CHAR) NOT NULL,
    pro_preco_tabela    NUMBER(8, 2) NOT NULL,
    pro_tipo            VARCHAR2(255 CHAR) NOT NULL,
    pro_dept_nome       VARCHAR2(20 CHAR) NOT NULL
);

CREATE TABLE dim_vendedor (
    vdr_cod      NUMBER(6) NOT NULL,
    vdr_nome     VARCHAR2(50 CHAR) NOT NULL,
    vdr_salario  NUMBER(8, 2) NOT NULL
);

CREATE TABLE fato_venda (
    vnd_quant        NUMBER(6) NOT NULL,
    vnd_preco        NUMBER(8, 2) NOT NULL,
    vnd_valor_total  NUMBER(8, 2) NOT NULL,
    vnd_pro_cod      NUMBER(6) NOT NULL,
    vnd_tmp_dia      VARCHAR2(10 CHAR) NOT NULL,
    vnd_cli_cod      NUMBER(6) NOT NULL,
    vnd_vdr_cod      NUMBER(6) NOT NULL,
    vnd_loja_cod     NUMBER(6) NOT NULL
);


--> CONSTRAINTS PK
------------------------

ALTER TABLE dim_cliente ADD CONSTRAINT pk_dim_cliente PRIMARY KEY ( cli_cod );

ALTER TABLE dim_loja ADD CONSTRAINT pk_dim_loja PRIMARY KEY ( loja_cod );

ALTER TABLE dim_produto ADD CONSTRAINT pk_dim_produto PRIMARY KEY ( pro_cod );

ALTER TABLE dim_tempo ADD CONSTRAINT pk_dim_tempo PRIMARY KEY ( tmp_dia );

ALTER TABLE dim_vendedor ADD CONSTRAINT pk_dim_vendedor PRIMARY KEY ( vdr_cod );

ALTER TABLE fato_venda
    ADD CONSTRAINT pk_fato_venda PRIMARY KEY ( vnd_pro_cod,
                                               vnd_tmp_dia,
                                               vnd_cli_cod,
                                               vnd_vdr_cod,
                                               vnd_loja_cod );

--> CONSTRAINTS FK
------------------------

ALTER TABLE fato_venda
    ADD CONSTRAINT fk_vnd_dim_cliente FOREIGN KEY ( vnd_cli_cod )
        REFERENCES dim_cliente ( cli_cod );

ALTER TABLE fato_venda
    ADD CONSTRAINT fk_vnd_dim_loja FOREIGN KEY ( vnd_loja_cod )
        REFERENCES dim_loja ( loja_cod );

ALTER TABLE fato_venda
    ADD CONSTRAINT fk_vnd_dim_produto FOREIGN KEY ( vnd_pro_cod )
        REFERENCES dim_produto ( pro_cod );

ALTER TABLE fato_venda
    ADD CONSTRAINT fk_vnd_dim_tempo FOREIGN KEY ( vnd_tmp_dia )
        REFERENCES dim_tempo ( tmp_dia );

ALTER TABLE fato_venda
    ADD CONSTRAINT fk_vnd_dim_vendedor FOREIGN KEY ( vnd_vdr_cod )
        REFERENCES dim_vendedor ( vdr_cod );
               

--> INSERTS
------------------------

-- DIM_CLIENTE

INSERT INTO dim_cliente (cli_cod, cli_nome, cli_cpf, cli_genero, cli_telefone, cli_email)
 (select a.cli_id, a.cli_nome, a.cli_cpf, a.cli_genero, b.clc_telefone, b.clc_email
    from clientes a
    inner join cliente_contatos b on a.cli_id = b.clc_id);

-- DIM_LOJA

INSERT INTO dim_loja (loja_cod, loja_nome, loja_endereco, loja_telefone, loja_email, loja_cidade, loja_estado)
 (select a.loj_id, a.loj_nome, a.loj_endereco, a.loj_telefone, a.loj_email, b.cid_nome, c.est_sigla
 from lojas a
 inner join cidades b on a.loj_cid_id = cid_id
 inner join estados c on b.cid_est_id = est_id);

-- DIM_TEMPO

INSERT INTO dim_tempo VALUES ('02-08-2019','2019-AUG','2019-3','2019-2','2019'); 

INSERT INTO dim_tempo VALUES ('09-03-2019','2019-MAR','2019-1','2019-1','2019');

INSERT INTO dim_tempo VALUES ('22-12-2019','2019-DEC','2019-4','2019-2','2019');

INSERT INTO dim_tempo VALUES ('12-06-2019','2019-JUN','2019-3','2019-1','2019');

INSERT INTO dim_tempo VALUES ('18-08-2019','2019-AUG','2019-4','2019-2','2019');


-- DIM_PRODUTO

INSERT INTO dim_produto (pro_cod, pro_nome, pro_preco_tabela, pro_tipo, pro_dept_nome)
 (select a.pro_id, a.pro_nome, a.pro_preco_tabela, b.tip_descricao, c.dep_nome
 from produtos a
 inner join tipo_produtos b on pro_tip_id = tip_id
 inner join departamentos c on tip_dep_id = dep_id);
 
-- DIM_VENDEDOR

INSERT INTO dim_vendedor (vdr_cod, vdr_nome, vdr_salario)
 (select a.vdr_id, a.vdr_nome, a.vdr_salario
 from vendedores a);
 
-- FATO_VENDA

INSERT INTO fato_venda(vnd_quant, vnd_preco, vnd_valor_total, vnd_pro_cod, vnd_tmp_dia, 
 vnd_cli_cod, vnd_vdr_cod, vnd_loja_cod)
 (select a.vnp_quantidade, a.vnp_preco_venda, b.vnd_valor_total,
 a.vnp_pro_id, w.tmp_dia, b.vnd_cli_id, b.vnd_vdr_id, c.vdr_loj_id
 from vendas_produtos a
 inner join vendas b on a.vnp_vnd_id = b.vnd_id
 inner join dim_tempo w on b.vnd_data = w.tmp_dia
 inner join vendedores c on b.vnd_vdr_id = c.vdr_id
 inner join lojas d on c.vdr_loj_id = d.loj_id);

 commit;