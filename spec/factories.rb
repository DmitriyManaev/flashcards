FactoryGirl.define do
  factory :user do
    email "example@mail.ru"
    password "password"
    password_confirmation "password"
  end

  factory :pack do
    title "Новая колода"
    user
  end

  factory :card do
    original_text "example"
    translated_text "пример"
    review_date Time.now
    number_of_review 0
    interval_to_review 0
    e_factor 2.5
    pack
  end
end
