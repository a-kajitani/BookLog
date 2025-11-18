require 'rails_helper'

RSpec.describe "本の一覧と詳細", type: :system do
  let!(:admin) { create(:user, :admin) }
  let!(:user) { create(:user) }
  let!(:user2) { create(:user, :second_user) }
  let!(:book) { create(:book, user: user) }
  let!(:section) { create(:section, book: book, user: user) }
  before do
    driven_by :headless_chrome
  end

  context '一般ユーザーでログイン' do
    before do
      login(user)
    end
    it "章を追加できる" do
      visit root_path
      click_link "テスト本"
      click_link "章を追加"
      fill_in "章・ページ名", with: "追加した章"
      click_button "追加する"
      expect(page).to have_link("追加した章")
    end
    it "章を編集できる" do
      visit root_path
      click_link "テスト本"
      click_link "テスト用の章"
      click_link "章・ページ名編集"
      fill_in "章・ページ名", with: "編集済みの章"
      click_button "更新する"
      expect(page).to have_link("編集済みの章")
    end
    it "章を削除できる" do
      visit root_path
      click_link "テスト本"
      click_link "テスト用の章"
      click_link "章・ページ名編集"
      accept_confirm "削除すると関連する情報もすべて失われます。本当に削除しますか？" do
        click_link "章・ページを削除する"
      end
      expect(page).not_to have_link("テスト用の章")
    end
    it "他ユーザーが作った章は削除リンクが表示されていない" do
      sign_out(user)
      login(user2)
      visit root_path
      click_link "テスト本"
      click_link "テスト用の章"
      click_link "章・ページ名編集"
      expect(page).not_to have_link("章・ページを削除する")
    end
  end
  context 'adminでログイン' do
    before do
      login(admin)
    end
    it "管理者は他ユーザが作った章を削除できる" do
      visit root_path
      click_link "テスト本"
      click_link "テスト用の章"
      click_link "章・ページ名編集"
      accept_confirm "削除すると関連する情報もすべて失われます。本当に削除しますか？" do
        click_link "章・ページを削除する"
      end
      expect(page).not_to have_link("テスト用の章")
    end
  end
end 
 