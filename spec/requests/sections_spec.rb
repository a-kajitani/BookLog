require 'rails_helper'

RSpec.describe "Sections", type: :request do
  let!(:admin) { create(:user, :admin) }
  let!(:user) { create(:user) }
  let!(:user2) { create(:user, :second_user) }
  let!(:book) { create(:book, user: user) }
  let!(:section) { create(:section, book: book, user: user) }

  describe "一般ユーザーでログイン" do
    before { sign_in user }

    context "章を追加できる" do
      it "DBに新しい章が追加される" do
        expect {
          post book_sections_path(book), params: { section: { content: "追加した章" } }
        }.to change(Section, :count).by(1)

        expect(response).to redirect_to(book_path(book))
        follow_redirect!
        expect(response.body).to include("追加した章")
      end
    end

    context "章を編集できる" do
      it "章の名前が更新される" do
        patch book_section_path(book, section), params: { section: { content: "編集済みの章" } }
        expect(response).to redirect_to(book_path(book))
        follow_redirect!
        expect(response.body).to include("編集済みの章")
        expect(section.reload.content).to eq("編集済みの章")
      end
    end

    context "章を削除できる" do
      it "DBから章が削除される" do
        expect {
          delete book_section_path(book, section)
        }.to change(Section, :count).by(-1)

        expect(response).to redirect_to(book_path(book))
        follow_redirect!
        expect(response.body).not_to include("テスト用の章")
      end
    end

    context "他ユーザーが作った章は削除できない" do
      before do
        sign_out user
        sign_in user2
      end

      it "削除リクエストを送っても章は残る" do
        expect {
          delete book_section_path(book, section)
        }.not_to change(Section, :count)

        expect(response).to have_http_status(:found) 
        expect(response).to redirect_to(book_path(book))
      end
    end
  end

  describe "adminでログイン" do
    before { sign_in admin }

    it "管理者は他ユーザが作った章を削除できる" do
      expect {
        delete book_section_path(book, section)
      }.to change(Section, :count).by(-1)

      expect(response).to redirect_to(book_path(book))
    end
  end
end


  