require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:admin)  { create(:user, :admin) }
  let!(:user1)  { create(:user) }
  let!(:user2)  { create(:user, :second_user) }

  before do
    sign_in admin
  end
  describe "GET /index" do
    it "returns http success" do
      get users_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get user_path(admin)
      expect(response).to have_http_status(:success)
    end
  end
  
  it "管理者は自分以外のユーザーを削除できる" do
    expect {
      delete user_path(user1)
    }.to change(User, :count).by(-1)

    expect(response).to have_http_status(:redirect) # 一覧や適切な場所へリダイレクト想定
    follow_redirect!
  end

  
  it "管理者自身は削除できない" do
      expect {
        delete user_path(admin)
      }.not_to change(User, :count)

      # 設計に合わせて
      expect(response).to have_http_status(:forbidden).or have_http_status(:redirect)
  end

  
  it "一般ユーザーは他人を削除できない" do
    sign_out(:admin)
    sign_in user1
      expect {
        delete user_path(user2)
      }.not_to change(User, :count)
      expect(response).to have_http_status(:redirect) # or :forbidden
  end
 it "一般ユーザーは自分を削除できない" do
    sign_out(:admin)
    sign_in user1
      expect {
        delete user_path(user1)
      }.not_to change(User, :count)
      expect(response).to have_http_status(:redirect) # or :forbidden
  end



  # describe "GET /destroy" do
  #   it "returns http success" do
  #     get "/users/destroy"
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end
