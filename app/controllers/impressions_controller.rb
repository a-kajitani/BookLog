# app/controllers/impressions_controller.rb
class ImpressionsController < ApplicationController
  before_action :require_login
  before_action :set_section 
  before_action :set_impression, only: [:edit, :update, :destroy]
  before_action :authorize_owner_or_admin!, only: [:edit, :update, :destroy]


  def new
    @impression = Impression.new
  end

  def create
    @impression = @section.impressions.build(impression_params.merge(user: current_user))

    if @impression.save
      redirect_to [@section.book, @section], notice: "感想を投稿しました。"
    else
      flash.now[:alert] = "感想の投稿に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  
  def edit
  end


  def update
    # if @impression.update(impression_params)
    #   redirect_to [@section.book, @section], notice: "感想を更新しました。"
    # else
    #   flash.now[:alert] = "感想の更新に失敗しました。"
    # end 
    if @impression.update(impression_params)  
      redirect_target = params[:return_to].presence || polymorphic_path([@section.book, @section])
      redirect_to redirect_target, notice: "感想を更新しました。"
    else
      flash.now[:alert] = "感想の更新に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @impression.destroy
    redirect_to [@section.book, @section], notice: "感想を削除しました。"
  end


  private

    def set_section
      @section = Section.find(params[:section_id])
    end

    
  def set_impression
    @impression = @section.impressions.find(params[:id])
  end


    def impression_params
      params.require(:impression).permit(:body)
    end
    
  # 許可した戻り先のみ通す（例：ユーザーページ）
  def safe_return_path
    raw = params[:return_to].to_s
    return nil if raw.blank?

    # ユーザーページのみ許可する
    user_path(@impression.user) == raw ? raw : nil
  end

    def require_login
      if current_user.nil?
      redirect_to new_user_session_path, alert: "ログインが必要です。"
    end
    
    # 投稿者本人 or admin のみ許可
    def authorize_owner_or_admin!
      unless owns_record?(current_user, @impression) || current_user&.admin?
        redirect_to [@section.book, @section], alert: "操作する権限がありません。"
      end
    end
    
    def owns_record?(user, record)
      user && record.user_id == user.id
    end
  end
end