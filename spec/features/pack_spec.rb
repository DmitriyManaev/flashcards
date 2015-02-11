require "rails_helper"
describe "Pack" do
  before do
    FactoryGirl.create(:user)
    login
  end

  it "login" do
    expect(page).to have_content("Добро пожаловать")
  end

  context "new pack" do
    before do
      click_link "Добавить колоду"
      fill_in "pack_title", with: "Новая колода"
      click_button "Сохранить"
    end

    it "created" do
      expect(page).to have_content("Колода успешно создана")
    end

    it "deleted" do
      click_link "Колоды"
      click_link "Новая колода"
      click_link "Удалить"
      expect(page).to have_content("Колода удалена")
    end
  end
end
