class Api_v1::All < Grape::API
  version 'v1' #, using: :header
  #format :json

  resources :pharmacies do
    params do
      requires :key,         type: String,  desc: 'Уникальный ключ точки продаж'
      requires :bunch_key,   type: String,  desc: 'Ключ пакета [a-z0-9] (один для всех файлов в пакете)'
      requires :max,         type: Integer, desc: 'Количество файлов в пакете'
      requires :current,     type: Integer, desc: 'Номер текущего файла'
      requires :pharmacy_id, type: Integer, desc: 'ID аптеки'
      optional :try,         type: Integer, desc: 'Номер попытки'
      optional :type,        type: String,  desc: 'Тип файла (по-умолчанию csv)', default: 'csv'
    end
    post :upload do
      begin
        pharmacy = Pharmacy.find_by_key params[:key].strip
        BunchImporter.
          new(pharmacy:  pharmacy, 
              bunch_key: params[:bunch_key], 
              max:       params[:max], 
              type:      params[:type], 
              current:   params[:current]).
          catch_file env['rack.input']
        status 201
      rescue ActiveRecord::RecordNotUnique 
        status 201
      rescue ActiveRecord::RecordNotFound
        status 403
        "No such pharmacy with key #{params[:key]}"
      end
    end
  end

  resource :ping do
    get do
      return 'ok'
    end
  end

end
