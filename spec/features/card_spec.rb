require "rails_helper"
describe "Card" do
  describe "new card" do
    before do
      FactoryGirl.create(:pack, title: "Новая колода")
      login
      click_link "Колоды"
      click_link "Новая колода"
      click_link "Добавить карту"
      fill_in "card_original_text", with: "table"
      fill_in "card_translated_text", with: "стол"
      click_button "Сохранить"
    end

    it "created" do
      expect(page).to have_content("Карта успешно создана")
    end

    it "deleted" do
      click_link "Удалить"
      expect(page).to have_content("Карта удалена")
    end
  end

  describe "check card on home page" do
    before :each do
      FactoryGirl.create(:card, translated_text: "пример")
      login
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
end
