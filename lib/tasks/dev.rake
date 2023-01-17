# terminal command to run: rails sample_data

task sample_data: :environment do
  p "Creating sample data"

  starting = Time.now

  if Rails.env.development?
    FollowRequest.destroy_all
    Comment.delete_all
    Like.delete_all
    Photo.delete_all
    User.destroy_all
  end

  12.times do 
    # p Faker::Name.name
    name = Faker::Name.first_name.downcase
    u = User.create(
      email: "#{name}@example.com",
      password: "password",
      username: name,
      private: [true, false].sample,
    )
    # to find errors:
    # p u.errors.full_messages
  end
  p "#{User.count} users have been created"

  users = User.all
  users.each do |user|
    users.each do |second_user|
      if rand < 0.75
        user.sent_follow_requests.create(
          recipient: second_user,
          # status: ["pending", "accepted", "rejected"].sample
          status: FollowRequest.statuses.keys.sample
        )
      end

      if rand < 0.75
        second_user.sent_follow_requests.create(
          recipient: user,
          status: FollowRequest.statuses.values.sample
        )
      end

    end
  end
  p "#{FollowRequest.count} follow requests have been created"

  users.each do |user|
    rand(15).times do
      photo = user.own_photos.create(
        caption: Faker::Quote.jack_handey,
        image: "https://robohash.org/#{rand(9999)}"
      )

      user.followers.each do |follower|
        if rand < 0.5
          photo.fans << follower
        end

        if rand < 0.25
          photo.comments.create(
            body: Faker::Quote.jack_handey,
            author: follower
          )
        end
      end
    end
  end

  ending = Time.now
  p "It took #{(ending - starting).to_i} seconds to create sample data."
  p "There are now #{User.count} users."
  p "There are now #{FollowRequest.count} follow requests."
  p "There are now #{Photo.count} photos."
  p "There are now #{Like.count} likes."
  p "There are now #{Comment.count} comments."

end
