# Добавляем Content-Type для запросов из 1С 7.7

class Rack::AddContentType
  def initialize(app)
    @app = app       
  end                

  def call(env)      
    # Добавлять ли ?
    #Accept: */*
    if env['HTTP_USER_AGENT']=="1C"
      env['CONTENT_TYPE'] ||= 'application/octet-stream'
    end
    @app.call(env)   
  end                
end  
