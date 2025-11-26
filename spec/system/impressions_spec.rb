require 'rails_helper'

RSpec.describe "本の一覧と詳細", type: :system do
  let!(:admin) { create(:user, :admin) }
  let!(:user) { create(:user) }
  let!(:user2) { create(:user, :second_user) }
  let!(:book) { create(:book, user: user) }
  let!(:section) { create(:section, book: book, user: user) }
  let!(:imp)     { create(:impression, section: section, user: user) }
  before do
    driven_by :headless_chrome
  end

  context '一般ユーザーでログイン' do
    before do
      login(user)
    end
    it "感想を追加できる" do
      visit root_path
      click_link "テスト本"
      click_link "テスト用の章"
      click_link "感想を投稿"
      fill_in "感想", with: "追加した感想"
      click_button "投稿する"
      expect(page).to have_content "追加した感想"
    end
    it "感想を編集できる" do
      visit root_path
      click_link "テスト本"
      click_link "テスト用の章"
      click_link "編集",exact: true
      fill_in "感想", with: "編集済みの感想"
      click_button "更新する"
      expect(page).to have_content "編集済みの感想"
    end
    it "感想を削除できる" do
      visit root_path
      click_link "テスト本"
      click_link "テスト用の章"
      accept_confirm "削除しますか？" do
        click_link "削除",exact: true
      end
      expect(page).not_to have_content "とても参考になった"
    end
  end
  context 'adminでログイン' do
    before do
      login(admin)
    end
    it "管理者は他ユーザが作った感想を削除できる" do
      visit root_path
      click_link "テスト本"
      click_link "テスト用の章"
      accept_confirm "削除しますか？" do
        click_link "削除",exact: true
      end
      expect(page).not_to have_content "とても参考になった"
    end
  end
end 
 