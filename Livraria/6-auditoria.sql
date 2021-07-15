create table auditoria(
    aud_id number(6),
    aud_dt_registro date,
    aud_user varchar(30),
    aud_tp_acao varchar(6),
    aud_nm_tabela varchar(30),
    aud_id_linha varchar(30)
);

alter table auditoria add constraint aud_pk primary key (aud_id);

create sequence SEQ_AUD nocycle nocache;

create trigger TG_SEQ_AUD before insert on auditoria for each row
begin
    :new.aud_id := SEQ_AUD.nextval;
end;
/

create procedure proc_insere_audit
    (nm_usuario IN varchar, tp_acao IN varchar, nm_tabela IN varchar, id_linha IN varchar)
IS
BEGIN
    insert into auditoria values (0, sysdate, nm_usuario, tp_acao, nm_tabela, id_linha);
    
END proc_insere_audit;
/

-- CLIENTES
create trigger TG_AUD_CLI after insert or delete or update on clientes for each row
declare
    v_usuario varchar(30);
begin
    select user
    into v_usuario
    from dual;
    
    if inserting then
        proc_insere_audit(v_usuario, 'INSERT', 'CLIENTE', to_char(:new.cli_id));
    elsif updating then
	proc_insere_audit(v_usuario, 'UPDATE', 'CLIENTE', to_char(:new.cli_id));
    else 
	proc_insere_audit(v_usuario, 'DELETE', 'CLIENTE', to_char(:old.cli_id));
    end if;

end;
/

-- FUNCIONARIOS
create trigger TG_AUD_FUN after insert or delete or update on funcionarios for each row
declare
    v_usuario varchar(30);
begin
    select user
    into v_usuario
    from dual;

    if inserting then
        proc_insere_audit(v_usuario, 'INSERT', 'FUNCIONARIOS', to_char(:new.fun_id));
    elsif updating then
	proc_insere_audit(v_usuario, 'UPDATE', 'FUNCIONARIOS', to_char(:new.fun_id));
    else 
	proc_insere_audit(v_usuario, 'DELETE', 'FUNCIONARIOS', to_char(:old.fun_id));
    end if;

end;
/

-- CATEGORIAS
create trigger TG_AUD_CAT after insert or delete or update on categorias for each row
declare
    v_usuario varchar(30);
begin
    select user
    into v_usuario
    from dual;
    
    if inserting then
        proc_insere_audit(v_usuario, 'INSERT', 'CATEGORIAS', to_char(:new.cat_id));
    elsif updating then
	proc_insere_audit(v_usuario, 'UPDATE', 'CATEGORIAS', to_char(:new.cat_id));
    else 
	proc_insere_audit(v_usuario, 'DELETE', 'CATEGORIAS', to_char(:old.cat_id));
    end if;

end;
/

-- EDITORAS
create trigger TG_AUD_EDI after insert or delete or update on editoras for each row
declare
    v_usuario varchar(30);
begin
    select user
    into v_usuario
    from dual;
    
    if inserting then
        proc_insere_audit(v_usuario, 'INSERT', 'EDITORAS', to_char(:new.edi_id));
    elsif updating then
	proc_insere_audit(v_usuario, 'UPDATE', 'EDITORAS', to_char(:new.edi_id));
    else 
	proc_insere_audit(v_usuario, 'DELETE', 'EDITORAS', to_char(:old.edi_id));
    end if;

end;
/

-- AUTORES
create trigger TG_AUD_AUT after insert or delete or update on autores for each row
declare
    v_usuario varchar(30);
begin
    select user
    into v_usuario
    from dual;
    
    if inserting then
        proc_insere_audit(v_usuario, 'INSERT', 'AUTORES', to_char(:new.aut_id));
    elsif updating then
	proc_insere_audit(v_usuario, 'UPDATE', 'AUTORES', to_char(:new.aut_id));
    else 
	proc_insere_audit(v_usuario, 'DELETE', 'AUTORES', to_char(:old.aut_id));
    end if;

end;
/

-- LIVROS
create trigger TG_AUD_LIV after insert or delete or update on livros for each row
declare
    v_usuario varchar(30);
