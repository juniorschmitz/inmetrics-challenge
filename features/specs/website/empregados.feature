# language: pt

@regressao
@crud_funcionarios
Funcionalidade: CRUD de Funcionários na aplicação Inmetrics
  Sendo um administrador do sistema
  Gostaria de poder Cadastrar, Editar e Excluir Funcionários
  Para poder manter a base de dados atualizada

@cadastrar_empregado
Cenário: Cadastrar Empregado
  Dado que realize login com usuário "usuariovalido" e senha "senhacerta"
  E que tenha informações para realizar um cadastro de um novo funcionário
  Quando realizar o cadastro do funcionário
  Então deve apresentar uma mensagem de sucesso no cadastro
  E o novo funcionário deve ser listado na listagem de funcionários

@editar_empregado
Cenário: Editar Empregado
  Dado que realize login com usuário "usuariovalido" e senha "senhacerta"
  E que tenha cadastrado um novo usuário de forma válida via API
  Quando acessar a tela de edição do funcionário
  E editar seus dados
  Então deve apresentar uma mensagem de sucesso na edição
  E os dados editados do usuário devem ser apresentados conforme edição

@excluir_empregado
Cenário: Excluir Empregado
  Dado que realize login com usuário "usuariovalido" e senha "senhacerta"
  E que tenha cadastrado um novo usuário de forma válida via API
  Quando excluir o funcionário
  Então deve aparecer uma mensagem de usuário excluído com sucesso