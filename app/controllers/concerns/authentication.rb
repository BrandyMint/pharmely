module Authentication
  def authenticate
    unless authenticate_with_http_basic { |login,password| company.authenticate( login, password ) }
      request_http_basic_authentication "Компания ##{company.id}"
    end
  end
end
