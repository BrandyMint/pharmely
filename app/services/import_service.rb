class ImportService
  include Virtus.model strict: true
  # Наименование товара, Цена (отпускная)отпускная, Остаток, Производитель, Страна

  attribute :pharmacy, Pharmacy, required: true
  attribute :files,    Array[ActionDispatch::Http::UploadedFile], required: true
  attribute :worker
  attribute :errors,   Array, default: []

  def perform
    drugs_count, errors_count = 0,0
    time_start = Time.now

    $error = nil
    Chewy.strategy(strategy) do
      pharmacy.transaction do 
        begin
          files.each do |file|
            dc, ec = 
              ImportFileService.
              new(pharmacy: pharmacy, worker: worker, file: file).
              perform
            drugs_count  +=dc
            errors_count +=ec
          end
          pharmacy.touch
          delete_legacy time_start
        rescue => err
          $error = err
          raise err
        end
      end
    end

    raise $error if $error.present?
    return drugs_count, errors_count
  end

  private

  def strategy
    Rails.env.test? ? :bypass : :atomic
  end

  def delete_legacy time_start
    worker.try :at, -1, 'Удаляю старые товары'
    deletes = pharmacy.drugs.where('updated_at<?', time_start)
    ids = deletes.pluck(:id)
    Rails.logger.info "Удаляю старые твоары #{pharmacy.id}: #{ids}"
    DrugsIndex::Drug.filter(term: { id: ids }).delete_all unless Rails.env.test?
    deletes.delete_all
    worker.try :at, -2, 'Готово'
  end

end
#Zip::File.open(file.path) do |zip|
  #binding.pry
  ##if zip.file
  ##zip.dir.foreach(path) do |filename|
    ##ret = process_zipfile_packed(zip, tmpdir, path + filename)
  ##end
#end
