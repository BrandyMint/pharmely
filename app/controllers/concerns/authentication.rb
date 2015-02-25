module Authentication
  def authenticate
    return if Rails.env.development?
    unless authenticate_with_http_basic { |login,password| company.authenticate( login, password ) }
      request_http_basic_authentication "Company ##{company.id}"
    end
  end
end
