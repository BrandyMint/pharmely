FactoryGirl.define do
  sequence(:name) {|n| "name#{n}" }
  factory :drug do
    name { generate :name }
    producer { generate :name }
    country { generate :name }
    stock_quantity 1
    price 12.34 
    pharmacy
  end

end

