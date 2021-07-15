CREATE TABLE clientes (
    cli_id             NUMBER(6),
    cli_nome_primeiro  VARCHAR2(15 CHAR),
    cli_nome_meio      VARCHAR2(30 CHAR),
    cli_nome_ultimo    VARCHAR2(15 CHAR),
    cli_cpf            VARCHAR2(15 CHAR),
    cli_aniversario    VARCHAR2(11 CHAR)
);

CREATE TABLE funcionarios (
    fun_id             NUMBER(6),
    fun_nome_primeiro  VARCHAR2(15 CHAR),
    fun_nome_meio      VARCHAR2(30 CHAR),
    fun_nome_ultimo    VARCHAR2(15 CHAR),
    fun_matricula      NUMBER(6),
    fun_cargo          VARCHAR2(255)
);

CREATE TABLE categorias (
    cat_id    NUMBER(6),
    cat_nome  VARCHAR2(255 CHAR)
);

CREATE TABLE editoras (
    edi_id    NUMBER(6),
    edi_nome  VARCHAR2(255 CHAR)
);

CREATE TABLE autores (
    aut_id             NUMBER(6),
    aut_nome_primeiro  VARCHAR2(15 CHAR),
    aut_nome_meio      VARCHAR2(30 CHAR),
    aut_nome_ultimo    VARCHAR2(15 CHAR)
);

CREATE TABLE livros (
    liv_id          NUMBER(6),
    liv_titulo      VARCHAR2(255 CHAR),
    liv_preco_unit  NUMBER(8, 2),
    liv_tip_cap     VARCHAR2(255 CHAR),
    liv_edi_id      NUMBER(6)
);

CREATE TABLE vendas (
    ven_id            NUMBER(6),
    ven_detalhe_prod  VARCHAR2(255 CHAR),
    ven_data          VARCHAR2(11 CHAR),
    ven_valor_total   NUMBER(8, 2),
    ven_icms_total    NUMBER(8, 2),
    ven_fun_id        NUMBER(6),
    ven_cli_id        NUMBER(6)
);

CREATE TABLE categorias_livros (
    ctl_liv_id  NUMBER(6),
    ctl_cat_id  NUMBER(6)
);

CREATE TABLE autores_livros (
    atl_liv_id  NUMBER(6),
    atl_aut_id  NUMBER(6)
);

CREATE TABLE vendas_livros (
    vnl_ven_id     NUMBER(6),
    vnl_liv_id     NUMBER(6),
    vnl_quant      NUMBER(6),
    vnl_preco      NUMBER(8, 2),
    vnl_icms_unit  NUMBER(8, 2)
);

-- PRIMARY KEY

ALTER TABLE autores ADD CONSTRAINT pk_aut PRIMARY KEY ( aut_id );

ALTER TABLE autores_livros ADD CONSTRAINT pk_atl PRIMARY KEY ( atl_liv_id,
                                                               atl_aut_id );

ALTER TABLE categorias ADD CONSTRAINT pk_cat PRIMARY KEY ( cat_id );

ALTER TABLE categorias_livros ADD CONSTRAINT pk_ctl PRIMARY KEY ( ctl_liv_id,
                                                                  ctl_cat_id );

ALTER TABLE clientes ADD CONSTRAINT pk_cli PRIMARY KEY ( cli_id );

ALTER TABLE editoras ADD CONSTRAINT pk_edi PRIMARY KEY ( edi_id );

ALTER TABLE funcionarios ADD CONSTRAINT pk_fun PRIMARY KEY ( fun_id );

ALTER TABLE livros ADD CONSTRAINT pk_liv PRIMARY KEY ( liv_id );

ALTER TABLE vendas ADD CONSTRAINT pk_ven PRIMARY KEY ( ven_id );

ALTER TABLE vendas_livros ADD CONSTRAINT pk_vnl PRIMARY KEY ( vnl_ven_id,
                                                              vnl_liv_id );

-- FOREIGN KEY

ALTER TABLE autores_livros
    ADD CONSTRAINT fk_atl_aut FOREIGN KEY ( atl_aut_id )
        REFERENCES autores ( aut_id );

