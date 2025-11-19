
require 'rails_helper'
describe 'Books', type: :request do
  let!(:admin)   { create(:user, :admin) }
  let!(:user) { create(:user) }
  let!(:user2)   { create(:user, :second_user) }
  let!(:book) { create(:book, user: user) }
  let!(:book2) { create(:book, :book2, user: user2) }
  describe "一般ユーザーでログイン" do
    before do
      sign_in user
    end
    it '本の情報を更新できる' do
      patch book_path(book), params: { book: { title: '新しい題名', author: '新しい名前' } }
      expect(response).to redirect_to(book_path(book))
      follow_redirect!
      expect(response.body).to include('新しい題名')
      expect(response.body).to include('新しい名前')
    end

    it '本を削除できる' do
      expect {
        delete book_path(book)
      }.to change(Book, :count).by(-1)
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).not_to include('テスト本')
      expect(response.body).not_to include('名前')
    end

    it '他ユーザの作成した本は削除できない' do
      expect {
        delete book_path(book2)
      }.not_to change(Book, :count)
      expect(response).to redirect_to(book_path(book2))
      follow_redirect!
      expect(response.body).to include('testbook')
      expect(response.body).to include('name')
    end
  end
   describe "管理者でログイン" do
    before do
      sign_in admin
    end
    
    it '一般ユーザが作成した本の情報を削除できる' do
      expect {
        delete book_path(book)
      }.to change(Book, :count).by(-1)
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).not_to include('テスト本')
      expect(response.body).not_to include('名前')
    end
  end
end
