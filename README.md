## API + Web Ruby Automation
Projeto construído utilizando Ruby versão 2.5.X
#### Sobre Configuração e Execução
**Para instalar as dependências do projeto localmente, ir até a raíz do projeto (mesmo nível do Gemfile) via terminal e executar:**
```sh
$ bundle install
```
**Para executar todos testes Web via terminal, na raíz do projeto:**
```sh
$ bundle exec cucumber -p default -t@regressao
```
**Para executar todos testes de API via terminal, na raíz do projeto:**
```sh
$ bundle exec cucumber -p api -t@regressao_api
```

#### Sobre o Desenvolvimento
- Divisão de camadas (Pages/Specifications/Steps implementation/Configurations);
- Aplicado o padrão de PageObjects para a implementação dos cenários de testes Web;
- Projeto mesclado com cenários Web e API utilizando Cucumber;
- Testes de CRUD de empregados usa API para criar massa antes (Edição e Exclusão);
- Utilizada validação de JSON Schema para o contrato de criação de empregados;
- Utilizada uma classe central para chamada de requisições API para a API de empregados;
