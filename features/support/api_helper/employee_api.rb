class EmployeeApi
  include HTTParty
  base_uri "https://inm-api-test.herokuapp.com"
  headers "accept" => "*/*", "Content-Type" => "application/json"

  def self.post_create(endpoint, payload)
    auth = {:username => "inmetrics", :password => "automacao"}
    post(endpoint, body: payload.to_json, basic_auth: auth)
  end

  def self.put_update(endpoint, payload)
    auth = {:username => "inmetrics", :password => "automacao"}
    put(endpoint, body: payload.to_json, basic_auth: auth)
  end

  def self.retrieve(endpoint)
    auth = {:username => "inmetrics", :password => "automacao"}
    get(endpoint, basic_auth: auth)
  end
end
