class DeviseFailure < Devise::FailureApp

    # You need to override respond to eliminate recall
  def respond
    self.status = 401
    self.content_type = "application/json"

    response = if http_auth? then JSON.parse(http_auth)['error'] else http_auth end
    response_body = { :error => { :description => response , :code => 401 } }.to_json

    self.response_body = response_body
  end

end
