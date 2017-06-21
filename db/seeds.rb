User.create(user_name: "ngoctrunght19",
  email: "ngoctrunght19@gmail.com",
  full_name: "Nguyen Ngoc Trung",
  password: "trung123",
  admin: true)

9.times do |i|
  user_name = "example" + (i+1).to_s
  email = "example" + (i+1).to_s + "@gmail.com"
  full_name = "Nguyen Ngoc Trung" + (i+1).to_s
  User.create(user_name: user_name,
    email: email,
    full_name: full_name,
    password: "trung123")
end
