require "rails_helper"
describe "Home", type: :feature  do
  let!(:card) { Card.create(original_text: "example",
                            translated_text: "пример")
              }

  before :each do
    visit root_path
  end

  it "check card with right answer" do
    fill_in "translated_text", with: "пример"
    click_button "Проверить"
    expect(page.find("#alert-success")).to have_content "Правильно"
  end

  it "check card with wrong answer" do
    fill_in "translated_text", with: "не правильный ответ"
    click_button "Проверить"
    expect(page.find("#alert-fail")).to have_content "Не правильно"
  end
end
