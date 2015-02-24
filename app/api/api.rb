require 'grape-swagger'
class API < Grape::API
  mount Api_v1::All

  add_swagger_documentation api_version: 'v1', base_path: 'api'
end

