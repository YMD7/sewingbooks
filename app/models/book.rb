class Book < ApplicationRecord
  mount_uploader :book_cover, BookCoverUploader
end
