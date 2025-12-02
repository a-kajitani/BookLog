class StaticPagesController < ApplicationController
  def home
    @books = Book.all           
            .order(created_at: :desc)       # 降順
            .page(params[:page])            # Kaminariのページネーション
            .per(18) 
  end

  def help
  end
end
