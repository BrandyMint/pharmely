class Bunch < ActiveRecord::Base
  include WorkerOwner
  belongs_to :pharmacy

  scope :ordered, -> { order 'id desc' }

  has_many :bunch_files

  validates :max, presence: true
  validates :key, presence: true

  def complete?
    max>0 && bunch_files.count == max
  end

  private

  def worker_class
    BunchWorker
  end

end
