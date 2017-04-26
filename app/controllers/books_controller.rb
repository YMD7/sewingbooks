class BooksController < ApplicationController
  def show
    @book  = Book.find(params[:id])
    @prev_book = Book.find(params[:id].to_i - 1) if Book.exists?(:id => params[:id].to_i - 1)
    @next_book = Book.find(params[:id].to_i + 1) if Book.exists?(:id => params[:id].to_i + 1)
    @users = User.all
  end
end
