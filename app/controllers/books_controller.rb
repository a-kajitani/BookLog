class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    current_user = User.first
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
end