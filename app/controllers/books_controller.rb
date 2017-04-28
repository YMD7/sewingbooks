class BooksController < ApplicationController
  def show
    @book  = Book.find(params[:id])
    @prev_book = Book.where("id < #{params[:id]}").order('id DESC').first
    @next_book = Book.where("id > #{params[:id]}").order('id ASC').first
    @users = User.all
  end
end
