
User.create!(name:  "管理アカウント",
             email: "admin@gmail.com",
             password:              "20181031",
             password_confirmation: "20181031",
             group: "0",
             admin: true)

User.create!(name:  "CEO",
             email: "ceo@gmail.com",
             password:              "ceoceo",
             password_confirmation: "ceoceo",
             group: "1")

User.create!(name:  "CFO",
             email: "cfo@gmail.com",
             password:              "cfocfo",
             password_confirmation: "cfocfo",
             group: "1")

User.create!(name:  "COO",
             email: "coo@gmail.com",
             password:              "coocoo",
             password_confirmation: "coocoo",
             group: "1")

User.create!(name:  "かんがえうさぎ",
             email: "kangae@gmail.com",
             password:              "kangae",
             password_confirmation: "kangae",
             group: "2")

User.create!(name:  "すばやうさぎ",
             email: "subaya@gmail.com",
             password:              "subaya",
             password_confirmation: "subaya",
             group: "3")

User.create!(name:  "てきぱきうさぎ",
             email: "tekipaki@gmail.com",
             password:              "tekipaki",
             password_confirmation: "tekipaki",
             group: "3")
             
Post.create!(content: "Me deja postear!",
             user_id: "1")

Displaydate.create!(list_date: Time.new)