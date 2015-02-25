class Api_v1::All < Grape::API
  version 'v1' #, using: :header
  #format :json

  resources :pharmacies do
    params do
      requires :key,       type: String, desc: 'Уникальный ключ точки продаж'
      requires :bunch_key, type: String, desc: 'Ключ пакета (один для всех файлов в пакете)'
      requires :max,       type: String, desc: 'Количество файлов в пакете'
      requires :current,   type: String, desc: 'Номер текущего файла'
      optional :type,      type: String, desc: 'Тип файла (по-умолчанию csv)', default: 'csv'
    end
    post :upload do
      begin
        pharmacy = Pharmacy.find_by_key params[:key]
        BunchImporter.
          new(pharmacy: pharmacy, 
              bunch_key: params[:bunch_key], 
              max: params[:max], 
              type: params[:type], 
              current: params[:currenty]).
          catch_file env['rack.input']
      rescue ActiveRecord::RecordNotFound
        status 403
        "no such pharmacy"
      end
    end
  end

  resource :ping do
    get do
      return 'ok'
    end
  end

end
