class RegistrationPage
  include Capybara::DSL

  def elements
    {
      input_username: 'input[name="username"]',
      input_password: 'input[name="pass"]',
      input_confirm_password: 'input[name="confirmpass"]',
      btn_register: '.login100-form-btn',
      link_go_to_login: 'div > a[href^="/accounts/login"]',
      message_passwords_dont_match: '//div[contains(text(), "Senhas não combinam")]'
    }
  end

  def register(user)
    find(elements[:input_username]).set user[:username]
    find(elements[:input_password]).set user[:password]
    find(elements[:input_confirm_password]).set user[:password_confirmation]
    find(elements[:btn_register]).click
  end

  def get_message_passwords_dont_match
    find(:xpath, elements[:message_passwords_dont_match])
  end

  def load
    visit '/accounts/signup'
  end
end
