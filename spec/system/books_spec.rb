require 'rails_helper'

RSpec.describe "本の一覧と詳細", type: :system do
  let!(:user) { create(:user) }
  let!(:book) { create(:book, user: user) }
  before do
      login(user)
      driven_by :headless_chrome
  end

  it "一覧ページにタイトルが表示されている" do
    visit root_path
    expect(page).to have_content("テスト本")
  end

  it "タイトルをクリックすると詳細ページに遷移する" do
    visit root_path
    click_link "テスト本"
    expect(page).to have_content("名前")
  end

  it "編集ページから編集できる" do
    visit root_path
    click_link "テスト本"
    click_link "書籍情報の編集",exact: true
    expect {
        fill_in "題名", with: "新しい題名"
        fill_in "著者", with: "新しい名前"
        click_button "更新"
      }.not_to change(Book, :count)
    expect(page).to have_content "新しい題名"
    expect(page).to have_content "新しい名前"
  end
end
