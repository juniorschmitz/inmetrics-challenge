class EmployeesListPage
  include Capybara::DSL
  
  def elements
    {
      btn_logout: 'a[href*="logout"]',
      btn_new_employee: 'a[href*="empregados/new_empregado"]',
      input_search_for_employee: 'input[type="search"]',
      alert_success: '.alert-success',
      list_employees: '#tabela tbody tr',
      btn_delete_employee: '#delete-btn',
      btn_edit_employee: '.btn-warning'
    }
  end

  def get_employee(index = 0)
    find_all(elements[:list_employees])[index]
  end

  def access_employee_edit(index = 0)
    employee = get_employee(index)
    employee.find(elements[:btn_edit_employee]).click
  end

  def delete_employee(index = 0)
    employee = get_employee(index)
    employee.find(elements[:btn_delete_employee]).click
  end

  def search_for_employee(name)
    find(elements[:input_search_for_employee]).set name
  end

  def get_alert_success
    find(elements[:alert_success])
  end

  def get_btn_logout
    find(elements[:btn_logout])
  end

  def access_new_employee
    find(elements[:btn_new_employee]).click
  end

  def get_btn_edit_employee
    employee.find_all(elements[:btn_delete_employee]).click
  end

  def load
    visit '/empregados'
  end
end