# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :expense do
    amount 10
    category "food"
    user_id 1
  end
end
