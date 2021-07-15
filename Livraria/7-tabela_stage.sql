STAGE_VENDAS
=====================================

CREATE TABLE STAGE_VENDAS(
    stg_id_ven NUMBER(6), 
    stg_id_liv NUMBER(6),
    stg_data VARCHAR2(11), 
    stg_nome_liv VARCHAR2(100), 
    stg_nome_aut VARCHAR2(50),
    stg_nome_edi VARCHAR2(50),
    stg_nome_cat VARCHAR2(50), 
    stg_valor_total NUMBER(8,2),
    stg_icms_total NUMBER(8,2),
    stg_preco_unit NUMBER(8,2),
    stg_icms_unit NUMBER(8,2),
    stg_porcentagem_valor NUMBER(6,2),
    stg_quant_prod NUMBER(3),
    stg_id_fun NUMBER(6),
    stg_id_cli NUMBER(6)
);


ALTER TABLE STAGE_VENDAS 
	ADD CONSTRAINT PK_STG primary key (stg_id_ven, stg_id_liv)
	ADD CONSTRAINT CK_STG_NN_01 CHECK (stg_id_ven IS NOT NULL)
	ADD CONSTRAINT CK_STG_NN_02 CHECK (stg_id_liv IS NOT NULL)
	ADD CONSTRAINT CK_STG_NN_03 CHECK (stg_data IS NOT NULL)
	ADD CONSTRAINT CK_STG_NN_04 CHECK (stg_nome_liv IS NOT NULL)
	ADD CONSTRAINT CK_STG_NN_05 CHECK (stg_nome_aut IS NOT NULL)
	ADD CONSTRAINT CK_STG_NN_06 CHECK (stg_nome_edi IS NOT NULL)
	ADD CONSTRAINT CK_STG_NN_07 CHECK (stg_nome_cat IS NOT NULL)
	ADD CONSTRAINT CK_STG_NN_08 CHECK (stg_valor_total IS NOT NULL)
	ADD CONSTRAINT CK_STG_NN_09 CHECK (stg_icms_total IS NOT NULL)
	ADD CONSTRAINT CK_STG_NN_10 CHECK (stg_preco_unit IS NOT NULL)
	ADD CONSTRAINT CK_STG_NN_11 CHECK (stg_icms_unit IS NOT NULL)
	ADD CONSTRAINT CK_STG_NN_12 CHECK (stg_quant_prod IS NOT NULL)
	ADD CONSTRAINT CK_STG_NN_13 CHECK (stg_porcentagem_valor IS NOT NULL)
	ADD CONSTRAINT CK_STG_NN_14 CHECK (stg_id_fun IS NOT NULL)
	ADD CONSTRAINT CK_STG_NN_15 CHECK (stg_id_cli IS NOT NULL);


CREATE PROCEDURE PR_CARGA_STAGE
AS
BEGIN
    INSERT INTO STAGE_VENDAS(
        SELECT
            ven_id, liv_id, to_char(ven_data,'dd-mm-yyyy'), 
	        liv_titulo, aut_nome_primeiro||' '||aut_nome_ultimo,
	        edi_nome, cat_nome, ven_valor_total,
	        ven_icms_total, vnl_preco, vnl_icms_unit,
            TRUNC((vnl_preco * 100) / ven_valor_total,2),
            vnl_quant, ven_fun_id, ven_cli_id  
        FROM
	    vendas INNER JOIN vendas_livros ON ven_id = vnl_ven_id
	    INNER JOIN livros ON vnl_liv_id = liv_id
	    INNER JOIN editoras ON liv_edi_id = edi_id
	    INNER JOIN autores_livros ON liv_id = atl_liv_id
	    INNER JOIN autores ON atl_aut_id = aut_id
	    INNER JOIN categorias_livros ON liv_id = ctl_liv_id
	    INNER JOIN categorias ON ctl_cat_id = cat_id  
    );
END;

EXECUTE PR_CARGA_STAGE();

SELECT 
    STG_ID_VEN ID_VENDA, STG_ID_LIV ID_LIVRO, STG_DATA DATA,
    STG_NOME_LIV NOME_LIVRO, STG_NOME_AUT AUTOR, STG_NOME_EDI EDITORA,
    STG_NOME_CAT CATEGORIA, STG_QUANT_PROD QUANTIDADE, replace(STG_PRECO_UNIT,',','.')PRECO_UNIT, 
    replace(STG_VALOR_TOTAL,',','.') VALOR_TOTAL, lpad(replace(STG_ICMS_UNIT,',','.'),4,0) ICMS_UNIT, 
    lpad(replace(STG_ICMS_TOTAL,',','.'),4,0) ICMS_TOTAL,  
    replace(STG_PORCENTAGEM_VALOR,',','.') || '%' PORCENTAGEM_VALOR , STG_ID_FUN ID_FUNCIONARIO, 
    STG_ID_CLI ID_CLIENTE
FROM 
    STAGE_VENDAS;




