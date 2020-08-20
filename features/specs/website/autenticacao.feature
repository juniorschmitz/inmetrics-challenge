# language: pt

@regressao
@autenticacao
Funcionalidade: Autenticação no Sistema Inmetrics
    Sendo um usuário do Sistema Inmetrics
    Gostaria de poder me cadastrar ou realizar login
    Para poder usufruir das funcionalidades restritas do sistema

@login_feliz
Cenário: Realizar login com um usuário existente
    Dado que realize login com usuário "usuariovalido" e senha "senhacerta"
    Então deve logar o usuário

@login_falho
Cenário: Tentar realizar login com credenciais incorretas
    Dado que realize login com usuário "usuarioinvalido123" e senha "123456"
    Então deve apresentar uma mensagem de usuário e/ou senha inválidos

@login_faltando_campos
Esquema do Cenário: Tentar realizar login com informações faltando
    Dado que realize login com usuário "<user>" e senha "<password>"
    Então deve apresentar um alerta de validação nos campos

    Exemplos:
    |        user        |        password        |
    |                    |                        |
    | usuarioinvalido123 |                        |
    |                    |  sosenha123            |

@cadastro_usuario_ok
Cenário: Cadastrar usuário
    Dado que tenha informações para criar um novo usuário
    Quando realizar o cadastro do usuário
    Então deve ser possível logar com o usuário criado

@cadastro_usuario_senha_confirmacao_diferentes
Cenário: Tentar realizar cadastro com senha e confirmação de senha diferentes
    Dado que tenha informações para criar um novo usuário
    Mas tenha errado a confirmação de senha
    Quando realizar o cadastro do usuário
    Então deve apresentar uma mensagem de senhas diferentes
