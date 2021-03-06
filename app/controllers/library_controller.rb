class LibraryController < ApplicationController
  before_action :create_type?, only: [:create, :update_book]

  def index
    @book  = Book.new
    @books = Book.all
    @user  = User.new
    @users = User.all
    @acts  = Activity.all
  end

  def create
    case @type
    when 'book' then
      result = Book.new(book_params).save
    when 'user' then
      result = create_user
    end

    if result
      redirect_to action: 'index', :notice => "#{@type}の追加に成功"
    else
      redirect_to action: 'index', :alert => "#{@type}の追加に失敗"
    end
  end

  def create_user
    p = params[:user]
    @user = User.invite!({"email"=>"user@sample.mail", "name"=>p[:name], "dept"=>p[:dept], "role"=>p[:role], "portrait"=>p[:portrait]}) do |u|
      u.skip_invitation = true
    end
    token = Devise::VERSION >= "3.1.0" ? @user.instance_variable_get(:@raw_invitation_token) : @user.invitation_token
    User.accept_invitation!(:invitation_token => token, :password => 'sewingbooks_2017', :password_confirmation => 'sewingbooks_2017')

    @user.save
  end

  def update_book
    book = Book.find(params[:book][:id])
    book.update_attribute(:status, params[:book][:status])
    Activity.create({
      :status => params[:book][:status],
      :book   => params[:book][:id],
      :user   => "",
    })
    redirect_to action: 'index'
  end

  private

    def create_type?
      params.each do |key, val|
        if key == 'book' or key == 'user'
          @type = key
        end
      end
    end

    def book_params
      params.require(:book).permit(
        :name,
        :author,
        :status,
        :recommended_by,
        :comment,
        :recommended_date,
        :book_cover,
      )
    end

    def user_params
      params.require(:user).permit(
        :name,
        :dept,
        :role,
        :portrait,
      )
    end
end
