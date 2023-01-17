class FollowRequest < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :sender, class_name: "User"

  validates :recipient_id, uniqueness: { scope: :sender_id, message: "already followed" }

  # ActiveRecord::Enum, which will give us a bunch of handy querying and other methods for free:
  # for 'status' field of table:
  enum status: { pending: "pending", rejected: "rejected", accepted: "accepted" }
#   # assume follow_request is a valid and pending
# follow_request.accepted? # => false
# follow_request.accepted! # sets status to "accepted" and saves
# We also get automatic positive and negative scopes:

# FollowRequest.accepted
# current_user.received_follow_requests.not_rejected
scope :accepted, -> { where(status: "accepted" ) }
scope :not_accepted, -> { where.not(status: "accepted" ) }

end
