FactoryGirl.define do
  factory :card do
    original_text "example"
    translated_text "пример"
    user_id 1
    review_date Time.now
  end
end
