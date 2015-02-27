class Bunch < ActiveRecord::Base
  include WorkerOwner
  belongs_to :pharmacy

  scope :ordered, -> { order 'id desc' }

  has_many :bunch_files, dependent: :delete_all

  validates :max, presence: true
  validates :key, presence: true

  def complete?
    max>0 && bunch_files.count == max
  end

  def files
    bunch_files.map { |bf| bf.file.file }
  end

  def files_size
    bunch_files.map(&:file_size).inject { |a,b| a+b }
  end

  private

  def worker_class
    BunchWorker
  end

end
