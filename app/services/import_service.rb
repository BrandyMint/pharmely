require 'zip/filesystem'
class ImportService
  # CSV format
  # : Field delimeter = ,
  # : Text delimeter = "
  # http://ruby-doc.org/stdlib-1.9.3/libdoc/csv/rdoc/CSV.html
  #
  MAX_ERRORS = 20
  EXTENTIONS=['.xlsx', '.xls', '.csv']
  FIELDS = {
    name: 'Наименование товара',
    price: 'Цена',
    producer: 'Производитель',
    stock_quantity: 'Остаток',
    country: 'Страна',
    article: 'артикул',
    barcodes: 'штрих',
    unit:    'измерения'
  }
  REQUIRED_FIELDS = [:name, :price, :stock_quantity]

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

        deletes = pharmacy.drugs.where('updated_at<?', time_start)
        ids = deletes.pluck(:id)
        DrugsIndex::Drug.filter(term: { id: ids }).delete_all
        deletes.delete_all
      end
    end

    pharmacy.touch

    return [drugs.count, errors.count]
  end

  def import_row row
    return if row[columns[:name]]=='Итого'
    attrs = {}
    columns.each do |key, index|
      attrs[key] = row[index]
    end
    Rails.logger.debug "Import row: #{attrs}"
    pharmacy.drugs.create! attrs
  end

  def detect_columns
    self.columns||={}
    roo.row(roo.first_row).each_with_index do |value, index|
      FIELDS.each do |key, regexp|
        columns[key] = index if Regexp.new(regexp)=~value
      end
    end

    unknown_columns = REQUIRED_FIELDS - columns.keys

    raise_error "Не устовлены обязательные колонки: #{unknown_columns}" if unknown_columns.any?
  end

  def raise_error message = nil
    self.errors << message if message.present?
    raise Error.new(errors)
  end

  def first_row
    roo.first_row + 1
  end

  def roo
    @roo ||= Roo::Spreadsheet.open file.path, extension: File.extname(file.original_filename)
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

    def to_s
      errors.to_s
    end
  end
end
