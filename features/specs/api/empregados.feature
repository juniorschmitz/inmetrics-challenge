# language: pt

@regressao_api
Funcionalidade: API de Empregados Inmetrics
  Como aplicação que utiliza a base de Empregados
  Gostaria de poder adicionar, listar e alterar Empregados
  Para poder manter a base de dados atualizada

@post_criar_empregado
Cenário: Post criar novo empregado
  Dado que tenha um payload válido para cadastrar um novo empregado
  Quando faço uma requisição POST para o endpoint "/empregado/cadastrar"
  Então o código de resposta deve ser 202
  E deve cadastrar o novo empregado com sucesso

@post_criar_empregado_dados_invalidos
Esquema do Cenário: Post criar novo empregado tipos dados errados
  Dado que tenha um payload válido para cadastrar um novo empregado
  Mas alterei o campo "<campo>" para "<alteracao>"
  Quando faço uma requisição POST para o endpoint "/empregado/cadastrar"
  Então o código de resposta deve ser 400

  Exemplos:
  |       campo           |    alteracao               |
  |       admissao        |    10-10-2020              |
  |       comissao        |    -1.00                   |
  |       cpf             |     50606543031            |
  |       cpf             |     nnn                    |
  |       departamentoId  |    -1                      |
  |       salario         |   -1.00                    |
  |       sexo            |   nan                      |
  |       tipoContratacao |   gh                       |

@post_criar_empregado_dados_faltando
Esquema do Cenário: Post criar novo empregado dados faltando
  Dado que tenha um payload válido para cadastrar um novo empregado
  Mas excluí o campo "<campo>" do payload
  Quando faço uma requisição POST para o endpoint "/empregado/cadastrar"
  Então o código de resposta deve ser 400

  Exemplos:
  |         campo         |
  |       cargo           |
  |       nome            |
  |       admissao        |
  |       comissao        |
  |       cpf             |
  |       departamentoId  |
  |       salario         |
  |       sexo            |
  |       tipoContratacao |

@get_empregado
Cenário: Listar um empregado
  Dado que tenha cadastrado um novo empregado via API com sucesso
  Quando faço uma requisição GET para o endpoint "/empregado/list/{id}"
  Então o código de resposta deve ser 202
  E deve retornar os dados do empregado com sucesso

@get_empregados
Cenário: Listar todos empregados
  Dado que faça uma requisição GET para pegar todos empregados no endpoint "/empregado/list_all"
  Então o código de resposta deve ser 200
  E deve retornar uma lista de empregados

@put_atualizar_empregado
Esquema do Cenário: Put alterar dados de um empregado
  Dado que tenha cadastrado um novo empregado via API com sucesso
  E que tenha um payload com alteração no dado "<campo>" do empregado para "<alteracao>"
  Quando faço uma requisição PUT para o endpoint "/empregado/alterar/{id}"
  Então o código de resposta deve ser 202
  E deve trazer o dado do campo "<campo>" alterado com sucesso para "<alteracao>"

  Exemplos:
  |         campo         |          alteracao         |
  |       admissao        |     15/09/2020             |
  |       comissao        |     2.000,00               |
  |       cpf             |     506.065.430-31         |
  |       salario         |     20.000,00              |
  |       sexo            |     m                      |
  |       tipoContratacao |     clt                    |