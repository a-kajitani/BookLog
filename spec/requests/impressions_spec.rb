require "rails_helper"

RSpec.describe "Impressions", type: :request do
  let!(:admin)   { create(:user, :admin) }
  let!(:user)    { create(:user) }
  let!(:user2)   { create(:user, :second_user) }
  let!(:book)    { create(:book, user: user) }
  let!(:section) { create(:section, book: book, user: user) }
  let!(:imp)     { create(:impression, section: section, user: user, body: "元の感想") }

  describe "一般ユーザーでログイン" do
    before { sign_in user }

    context "感想を新規作成できる" do
      it "DBに新しい感想が追加されること" do
        expect {
          post book_section_impressions_path(book, section),
               params: { impression: { body: "新規の感想" } }
        }.to change(Impression, :count).by(1)

        expect(response).to redirect_to(book_section_path(book, section))
        follow_redirect!
        expect(response.body).to include("新規の感想")
      end
    end

    context "自分の感想を編集できる" do
      it "感想本文が更新されること" do
        patch book_section_impression_path(book, section, imp),
              params: { impression: { body: "編集済みの感想" } }

        expect(response).to redirect_to(book_section_path(book, section))
        follow_redirect!
        expect(response.body).to include("編集済みの感想")
        expect(imp.reload.body).to eq("編集済みの感想")
      end
    end

    context "自分の感想を削除できる" do
      it "DBから感想が削除されること" do
        expect {
          delete book_section_impression_path(book, section, imp)
        }.to change(Impression, :count).by(-1)

        expect(response).to redirect_to(book_section_path(book, section))
        follow_redirect!
        expect(response.body).not_to include("元の感想")
      end
    end

    context "他ユーザーの感想は編集・削除できない" do
      let!(:others_imp) { create(:impression, section: section, user: user2, body: "他人の感想") }

      it "編集はリダイレクトされて更新されない" do
        patch book_section_impression_path(book, section, others_imp),
              params: { impression: { body: "勝手に編集" } }

        expect(response).to redirect_to(book_section_path(book, section))
        follow_redirect!
        expect(others_imp.reload.body).to eq("他人の感想")
      end

      it "削除はリダイレクトされて削除されない" do
        expect {
          delete book_section_impression_path(book, section, others_imp)
        }.not_to change(Impression, :count)

        expect(response).to redirect_to(book_section_path(book, section))
      end
    end
  end

  describe "未ログイン" do
    it "new へアクセスできないならログインページへリダイレクトすること" do
      get new_book_section_impression_path(book, section)
      expect(response).to redirect_to(new_user_session_path)
    end

    it "create に失敗したならログインページへリダイレクトすること" do
      expect {
        post book_section_impressions_path(book, section), params: { impression: { body: "未ログイン投稿" } }
      }.not_to change(Impression, :count)

      expect(response).to redirect_to(new_user_session_path)
    end

    it "edit/update/destroy もログインページへリダイレクトすること" do
      get edit_book_section_impression_path(book, section, imp)
      expect(response).to redirect_to(new_user_session_path)

      patch book_section_impression_path(book, section, imp), params: { impression: { body: "x" } }
      expect(response).to redirect_to(new_user_session_path)

      expect {
        delete book_section_impression_path(book, section, imp)
      }.not_to change(Impression, :count)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "adminでログイン" do
    before { sign_in admin }

    let!(:others_imp) { create(:impression, section: section, user: user2, body: "他人の感想(管理者操作用)") }

    it "他ユーザーの感想を編集できる" do
      patch book_section_impression_path(book, section, others_imp),
            params: { impression: { body: "管理者が編集" } }

      expect(response).to redirect_to(book_section_path(book, section))
      expect(others_imp.reload.body).to eq("管理者が編集")
    end

    it "他ユーザーの感想を削除できる" do
      expect {
        delete book_section_impression_path(book, section, others_imp)
      }.to change(Impression, :count).by(-1)

      expect(response).to redirect_to(book_section_path(book, section))
    end
  end
end