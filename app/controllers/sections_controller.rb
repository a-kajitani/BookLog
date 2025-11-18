class SectionsController < ApplicationController
  before_action :set_book
  before_action :authenticate_user!
  before_action :set_section, only: [:show, :edit, :update, :destroy]
  def new
    @section = @book.sections.build
  end

  def create
    @section = @book.sections.build(section_params)
    @section.user = current_user

    # position を末尾に（明示値が来ていない場合）
    if @section.position.nil?
      max_pos = @book.sections.maximum(:position)
      @section.position = max_pos.present? ? max_pos + 1 : 1
    end

    if @section.save
      redirect_to @book, notice: "章を追加しました。"
    else
      flash.now[:alert] = "章の追加に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @section = @book.sections.find(params[:id])
  end

  def update
    @section = @book.sections.find(params[:id])
    # 編集はオープン編集（全員可）の設計ならそのまま更新
    if @section.update(section_params)
      redirect_to @book, notice: "章を更新しました。"
    else
      flash.now[:alert] = "章の更新に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @section = @book.sections.find(params[:id])
    unless deletable_by?(current_user, @section)
      redirect_to @book, alert: "削除権限がありません。"
      return
    end

    @section.destroy
    redirect_to @book, notice: "章を削除しました。"
  end

  def show

  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  
  def set_section
    @section = @book.sections.find(params[:id])
  end


  def section_params
    params.require(:section).permit(:content, :position)
  end

  # 管理者（admin）と作成者のみ削除可
  def deletable_by?(user, section)
    return true if user&.respond_to?(:admin?) && user.admin?
    section.user_id == user&.id
  end
end
