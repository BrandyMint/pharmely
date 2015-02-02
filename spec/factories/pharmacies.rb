FactoryGirl.define do
  sequence(:address) {|n| "address#{n}" }
  factory :pharmacy do
    company
    address { generate :address }
    
  end

end
