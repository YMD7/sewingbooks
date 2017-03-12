class LibraryController < ApplicationController
  def index
    @book = Book.new
    @user = User.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to action: 'index'
    else
      render 'index'
    end
  end

  private

    def book_params
      params.require(:book).permit(
        :name,
        :author,
        :status,
        :recommended_by,
        :comment,
        :recommend_date,
      )
    end
end
