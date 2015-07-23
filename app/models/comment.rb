class Comment < ActiveRecord::Base
  include BelongsToUser
  belongs_to :article
end
