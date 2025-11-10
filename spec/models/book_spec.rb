require 'rails_helper'

RSpec.describe Book, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  let(:user) { User.create(email: "test@example.com", password: "password") }
  it "タイトルがあれば有効" do
      book = Book.new(title: "テスト本", author: "著者", user: user)
      expect(book).to be_valid
    end

    it "タイトルがなければ無効" do
      book = Book.new(title: nil, user: user)
      expect(book).not_to be_valid
    end
end
