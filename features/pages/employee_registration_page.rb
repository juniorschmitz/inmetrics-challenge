class EmployeeRegistrationPage
  include Capybara::DSL
  
  def elements
    {
      btn_logout: 'a[href*="logout"]',
      btn_new_employee: 'a[href*="empregados/new_empregado"]',
      input_name: '#inputNome',
      input_cpf: '#cpf',
      select_gender: 'select[name="sexo"]',
      input_date_admission: '#inputAdmissao',
      input_position: '#inputCargo',
      input_salary: 'input[name="salario"]',
      radio_clt: 'input#clt',
      radio_pj: 'input#pj',
      btn_send_infos: '.cadastrar-form-btn',
      btn_cancel_registration: '.cancelar-form-btn'
    }
  end

  def register_employee(employee)
    find(elements[:input_name]).set employee[:name]
    find(elements[:input_cpf]).set employee[:cpf]
    find(elements[:select_gender]).select employee[:gender]
    find(elements[:input_date_admission]).set employee[:admission]
    find(elements[:input_position]).set employee[:position]
    find(elements[:input_salary]).set employee[:salary]
    find(elements[:radio_clt]).click
    find(elements[:btn_send_infos]).click
  end

  def edit_employee(employee)
    find(elements[:input_name]).set employee[:name]
    find(elements[:input_date_admission]).set employee[:admission]
    find(elements[:btn_send_infos]).click
  end

  def get_btn_logout
    find(elements[:btn_logout])
  end

  def access_new_employee
    find(elements[:btn_new_employee]).click
  end

  def load
    visit '/empregados'
  end
end