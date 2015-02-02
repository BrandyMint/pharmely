class ImportService
  MAX_ERRORS = 20
  FIELDS = {
    name: 'Наименование товара',
    price: 'Цена',
    producer: 'Производитель',
    stock_quantity: 'Остаток',
    country: 'Страна'
  }
  include Virtus.model strict: true
  # Наименование товара, Цена (отпускная)отпускная, Остаток, Производитель, Страна

  attribute :pharmacy, Pharmacy, required: true
  attribute :file,     ActionDispatch::Http::UploadedFile, required: true
  attribute :columns,  Hash,  default: {}
  attribute :errors,   Array, default: []

  def perform
    detect_columns

    drugs = []

    time_start = Time.now
    Chewy.strategy(:atomic) do
      pharmacy.transaction do 
        (first_row..roo.last_row).each do |row_num|
          begin
            drugs << import_row( roo.row row_num )
          rescue => err
            errors << LogEntity.new(row_num: row_num, message: err.to_s)
            raise_error "Слишком много ошибок! (больше #{MAX_ERRORS})" if errors.count>MAX_ERRORS
          end
        end
        raise Error, errors if errors.any?

        pharmacy.drugs.where('updated_at<?', time_start).destroy_all
      end
    end

    pharmacy.touch

    return drugs
  end

  private

  def import_row row
    attrs = {}
    columns.each do |key, index|
      attrs[key] = row[index]
    end
    pharmacy.drugs.create! attrs
  end

  def detect_columns
    self.columns||={}
    roo.row(roo.first_row).each_with_index do |value, index|
      FIELDS.each do |key, regexp|
        columns[key] = index if Regexp.new(regexp)=~value
      end
    end

    unknown_columns = FIELDS.keys - columns.keys

    raise_error "Не устовлены колонки: #{unknown_columns}" if unknown_columns.any?
  end

  def raise_error message = nil
    self.errors << message if message.present?
    raise Error.new(errors)
  end

  def first_row
    roo.first_row + 1
  end

  def roo
    @roo ||= Roo::Spreadsheet.open file.path, extension: :xlsx
  end

  def sheet
    roo.sheet roo.default_sheet #sheets.first
  end

  class LogEntity
    include Virtus.model 
    attribute :row_num, Integer
    attribute :column_num, Integer
    attribute :message, String, required: true
  end

  class Error < StandardError
    attr_reader :errors
    def initialize errors
      @errors = errors
    end
  end
end
