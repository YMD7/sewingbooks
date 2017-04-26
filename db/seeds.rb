# # User
# yml = File.read("#{Rails.root}/db/seeds/user.yml")
# list = YAML.load(yml)
# p list
#
# def adduser(attr)
# 	@user = User.invite!(attr)
# 	token = Devise::VERSION >= "3.1.0" ? @user.instance_variable_get(:@raw_invitation_token) : @user.invitation_token
#   pw    = "sewingbooks_2017"
# 	User.accept_invitation!(:invitation_token => token, :password => pw, :password_confirmation => pw)
# 	@user
# end
#
# list.each_with_index do |(u),i|
#   attr = {
#     :email => "#{u["user"]}@sample.mail",
#     :name  => u["name"],
#     :dept  => u["dept"],
#     :role  => u["role"],
#     :portrait => open("#{Rails.root}/db/seeds/#{u['portrait']}"),
#     :skip_invitation => true,
#   }
#   p attr[:name]
#   adduser(attr)
# end

# Book
yml = File.read("#{Rails.root}/db/seeds/book.yml")
list = YAML.load(yml)
p list

def addbook(attr)
  @book = Book.create(attr)
end

list.each_with_index do |(list),i|
  attr = {
    :name             => list["name"],
    :author           => list["author"],
    :status           => list["status"],
    :recommended_by   => list["recommended_by"],
    :comment          => list["comment"],
    :recommended_date => list["recommended_date"],
    :book_cover       => open("#{Rails.root}/db/seeds/#{list['book_cover']}")
  }
  p attr
  break
  addbook(attr)
end

