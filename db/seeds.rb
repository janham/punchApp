=begin
User.create!(name:  "管理人",
             email: "admin@gmail.com",
             password:              "20181031",
             password_confirmation: "20181031",
             admin: true)
=end

#Displaydate.create(list_date: Time.new)

Post.create(content: "Me deja postear!",
            user_id: 1)