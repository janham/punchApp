=begin
User.create!(name:  "Admin User",
             email: "admin@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)
=end

Displaydate.create(list_date: Time.new)