ALTER TABLE autores_livros
    ADD CONSTRAINT fk_atl_liv FOREIGN KEY ( atl_liv_id )
        REFERENCES livros ( liv_id );

ALTER TABLE categorias_livros
    ADD CONSTRAINT fk_ctl_cat FOREIGN KEY ( ctl_cat_id )
        REFERENCES categorias ( cat_id );

ALTER TABLE categorias_livros
    ADD CONSTRAINT fk_ctl_liv FOREIGN KEY ( ctl_liv_id )
        REFERENCES livros ( liv_id );

ALTER TABLE livros
    ADD CONSTRAINT fk_liv_edi FOREIGN KEY ( liv_edi_id )
        REFERENCES editoras ( edi_id );

ALTER TABLE vendas
    ADD CONSTRAINT fk_ven_cli FOREIGN KEY ( ven_cli_id )
        REFERENCES clientes ( cli_id );

ALTER TABLE vendas
    ADD CONSTRAINT fk_ven_fun FOREIGN KEY ( ven_fun_id )
        REFERENCES funcionarios ( fun_id );

ALTER TABLE vendas_livros
    ADD CONSTRAINT fk_vnl_liv FOREIGN KEY ( vnl_liv_id )
        REFERENCES livros ( liv_id );

ALTER TABLE vendas_livros
    ADD CONSTRAINT fk_vnl_ven FOREIGN KEY ( vnl_ven_id )
        REFERENCES vendas ( ven_id );

-- CHECKS

ALTER TABLE clientes 
	ADD CONSTRAINT CK_CLI_NN_01 CHECK (cli_id IS NOT NULL)
	ADD CONSTRAINT CK_CLI_NN_02 CHECK (cli_nome_primeiro IS NOT NULL)
	ADD CONSTRAINT CK_CLI_NN_03 CHECK (cli_nome_ultimo IS NOT NULL)
	ADD CONSTRAINT CK_CLI_NN_04 CHECK (cli_cpf IS NOT NULL)
	ADD CONSTRAINT CK_CLI_NN_05 CHECK (cli_aniversario IS NOT NULL);
	
ALTER TABLE funcionarios 
	ADD CONSTRAINT CK_FUN_NN_01 CHECK (fun_id IS NOT NULL)
	ADD CONSTRAINT CK_FUN_NN_02 CHECK (fun_nome_primeiro IS NOT NULL)
	ADD CONSTRAINT CK_FUN_NN_03 CHECK (fun_nome_ultimo IS NOT NULL)
	ADD CONSTRAINT CK_FUN_NN_04 CHECK (fun_matricula IS NOT NULL)
	ADD CONSTRAINT CK_FUN_NN_05 CHECK (fun_cargo IS NOT NULL);

ALTER TABLE categorias 
	ADD CONSTRAINT CK_CAT_NN_01 CHECK (cat_id IS NOT NULL)
	ADD CONSTRAINT CK_CAT_NN_02 CHECK (cat_nome IS NOT NULL);

ALTER TABLE editoras 
	ADD CONSTRAINT CK_EDI_NN_01 CHECK (edi_id IS NOT NULL)
	ADD CONSTRAINT CK_EDI_NN_02 CHECK (edi_nome IS NOT NULL);

ALTER TABLE autores 
	ADD CONSTRAINT CK_AUT_NN_01 CHECK (aut_id IS NOT NULL)
	ADD CONSTRAINT CK_AUT_NN_02 CHECK (aut_nome_primeiro IS NOT NULL)
	ADD CONSTRAINT CK_AUT_NN_03 CHECK (aut_nome_ultimo IS NOT NULL);

ALTER TABLE livros 
	ADD CONSTRAINT CK_LIV_NN_01 CHECK (liv_id IS NOT NULL)
	ADD CONSTRAINT CK_LIV_NN_02 CHECK (liv_titulo IS NOT NULL)
	ADD CONSTRAINT CK_LIV_NN_03 CHECK (liv_preco_unit IS NOT NULL)
	ADD CONSTRAINT CK_LIV_NN_04 CHECK (liv_tip_cap IS NOT NULL)
	ADD CONSTRAINT CK_LIV_NN_05 CHECK (liv_edi_id IS NOT NULL); 

