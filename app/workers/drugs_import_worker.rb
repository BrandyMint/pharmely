# http://www.rubydoc.info/gems/sidekiq-dynamic-queues/0.6.0
class DrugsImportWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker 
  AVAILABLE_EXTENTIONS = ImportFileService::EXTENTIONS

  #sidekiq_options unique: true,
    #unique_args: ->(args) { [ args.first ] }

  def perform id, price_list_id
    pharmacy = Pharmacy.find id
    pl = pharmacy.price_lists.find price_list_id

    import_drugs pl
  rescue ActiveRecord::RecordNotFound
  end

  #Zip::File.open(file.path) do |zip|
    #binding.pry
    ##if zip.file
    ##zip.dir.foreach(path) do |filename|
      ##ret = process_zipfile_packed(zip, tmpdir, path + filename)
    ##end
  #end
  private

  def import_drugs pl
    pl.start!
    drugs_count, errors_count = ImportService.
      new(pharmacy: pl.pharmacy, 
          worker: self,
          files: [pl.file.file]).
      perform
    pl.update_columns drugs_count: drugs_count, errors_count: errors_count
  ensure
    pl.finish!
  end
end
