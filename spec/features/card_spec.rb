require "rails_helper"
describe "Check card on home page" do
  before :each do
    FactoryGirl.create(:card, translated_text: "пример")
    visit root_path
  end

  it "with right answer" do
    fill_in "translated_text", with: "пример"
    click_button "Проверить"
    expect(page).to have_content "Правильно"
  end

  it "with wrong answer" do
    fill_in "translated_text", with: "не правильный ответ"
    click_button "Проверить"
    expect(page).to have_content "Не правильно"
  end
end
