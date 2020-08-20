Dado("que tenha um payload válido para cadastrar um novo empregado") do
  @payload = JSON.parse(File.read(%-#{Dir.pwd}/features/support/api_helper/payloads/post_create_employee.json-))
  @payload["admissao"] = ["10/11/1989", "10/08/2020", "20/12/1950"].sample
  @payload["cargo"] = ["QA Engineer", "Developer", "QA Analyst", "Product Manager"].sample
  @payload["comissao"] = ["300,00", "400,00", "500,00", "600,00"].sample
  @payload["cpf"] = "983.959.110-09"
  @payload["departamentoId"] = 1
  @payload["nome"] = "funcionario#{Time.now.strftime('%m%d%H%M%S').to_s}"
  @payload["salario"] = ["4.000,00", "3.999,00", "5.000,00", "10.000,00", "11.000,00", "12.000,00", "15.000,00"].sample
  @payload["sexo"] = ["i", "m", "f"].sample
  @payload["tipoContratacao"] = ["clt", "pj"].sample
end
  
Quando("faço uma requisição POST para o endpoint {string}") do |endpoint|
  @response = EmployeeApi.post_create(endpoint, @payload)
  Kernel.puts "Retorno da chamada: #{@response.to_s.force_encoding('UTF-8')}"
end

Então("o código de resposta deve ser {int}") do |response_code|
  expect(@response.code).to eq response_code
end
  
E("deve cadastrar o novo empregado com sucesso") do
  schema = JSON.parse(File.read(%-#{Dir.pwd}/features/support/api_helper/schemas/post_employee_schema.json-))
  expect(JSON::Validator.validate!(schema, @response.body)).to be true
end

Mas("alterei o campo {string} para {string}") do |field, data_change|
  @payload[field] = data_change
end

Mas("excluí o campo {string} do payload") do |field|
  @payload.delete field
end

Dado("que tenha cadastrado um novo empregado via API com sucesso") do
  steps %{
    Dado que tenha um payload válido para cadastrar um novo empregado
    Quando faço uma requisição POST para o endpoint "/empregado/cadastrar"
    Então o código de resposta deve ser 202
    E deve cadastrar o novo empregado com sucesso
  }
  @created_employee_id = @response["empregadoId"]
end

Quando("faço uma requisição GET para o endpoint {string}") do |endpoint|
  endpoint = endpoint.gsub('{id}', @created_employee_id.to_s)
  @response = EmployeeApi.retrieve(endpoint)
  Kernel.puts "Retorno da chamada: #{@response.to_s.force_encoding('UTF-8')}"
end

E("deve retornar os dados do empregado com sucesso") do
  expect(@response["empregadoId"]).not_to be nil
  expect(@response["sexo"]).not_to be nil
  expect(@response["cpf"]).not_to be nil
  expect(@response["admissao"]).not_to be nil
  expect(@response["salario"]).not_to be nil
  expect(@response["comissao"]).not_to be nil
  expect(@response["tipoContratacao"]).not_to be nil
end

Dado("que faça uma requisição GET para pegar todos empregados no endpoint {string}") do |endpoint|
  @response = EmployeeApi.retrieve(endpoint)
  Kernel.puts "Retorno da chamada: #{@response.to_s.force_encoding('UTF-8')}"
end

Então("deve retornar uma lista de empregados") do
  expect(@response.size).to be > 0
  expect(@response.last["empregadoId"]).not_to be nil
  expect(@response.last["sexo"]).not_to be nil
  expect(@response.last["cpf"]).not_to be nil
  expect(@response.last["admissao"]).not_to be nil
  expect(@response.last["salario"]).not_to be nil
  expect(@response.last["comissao"]).not_to be nil
  expect(@response.last["tipoContratacao"]).not_to be nil
end

E("que tenha um payload com alteração no dado {string} do empregado para {string}") do |field, data_change|
  @payload[field] = data_change
end

Quando("faço uma requisição PUT para o endpoint {string}") do |endpoint|
  endpoint = endpoint.gsub('{id}', @created_employee_id.to_s)
  @response = EmployeeApi.put_update(endpoint, @payload)
end

E("deve trazer o dado do campo {string} alterado com sucesso para {string}") do |field, data_change|
  expect(@response[field]).to eq data_change
end
