require 'rails_helper'

RSpec.describe 'ログインAPI', type: :request do
  let!(:user) { create(:user) }

  it '正しい情報でログインできる' do
    post user_session_path, params: {
      user: {
        email: 'test@example.com',
        password: 'testuser'
      }
    }

    expect(response).to redirect_to(root_path) # ログイン後の遷移先
  end

  it '間違った情報ではログインできない' do
    post user_session_path, params: {
      user: {
        email: 'wrong@example.com',
        password: 'wrongpassword'
      }
    }

    expect(response.body).to include('Eメールまたはパスワードが違います。')
  end
end