ALTER TABLE vendas 
	ADD CONSTRAINT CK_VEN_NN_01 CHECK (ven_id IS NOT NULL)
	ADD CONSTRAINT CK_VEN_NN_02 CHECK (ven_detalhe_prod IS NOT NULL)
	ADD CONSTRAINT CK_VEN_NN_03 CHECK (ven_data IS NOT NULL)
	ADD CONSTRAINT CK_VEN_NN_04 CHECK (ven_valor_total IS NOT NULL)
	ADD CONSTRAINT CK_VEN_NN_05 CHECK (ven_icms_total IS NOT NULL)
	ADD CONSTRAINT CK_VEN_NN_06 CHECK (ven_fun_id IS NOT NULL)
	ADD CONSTRAINT CK_VEN_NN_07 CHECK (ven_cli_id IS NOT NULL);

ALTER TABLE categorias_livros
	ADD CONSTRAINT CK_CTL_NN_01 CHECK (ctl_liv_id IS NOT NULL)
	ADD CONSTRAINT CK_CTL_NN_02 CHECK (ctl_cat_id IS NOT NULL);

ALTER TABLE autores_livros
	ADD CONSTRAINT CK_ATL_NN_01 CHECK (atl_liv_id IS NOT NULL)
	ADD CONSTRAINT CK_ATL_NN_02 CHECK (atl_aut_id IS NOT NULL);

ALTER TABLE vendas_livros
	ADD CONSTRAINT CK_VNL_NN_01 CHECK (vnl_ven_id IS NOT NULL)
	ADD CONSTRAINT CK_VNL_NN_02 CHECK (vnl_liv_id IS NOT NULL)
	ADD CONSTRAINT CK_VNL_NN_03 CHECK (vnl_quant IS NOT NULL)
	ADD CONSTRAINT CK_VNL_NN_04 CHECK (vnl_preco IS NOT NULL)
	ADD CONSTRAINT CK_VNL_NN_05 CHECK (vnl_icms_unit IS NOT NULL);

-- SEQUENCY

create sequence SEQ_CLI nocycle nocache;

create sequence SEQ_FUN nocycle nocache;

create sequence SEQ_CAT nocycle nocache;

create sequence SEQ_EDI nocycle nocache;

create sequence SEQ_AUT nocycle nocache;

create sequence SEQ_LIV nocycle nocache;

create sequence SEQ_VEN nocycle nocache;

create sequence SEQ_VNL nocycle nocache;


-- TRIGGERS

CREATE TRIGGER TG_SEQ_CLI BEFORE INSERT ON clientes FOR EACH ROW
begin
    :new.cli_id := SEQ_CLI.nextval;
end;
/

CREATE TRIGGER TG_SEQ_FUN BEFORE INSERT ON funcionarios FOR EACH ROW
begin
    :new.fun_id := SEQ_FUN.nextval;
end;
/

CREATE TRIGGER TG_SEQ_CAT BEFORE INSERT ON categorias FOR EACH ROW
begin
    :new.cat_id := SEQ_CAT.nextval;
end;
/

CREATE TRIGGER TG_SEQ_EDI BEFORE INSERT ON editoras FOR EACH ROW
begin
    :new.edi_id := SEQ_EDI.nextval;
end;
/

CREATE TRIGGER TG_SEQ_AUT BEFORE INSERT ON autores FOR EACH ROW
begin
    :new.aut_id := SEQ_AUT.nextval;
end;
/

CREATE TRIGGER TG_SEQ_LIV BEFORE INSERT ON livros FOR EACH ROW
begin
    :new.liv_id := SEQ_LIV.nextval;
end;
/

CREATE TRIGGER TG_SEQ_VEN BEFORE INSERT ON vendas FOR EACH ROW
begin
    :new.ven_id := SEQ_VEN.nextval;
end;
/

CREATE TRIGGER TG_SEQ_VNL BEFORE INSERT ON vendas_livros FOR EACH ROW
begin
    :new.vnl_ven_id := SEQ_VNL.nextval;
end;
/

