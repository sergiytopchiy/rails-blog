class Article < ActiveRecord::Base
  include BelongsToUser
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
end
