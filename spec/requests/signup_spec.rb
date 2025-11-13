require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :request do
  describe 'POST /users' do
    context '有効な情報の場合' do
      it 'ユーザーを作成し、リダイレクトされる' do
        expect {
          post user_registration_path, params: {
            user: {
              name: '新規ユーザー',
              email: 'newuser@example.com',
              password: 'password123',
              password_confirmation: 'password123'
            }
          }
        }.to change(User, :count).by(1)

        expect(response).to redirect_to(root_path) # 登録後の遷移先に合わせて変更
      end
    end

    context '無効な情報の場合' do
      it 'ユーザーは作成されない' do
        expect {
          post user_registration_path, params: {
            user: {
              name: '',
              email: '',
              password: 'short',
              password_confirmation: 'mismatch'
            }
          }
        }.not_to change(User, :count)

        #expect(response.body).to include('エラー') # 実際のエラーメッセージに合わせて変更
      end
    end
  end
end