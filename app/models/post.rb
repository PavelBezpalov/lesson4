class Post < ActiveRecord::Base
  validates :title, length: { in: 5..100 }, uniqueness: true
  validates :body, presence: true
end
