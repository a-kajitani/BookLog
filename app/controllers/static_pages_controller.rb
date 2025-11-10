class StaticPagesController < ApplicationController
  def home
    @books = Book.all
  end

  def help
  end
end
