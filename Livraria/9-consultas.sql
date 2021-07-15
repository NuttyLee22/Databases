------------------------------ CONSULTAS ESTRATÉGICAS ----------------------------------- 

-- 1) Qual vendedor vendeu menos livros 
select
     b.fun_nome_primeiro || ' ' || b.fun_nome_ultimo Funcionário, count(a.stg_id_ven) Quantidade 
from
    stage_vendas a
inner join
    funcionarios b on a.stg_id_fun = b.fun_id
group by 
    b.fun_nome_primeiro || ' ' || b.fun_nome_ultimo 
order by 2
fetch first 1 row only;

---- 1.2) Qual vendedor vendeu mais livros 
select
     b.fun_nome_primeiro || ' ' || b.fun_nome_ultimo Funcionário, count(a.stg_id_ven) Quantidade 
from
    stage_vendas a
inner join
    funcionarios b on a.stg_id_fun = b.fun_id
group by 
    b.fun_nome_primeiro || ' ' || b.fun_nome_ultimo 
order by 2 desc
fetch first 1 row only;

-- 2) Quais os 3 livros mais vendidos  
select
    stg_nome_liv Livro, sum(stg_quant_prod) "QUANTIDADE VENDIDA"
from
    stage_vendas
group by 
    stg_nome_liv
order by 2 desc
fetch first 3 rows only;

-- 3) Quais os 3 livros menos vendidos  
select
    stg_nome_liv Livro, sum(stg_quant_prod) "QUANTIDADE VENDIDA"
from
    stage_vendas
group by 
    stg_nome_liv
order by 2 
fetch first 3 rows only;

-- 4) Dia da semana que possuí mais vendas  
select
    to_char(to_date(stg_data),'Day') "DIA DA SEMANA", count(stg_id_ven) "QUANTIDADE DE VENDAS"
from
    stage_vendas
group by 
    to_char(to_date(stg_data),'Day')
order by 2 desc
fetch first 2 row only;

------------------------------ CONSULTAS DE ANÁLISE -----------------------------------  

-- 1) Categoria vendida por faixa-etária  
select
    a.stg_nome_cat Categoria, 
    (CASE WHEN trunc((sysdate- to_date(b.cli_aniversario) )/365.25) between 15 and 20 then '15-20'
    WHEN trunc((sysdate- to_date(b.cli_aniversario) )/365.25) between 21 and 30 then '21-30' 
    WHEN trunc((sysdate- to_date(b.cli_aniversario) )/365.25) between 31 and 40 then '31-39'
    else '40+' end) as faixa, count(a.stg_id_ven) "QUANTIDADE DE LIVROS VENDIDOS"
from
    stage_vendas a
inner join
    clientes b on a.stg_id_cli = b.cli_id
group by 
    a.stg_nome_cat, (CASE WHEN trunc((sysdate- to_date(b.cli_aniversario) )/365.25) between 15 and 20 then '15-20'
    WHEN trunc((sysdate- to_date(b.cli_aniversario) )/365.25) between 21 and 30 then '21-30' 
    WHEN trunc((sysdate- to_date(b.cli_aniversario) )/365.25) between 31 and 40 then '31-39'
    else '40+' end)
order by 2;

-- 2) Quantidade de livros vendidos por mês  
select
    to_char(to_date(stg_data),'yyyy/Month') "ANO/MES", sum(stg_quant_prod) "QUANTIDADE DE LIVROS VENDIDOS"
from
    stage_vendas
group by 
    to_char(to_date(stg_data),'yyyy/Month')
order by to_date(to_char(to_date(stg_data),'yyyy/Month'),'yyyy-mm');

-- 3) Quantidade de livros vendidos por autor  
select
    stg_nome_aut Autor, sum(stg_quant_prod) "QUANTIDADE DE LIVROS VENDIDOS"
from
    stage_vendas
group by 
    stg_nome_aut
order by 2;

-- 4) Total de vendas por dia da semana
select
    to_char(to_date(stg_data),'Day') "DIA DA SEMANA", count(stg_id_ven) "QUANTIDADE DE VENDAS"
from
    stage_vendas
group by 
    to_char(to_date(stg_data),'Day')
order by 1 ;

-- Extra) Lucro total de cada mês
select
	to_char(to_date(stg_data),'yyyy/Month') "ANO/MES", replace(sum(stg_valor_total),',','.') "LUCRO TOTAL"
from
	stage_vendas
group by
	to_char(to_date(stg_data),'yyyy/Month')
order by to_date(to_char(to_date(stg_data),'yyyy/Month'),'yyyy-mm');

---Query para o gráfico----
select
    to_char(to_date(stg_data),'yyyy/Month') "ANO/MÊS", to_char(sum(stg_valor_total),'L999999.00') "LUCRO TOTAL"
from
    stage_vendas
group by 
    to_char(to_date(stg_data),'yyyy/Month')
order by 1;
