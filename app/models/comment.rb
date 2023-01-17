class Comment < ApplicationRecord
  belongs_to :author, class_name: "User", counter_cache: true
  belongs_to :photo, counter_cache: true
  validates :body, presence: true
end
