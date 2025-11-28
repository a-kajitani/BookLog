class UsersController < ApplicationController
  
before_action :authenticate_user!
before_action :authorize_deletion, only: [:destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id]) 
    # 章→本までプリロードして N+1 を防ぐ
    @impressions = @user.impressions
                        .includes(section: :book)
                        .order(created_at: :desc)
  end

  def destroy
    
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, notice: "#{user.name} を削除しました"

  end

  private
    def authorize_deletion
      user = User.find(params[:id])
      if !current_user.admin?
        redirect_to root_path, alert: "削除権限がありません"
      elsif user == current_user
        redirect_to root_path, alert: "削除権限がありません"
      end
    end
  end
