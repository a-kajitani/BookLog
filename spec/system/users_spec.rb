require 'rails_helper'

RSpec.describe "本の一覧と詳細", type: :system do
  let!(:admin) { create(:user, :admin) }
  let!(:user) { create(:user) }
  before do
    driven_by :headless_chrome
  end
  context 'adminでログインした場合' do
    before do
      login(admin)
    end
    it "ユーザー一覧ページにはユーザ名、メールアドレス、一般ユーザの削除ボタンが表示されている" do
      visit root_path
      find('.navbar-toggler').click
      click_link "ユーザー一覧"
      expect(page).to have_link("adminuser")
      expect(page).to have_link("testuser")
      expect(page).to have_link("削除", href: user_path(user))
      expect(page).not_to have_link("削除", href: user_path(admin))
    end
     it "管理者は一般ユーザを削除できる" do
      visit root_path
      find('.navbar-toggler').click
      click_link "ユーザー一覧"
      accept_confirm "本当に削除しますか？" do
        click_link "削除"
      end
      expect(page).not_to have_link("testuser", href: user_path(user))
     end
  end

  context '一般ユーザーでログインした場合' do
    before do
      login(user)
    end
    it "ユーザー一覧ページにはユーザ名、メールアドレスがあり、削除ボタンは表示されない" do
      visit root_path
      find('.navbar-toggler').click
      click_link "ユーザー一覧"
      expect(page).to have_link("adminuser")
      expect(page).to have_link("testuser")
      expect(page).not_to have_link("削除", href: user_path(user))
      expect(page).not_to have_link("削除", href: user_path(admin))
    end
  end
end 
 