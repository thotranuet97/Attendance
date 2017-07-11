namespace :users do
  desc "TODO"
  task admin: :environment do
    User.create(user_name: "admin",
      email: "hocnt@saokhuee.com",
      full_name: "admin",
      password: Settings.default_password,
      admin: true)
  end

end
