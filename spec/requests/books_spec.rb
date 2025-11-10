
require 'rails_helper'
describe 'Books', type: :request do
  let!(:user) { User.create(email: "test@example.com", password: "password") }
  let!(:book) { Book.create(title: "テスト本", author: "名前", user: user) }

  it '本の情報を更新できる' do
    patch book_path(book), params: { book: { title: '新しい題名', author: '新しい名前' } }
    expect(response).to redirect_to(book_path(book))
    follow_redirect!
    expect(response.body).to include('新しい題名')
    expect(response.body).to include('新しい名前')
  end

   it '本の情報を削除できる' do
    expect {
      delete book_path(book)
    }.to change(Book, :count).by(-1)
    expect(response).to redirect_to(root_path)
    follow_redirect!
    expect(response.body).not_to include('テスト本')
    expect(response.body).not_to include('名前')
  end
end
