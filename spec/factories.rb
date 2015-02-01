FactoryGirl.define do
  factory :card do
    original_text "example"
    translated_text "пример"
    review_date Time.now
    user
  end

  factory :user do
    email "example@mail.ru"
    password "password"
    password_confirmation "password"
  end
end
