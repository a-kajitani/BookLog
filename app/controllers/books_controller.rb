class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to root_path, notice: '本を登録しました。'
    else
      flash.now[:alert] = '本の登録に失敗しました。'
      render :new, status: :unprocessable_entity
    end
  end

    def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book, notice: "本を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find(params[:id])
    unless deletable_by?(current_user, @book)
      redirect_to @book, alert: "削除権限がありません。"
      return
    end
    @book.destroy
    redirect_to root_path, notice: "本を削除しました。"
  end

  
  def show
    @book = Book.find(params[:id])
  end


  private

  def book_params
    params.require(:book).permit(:title, :author)
  end
   # 管理者（admin）と作成者のみ削除可
  def deletable_by?(user, book)
    return true if user&.respond_to?(:admin?) && user.admin?
    book.user_id == user&.id
  end
end