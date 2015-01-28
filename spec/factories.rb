FactoryGirl.define do
  factory :card do
    original_text "example"
    translated_text "пример"
    review_date Time.now
  end
end