begin
    select user
    into v_usuario
    from dual;
    
    if inserting then
        proc_insere_audit(v_usuario, 'INSERT', 'LIVROS', to_char(:new.liv_id));
    elsif updating then
	proc_insere_audit(v_usuario, 'UPDATE', 'LIVROS', to_char(:new.liv_id));
    else 
	proc_insere_audit(v_usuario, 'DELETE', 'LIVROS', to_char(:old.liv_id));
    end if;

end;
/

-- VENDAS
create trigger TG_AUD_VEN after insert or delete or update on vendas for each row
declare
    v_usuario varchar(30);
begin
    select user
    into v_usuario
    from dual;
    
    if inserting then
        proc_insere_audit(v_usuario, 'INSERT', 'VENDAS', to_char(:new.ven_id));
    elsif updating then
	proc_insere_audit(v_usuario, 'UPDATE', 'VENDAS', to_char(:new.ven_id));
    else 
	proc_insere_audit(v_usuario, 'DELETE', 'VENDAS', to_char(:old.ven_id));
    end if;

end;
/

-- CATEGORIAS_LIVROS
create trigger TG_AUD_CTL after insert or delete or update on categorias_livros for each row
declare
    v_usuario varchar(30);
begin
    select user
    into v_usuario
    from dual;
    
    if inserting then
        proc_insere_audit(v_usuario, 'INSERT', 'CATEGORIAS_LIVROS', to_char(:new.ctl_cat_id) || ',' || to_char(:new.ctl_liv_id));
    elsif updating then
	proc_insere_audit(v_usuario, 'UPDATE', 'CATEGORIAS_LIVROS', to_char(:new.ctl_cat_id) || ',' || to_char(:new.ctl_liv_id));
    else 
	proc_insere_audit(v_usuario, 'DELETE', 'CATEGORIAS_LIVROS', to_char(:old.ctl_cat_id) || ',' || to_char(:old.ctl_liv_id));
    end if;

end;
/

-- AUTORES_LIVROS
create trigger TG_AUD_ATL after insert or delete or update on autores_livros for each row
declare
    v_usuario varchar(30);
begin
    select user
    into v_usuario
    from dual;
    
    if inserting then
        proc_insere_audit(v_usuario, 'INSERT', 'AUTORES_LIVROS', to_char(:new.atl_aut_id) || ',' || to_char(:new.atl_liv_id));
    elsif updating then
	proc_insere_audit(v_usuario, 'UPDATE', 'AUTORES_LIVROS', to_char(:new.atl_aut_id) || ',' || to_char(:new.atl_liv_id));
    else 
	proc_insere_audit(v_usuario, 'DELETE', 'AUTORES_LIVROS', to_char(:old.atl_aut_id) || ',' || to_char(:old.atl_liv_id));
    end if;

end;
/

-- VENDAS_LIVROS
create trigger TG_AUD_VNL after insert or delete or update on vendas_livros for each row
declare
    v_usuario varchar(30);
begin
    select user
    into v_usuario
    from dual;
    
    if inserting then
        proc_insere_audit(v_usuario, 'INSERT', 'VENDAS_LIVROS', to_char(:new.vnl_ven_id) || ',' || to_char(:new.vnl_liv_id));
    elsif updating then
	proc_insere_audit(v_usuario, 'UPDATE', 'VENDAS_LIVROS', to_char(:new.vnl_ven_id) || ',' || to_char(:new.vnl_liv_id));
    else 
	proc_insere_audit(v_usuario, 'DELETE', 'VENDAS_LIVROS', to_char(:old.vnl_ven_id) || ',' || to_char(:old.vnl_liv_id));
    end if;

end;
/

-- STAGE_VENDAS
create trigger TG_AUD_STG after insert or delete or update on stage_vendas for each row
declare
    v_usuario varchar(30);
begin
    select user
    into v_usuario
    from dual;
    
    if inserting then
        proc_insere_audit(v_usuario, 'INSERT', 'STAGE_VENDAS', to_char(:new.stg_id_ven) || ',' || to_char(:new.stg_id_liv));
    elsif updating then
	proc_insere_audit(v_usuario, 'UPDATE', 'STAGE_VENDAS', to_char(:new.stg_id_ven) || ',' || to_char(:new.stg_id_liv));
    else 
	proc_insere_audit(v_usuario, 'DELETE', 'STAGE_VENDAS', to_char(:old.stg_id_ven) || ',' || to_char(:old.stg_id_liv));
    end if;

end;
/

