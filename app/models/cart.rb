class Cart
  include Virtus.model

  attribute :drug_ids, Array[Integer]

  delegate :empty?, to: :drug_ids

  def drugs
    Drug.where id: drug_ids
  rescue
    []
  end

  def destroy!
    self.drug_ids=[]
  end

  def items
    drugs.map do |drug|
      CartItem.new drug: drug, count: 1
    end
  end

  def add_drug drug
    self.drug_ids ||= []
    drug_ids << drug.id
  end
end
