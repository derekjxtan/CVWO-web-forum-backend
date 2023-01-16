# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# create users
user1 = User.create(username: "user1", password: "user1")
user2 = User.create(username: "user2", password: "user2")
user3 = User.create(username: "user3", password: "user3")

# create posts
post1 = Post.create(title: "u1p1 title", body: "u1p1 body", user_id: user1.id, categories: ["fun", "action"])
# post1 = Post.create(title: "u1p1 title", user_id: user1.id)
post2 = Post.create(title: "u1p2 title", body: "u1p2 body", user_id: user1.id, categories: ["fun", "cooking"])
post3 = Post.create(title: "u2p1 title", body: "u2p1 body", user_id: user2.id, categories: ["games", "fun"])
post4 = Post.create(title: "u1p3 title", body: "u1p3 body", user_id: user1.id, categories: ["action", "cooking"])

# create replies
reply1 = Reply.create(body: "u2p1r1", user_id: user2.id, post_id: post1.id, reply_id: nil)
reply2 = Reply.create(body: "u3p1r2", user_id: user3.id, post_id: post1.id, reply_id: nil)
reply3 = Reply.create(body: "u2p2r1", user_id: user2.id, post_id: post2.id, reply_id: nil)
reply4 = Reply.create(body: "u2p2r2", user_id: user2.id, post_id: post2.id, reply_id: nil)
reply5 = Reply.create(body: "u3p2r3", user_id: user3.id, post_id: post2.id, reply_id: nil)
reply6 = Reply.create(body: "u1p1r1", user_id: user1.id, post_id: post3.id, reply_id: nil)

# create subreplies
subreply1 = Reply.create(body: "u1p1r1s1", user_id: user1.id, post_id: post1.id, reply_id: reply1.id)
subreply2 = Reply.create(body: "u2p1r1s2", user_id: user2.id, post_id: post1.id, reply_id: reply1.id)
subreply3 = Reply.create(body: "u3p2r1s1", user_id: user3.id, post_id: post2.id, reply_id: reply3.id)

# # create liked posts
# LikedPost.create(user_id: user2.id, post_id: post1.id)
# LikedPost.create(user_id: user3.id, post_id: post1.id)
# LikedPost.create(user_id: user3.id, post_id: post2.id)
# LikedPost.create(user_id: user1.id, post_id: post3.id)
# LikedPost.create(user_id: user3.id, post_id: post3.id)

# # create saved posts
# SavedPost.create(user_id: user2.id, post_id: post1.id)
# SavedPost.create(user_id: user3.id, post_id: post4.id)
# SavedPost.create(user_id: user1.id, post_id: post3.id)