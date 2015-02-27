require "rails_helper"
describe "Card" do
  describe "home page" do
    before :each do
      visit root_path
    end

    it "for non logged users" do
      expect(page).to have_content("Войдите или зарегистрируйтесь")
    end

    it "for logged users without actual cards" do
      FactoryGirl.create(:user)
      login
      expect(page).to have_content("Карт на сегодня больше нет!")
    end
  end

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

  describe "check card on home page", js: true do
    before do
      FactoryGirl.create(:card, translated_text: "пример")
      login
    end

    it "with wrong answer" do
      fill_in "translated_text", with: "неправильный ответ"
      click_button "Проверить"
      expect(page).to have_content "Не правильно"
    end

    it "with right answer" do
      fill_in "translated_text", with: "пример"
      click_button "Проверить"
      expect(page).to have_content "Правильно"
    end
  end
end
