FactoryGirl.define do
  sequence(:title) {|n| "title#{n}" }
  factory :company do
    title { generate :title }
    
  end

end
