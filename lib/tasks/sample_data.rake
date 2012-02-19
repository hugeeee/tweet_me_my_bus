namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Hugo",
                         :email => "hugokinghall@gmail.com",
													:twitter => "@hugorobert17",
                         :password => "foobar",
                         :password_confirmation => "foobar")
	

  	  admin.toggle!(:admin)
		end
=begin	
    1.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
									:twitter => "@general#{n+1}",
                   :password => password,
                   :password_confirmation => password)
    end
=end
end

