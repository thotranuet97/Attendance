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

User.all.each do |user|
  10.times do |i|
    date = "2017-06-0" + (i+1).to_s
    Attendance.create(user_id: user.id,
      date: date,
      time_in: "8:01:32",
      time_out: "16:43:12")
  end
end

User.all.each do |user|
  10.times do |i|
    date = "2017-05-0" + (i+1).to_s
    Attendance.create(user_id: user.id,
      date: date,
      time_in: "8:01:32",
      time_out: "16:43:12")
  end
end
