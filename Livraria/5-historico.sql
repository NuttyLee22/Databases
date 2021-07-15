CREATE TABLE hfuncionarios (
    hfn_fun_id             NUMBER(6),
    hfn_nome_primeiro  VARCHAR2(15 CHAR),
    hfn_nome_meio      VARCHAR2(30 CHAR),
    hfn_nome_ultimo    VARCHAR2(15 CHAR),
    hfn_matricula      NUMBER(6),
    hfn_cargo          VARCHAR2(255),
    hfn_data_hora      DATE
);

comment on table hfuncionarios is 'Tabela de historico da tabela funcionarios';

comment on column hfuncionarios.hfn_id is 'Chave primaria da tabela funcionarios corrente';

comment on column hfuncionarios.hfn_nome_primeiro is 'Coluna com o primeiro nome do funcionario antes da alteração';

comment on column hfuncionarios.hfn_nome_meio is 'Coluna opcional com o nome do meio do funcionario antes da alteração';

comment on column hfuncionarios.hfn_nome_ultimo is 'Coluna com o ultimo nome do funcionario antes da alteração';

comment on column hfuncionarios.hfn_matricula is 'Coluna com o numero da matricula do funcionario antes da alteração';

comment on column hfuncionarios.hfn_cargo is 'Coluna com o nome do cargo do funcionario antes da alteração';

comment on column hfuncionarios.hfn_data_hora is 'Coluna da data e hora da alteração na tabela funcionarios';

CREATE TRIGGER TG_HFN BEFORE UPDATE OR DELETE ON FUNCIONARIOS FOR EACH ROW
BEGIN
    declare data date;
    select SYSDATE
    into data
    from dual;
	INSERT INTO HFUNCIONARIOS VALUES(:OLD.FUN_ID,:OLD.FUN_NOME_PRIMEIRO,:OLD.FUN_NOME_MEIO,:OLD.FUN_NOME_ULTIMO,:OLD.FUN_MATRICULA,:OLD.FUN_CARGO,SYSDATE);
END;
/

UPDATE funcionarios SET fun_matricula = 00002, fun_cargo = 'Gerente'
WHERE fun_id = 2;

UPDATE funcionarios SET fun_nome_ultimo = 'Moretto'
WHERE fun_id = 7;

