Dado('que realize login com usuário {string} e senha {string}') do |login, password|
  @login_page.load
  @login_page.login_with(login, password)
end

Então('deve logar o usuário') do
  expect(@employees_list_page.current_url).to include '/empregados'
  expect(@employees_list_page.get_btn_logout).not_to be nil
end

Então('deve apresentar uma mensagem de usuário e\/ou senha inválidos') do
  alert = @login_page.get_alert_invalid_credentials
  expect(alert).not_to be nil
  expect(alert.text.downcase).to have_content 'usuário ou senha inválidos'
end

Então('deve apresentar um alerta de validação nos campos') do
  expect(@login_page.get_alerts_validate_form.size).to be > 0
end

Dado('que tenha informações para criar um novo usuário') do
  @registration_page.load
  @new_user = {
    "username": "user#{Time.now.strftime('%m%d%H%M%S').to_s}",
    "password": "123456",
    "password_confirmation": "123456"
  }
  Kernel.puts "Usuário gerado: #{@new_user.to_s}"
end

Quando('realizar o cadastro do usuário') do
  @registration_page.register(@new_user)
end

Então('deve ser possível logar com o usuário criado') do
  steps %{
    Dado que realize login com usuário "#{@new_user[:username]}" e senha "#{@new_user[:password]}"
    Então deve logar o usuário
  }
end

Mas('tenha errado a confirmação de senha') do
  @new_user[:password_confirmation] = 'abc1234'
end

Então('deve apresentar uma mensagem de senhas diferentes') do
  message_passwords = @registration_page.get_message_passwords_dont_match
  expect(message_passwords).not_to be nil
  expect(message_passwords.text.downcase).to have_content 'senhas não combinam'
end