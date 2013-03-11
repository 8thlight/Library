require 'faker'

namespace :db do
  desc "Populate the database with samples"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke

    100.times do |n|
      displayname = Faker::Name.name
      email = "test-#{n+1}@test.org"
      test_user = User.create!(:name => displayname,
                               :email => email)
    end
  end
end
