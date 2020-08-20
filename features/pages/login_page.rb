class LoginPage
  include Capybara::DSL
  
  def elements
    {
      input_username: 'input[name="username"]',
      input_password: 'input[name="pass"]',
      btn_login: '.login100-form-btn',
      link_go_to_registration: 'div > a[href^="/accounts/signup"]',
      alert_invalid_credentials: '.alert-danger',
      alerts_validate_form: '.alert-validate'
    }
  end

  def login_with(login, password)
    find(elements[:input_username]).set login
    find(elements[:input_password]).set password
    find(elements[:btn_login]).click
  end

  def get_alert_invalid_credentials
    find(elements[:alert_invalid_credentials])
  end

  def get_alerts_validate_form
    find_all(elements[:alerts_validate_form])
  end

  def load
    visit '/accounts/login'
  end
end