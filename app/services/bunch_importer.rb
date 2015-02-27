class BunchImporter
  include Virtus.model strict: true

  attribute :pharmacy,  Pharmacy, requried: true
  attribute :bunch_key, String,   required: true
  attribute :max,       Integer,  requried: true
  attribute :current,   Integer,  requried: true
  attribute :type,      String,   default: 'csv'

  def catch_file content
    File.write path, content
    file = Rack::Test::UploadedFile.new path, mime_type, true

    unless bf = bunch.bunch_files.where( number: current ).first
      bf = bunch.bunch_files.create! file: file, number: current
    end

    File.delete path

    return bf
  end

  private

  def bunch
    @bunch ||= pharmacy.bunches.where(key: bunch_key).first || 
      pharmacy.bunches.create!(key: bunch_key, max: max)
  end

  def mime_type
    "text/csv"
  end

  def path
    Rails.root.join 'tmp', file_name
  end

  def file_name
    pharmacy.id.to_s + '-' + bunch.id.to_s + '-' + current.to_s + '.' + type
  end


end
