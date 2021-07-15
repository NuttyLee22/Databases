-- STAGE_VENDAS

comment on table stage_vendas is 'Tabela Stage com os dados das vendas realizadas';

comment on column stage_vendas.stg_id_ven is 'Coluna identificadora com o id da venda';

comment on column stage_vendas.stg_id_liv is 'Coluna identificadora com o id do livro vendido';

comment on column stage_vendas.stg_data is 'Coluna com a data da venda';

comment on column stage_vendas.stg_nome_liv is 'Coluna com o nome do livro vendido';

comment on column stage_vendas.stg_nome_aut is 'Coluna com o nome do autor do livro vendido';

comment on column stage_vendas.stg_nome_edi is 'Coluna com o nome da editora do livro vendido';

comment on column stage_vendas.stg_nome_cat is 'Coluna com o nome da categoria do livro vendido';

comment on column stage_vendas.stg_valor_total is 'Coluna com o valor total da compra';

comment on column stage_vendas.stg_icms_total is 'Coluna com o valor do ICMS total da compra';

comment on column stage_vendas.stg_preco_unit is 'Coluna com o valor unitario do livro vendido';

comment on column stage_vendas.stg_icms_unit is 'Coluna com o ICMS unitario do livro vendido';

comment on column stage_vendas.stg_porcentagem_valor is 'Coluna com a porcentagem relativa do livro vendido em relação ao valor total da compra';

comment on column stage_vendas.stg_quant_prod is 'Coluna com a quantidade de livros presentes na compra';

comment on column stage_vendas.stg_id_fun is 'Coluna com o id do funcionário que realizou a venda';

comment on column stage_vendas.stg_id_cli is 'Coluna com o id do cliente que efetuou a compra';

-- CLIENTES

comment on table clientes is 'Tabela com os dados dos clientes';

comment on column clientes.cli_id is 'Coluna identificadora da tabela clientes';

comment on column clientes.cli_nome_primeiro is 'Coluna com o primeiro nome do cliente';

comment on column clientes.cli_nome_meio is 'Coluna opcional com o nome do meio do cliente';

comment on column clientes.cli_nome_ultimo is 'Coluna com o ultimo nome do cliente';

comment on column clientes.cli_cpf is 'Coluna com o CPF dos clientes';

comment on column clientes.cli_aniversario is 'Coluna com a data de aniversário dos clientes';

-- FUNCIONARIOS

comment on table funcionarios is 'Tabela com os dados dos funcionarios';

comment on column funcionarios.fun_id is 'Coluna identificadora da tabela funcionarios';

comment on column funcionarios.fun_nome_primeiro is 'Coluna com o primeiro nome do funcionario';

comment on column funcionarios.fun_nome_meio is 'Coluna opcional com o nome do meio do funcionario';

comment on column funcionarios.fun_nome_ultimo is 'Coluna com o ultimo nome do funcionario';

comment on column funcionarios.fun_matricula is 'Coluna com o numero da matricula do funcionario';

comment on column funcionarios.fun_cargo is 'Coluna com o nome do cargo do funcionario';

-- CATEGORIAS

comment on table categorias is 'Tabela com os dados de categorias';

comment on column categorias.cat_id is 'Coluna identificadora da tabela categorias';

comment on column categorias.cat_nome is 'Coluna com o nome da categoria';

-- EDITORAS

comment on table editoras is 'Tabela com os dados das editoras';

comment on column editoras.edi_id is 'Coluna identificadora da tabela editoras';

comment on column editoras.edi_nome is 'Coluna com o nome da editora';

-- AUTORES

comment on table autores is 'Tabela com os dados de autores';

comment on column autores.aut_id is 'Coluna identificadora da tabela autores';

comment on column autores.aut_nome_primeiro is 'Coluna com o primeiro nome do autor';

comment on column autores.aut_nome_meio is 'Coluna opcional com o nome do meio do autor';

comment on column autores.aut_nome_ultimo is 'Coluna com o ultimo nome do autor';

-- LIVROS

comment on table livros is 'Tabela com os dados de livros';

comment on column livros.liv_id is 'Coluna identificadora da tabela livros';

comment on column livros.liv_titulo is 'Coluna com o nome do titulo do livro';

comment on column livros.liv_preco_unit is 'Coluna com o preco unitario do livro';

comment on column livros.liv_tip_cap is 'Coluna com tipo da capa do livro';

comment on column livros.liv_edi_id is 'Coluna com a chave estrangeira da tabela editoras';

-- VENDAS

comment on table vendas is 'Tabela com os dados das vendas';

comment on column vendas.ven_id is 'Coluna identificadora da tabela vendas';

comment on column vendas.ven_detalhe_prod is 'Coluna com os detalhes dos produtos contidos na venda';

comment on column vendas.ven_data is 'Coluna com a data em que foi realizada a venda';

comment on column vendas.ven_valor_total is 'Coluna com o valor total da venda';

comment on column vendas.ven_icms_total is 'Coluna o valor total do imposto dos produtos contidos na venda';

comment on column vendas.ven_fun_id is 'Coluna com a chave estrangeira da tabela funcionarios';

comment on column vendas.ven_cli_id is 'Coluna com a chave estrangeira da tabela clientes';

-- CATEGORIAS_LIVROS

comment on table categorias_livros is 'Tabela com as chaves estrangeiras das tabelas categorias e livros';

comment on column categorias_livros.ctl_liv_id is 'Coluna com a chave estrangeira da tabela livros';

comment on column categorias_livros.ctl_cat_id is 'Coluna com a chave estrangeira da tabela categorias';

-- AUTORES_LIVROS

comment on table autores_livros is 'Tabela com as chaves estrangeiras das tabelas autores e livros';

comment on column autores_livros.atl_liv_id is 'Coluna com a chave estrangeira da tabela livros';

comment on column autores_livros.atl_aut_id is 'Coluna com a chave estrangeira da tabela autores';

-- VENDAS_LIVROS

comment on table vendas_livros is 'Tabela com os dados da relacao entre livros e vendas';

comment on column vendas_livros.vnl_ven_id is 'Coluna com a chave estrangeira da tabela vendas';

comment on column vendas_livros.vnl_liv_id is 'Coluna com a chave estrangeira da tabela livros';

comment on column vendas_livros.vnl_quant is 'Coluna com a quantidade de produtos vendidos naquela venda';

comment on column vendas_livros.vnl_preco is 'Coluna com o preco da venda';

comment on column vendas_livros.vnl_icms_unit is 'Coluna com o valor do icms de cada produto daquela venda';
