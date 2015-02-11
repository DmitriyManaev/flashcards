module Helpers
  def login
    visit login_path
    fill_in "email", with: "example@mail.ru"
    fill_in "password", with: "password"
    click_button "Отправить"
  end
end
