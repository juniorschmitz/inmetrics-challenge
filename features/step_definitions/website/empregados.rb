E("que tenha informações para realizar um cadastro de um novo funcionário") do
  @new_employee = {
    "name": "funcionario#{Time.now.strftime('%m%d%H%M%S').to_s}",
    "cpf": "98395911009",
    "gender": ["Indiferente", "Masculino", "Feminino"].sample,
    "admission": ["10/11/1989", "10/08/2020", "20/12/1950"].sample,
    "position": ["QA Engineer", "Developer", "QA Analyst", "Product Manager"].sample,
    "salary": ["4000.00", "3999.00", "5000.00", "10000.00", "11000.00"].sample
  }
  Kernel.puts "Funcionário gerado: #{@new_employee.to_s}"
end

Quando("realizar o cadastro do funcionário") do
  @employees_list_page.access_new_employee
  @employee_registration_page.register_employee(@new_employee)
end

Então("deve apresentar uma mensagem de sucesso no cadastro") do
  alert_success = @employees_list_page.get_alert_success
  expect(alert_success).not_to be nil
  expect(alert_success.text.downcase).to include 'cadastrado com sucesso'
end

E("o novo funcionário deve ser listado na listagem de funcionários") do
  @employees_list_page.search_for_employee(@new_employee[:name])
  expect(@employees_list_page.get_employee(0).text).to have_content @new_employee[:name]
end

Dado('que tenha cadastrado um novo usuário de forma válida via API') do
  # steps %{
  #   E que tenha informações para realizar um cadastro de um novo funcionário
  #   Quando realizar o cadastro do funcionário
  #   Então deve apresentar uma mensagem de sucesso no cadastro
  # }
  steps %{
    Dado que tenha um payload válido para cadastrar um novo empregado
    Quando faço uma requisição POST para o endpoint "/empregado/cadastrar"
    Então o código de resposta deve ser 202
    E deve cadastrar o novo empregado com sucesso
  }
  @new_employee = {
    "name": @response["nome"],
    "cpf": @response["cpf"],
    "admission": @response["admissao"],
    "position": @response["cargo"],
    "salary": @response["salario"]
  }
end

Quando('acessar a tela de edição do funcionário') do
  @employees_list_page.load
  @employees_list_page.search_for_employee(@new_employee[:name])
  @employees_list_page.access_employee_edit(0)
end

Quando('editar seus dados') do
  @new_employee[:name] = 'JOHN DOE'
  @new_employee[:admission] = '10/09/2020'
  @employee_registration_page.edit_employee(@new_employee)
end

Então("deve apresentar uma mensagem de sucesso na edição") do
  alert_success = @employees_list_page.get_alert_success
  expect(alert_success).not_to be nil
  expect(alert_success.text.downcase).to include 'informações atualizadas com sucesso'
end

E("os dados editados do usuário devem ser apresentados conforme edição") do
  @employees_list_page.search_for_employee(@new_employee[:name])
  expect(@employees_list_page.get_employee(0).text).to have_content @new_employee[:name]
  expect(@employees_list_page.get_employee(0).text).to have_content @new_employee[:admission]
end

Quando("excluir o funcionário") do
  @employees_list_page.load
  @employees_list_page.search_for_employee(@new_employee[:name])
  @employees_list_page.delete_employee(0)
end

Então("deve aparecer uma mensagem de usuário excluído com sucesso") do
  alert_success = @employees_list_page.get_alert_success
  expect(alert_success).not_to be nil
  expect(alert_success.text).to include 'removido com sucesso'
end
