def take_screenshot(step_name)
  ss_name = "report/screenshots/shot_#{Time.now.strftime('%Y%m%d%H%M%S')}.png"
  ss = Capybara.page.save_screenshot(ss_name)
  ss_b64 = Base64.encode64(File.open(ss, "rb").read)
  embed(ss_b64, 'image/png')
end

Before do
  if ENV['API_EXECUTION'].nil?
    @login_page = LoginPage.new
    @registration_page = RegistrationPage.new
    @employees_list_page = EmployeesListPage.new
    @employee_registration_page = EmployeeRegistrationPage.new
  end
end

AfterStep do |step|
  if ENV['API_EXECUTION'].nil?
    take_screenshot('step')
  end
end