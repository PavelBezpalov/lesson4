class Post < ActiveRecord::Base
  belongs_to :user

  validates :title, length: { in: 5..100 }, uniqueness: true
  validates :body, presence: true
end
