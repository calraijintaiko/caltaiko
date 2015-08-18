require 'faker'

# This file should contain all the record creation needed to seed the database
# with its default values. The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).

# User Account
User.create(email: 'admin@example.com',
            username: 'admin',
            password: 'secret',
            password_confirmation: 'secret')

# Members
(Time.new.year - 2005).times do |gen|
  rand(7..11).times do
    Member.create(name: Faker::Name.name,
                  gen: gen + 1,
                  major: Faker::Commerce.department,
                  current: gen > Time.new.year - 2009,
                  email: Faker::Internet.email,
                  bio: Faker::Lorem.paragraph(5))
  end
end

# Past Performances
(2005...Time.new.year).each do |year|
  rand(2..10).times do
    Performance.create(title: Faker::Book.title,
                       date: Faker::Time.between(Time.new(year, 1, 1),
                                                 Time.new(year, 12, 31)),
                       location: Faker::Address.street_address,
                       description: Faker::Lorem.paragraph(4),
                       images_link: Faker::Internet.url,
                       link: Faker::Internet.url)
  end
end

# Current Performances
rand(2..5).times do
  Performance.create(title: Faker::Book.title,
                     date: Faker::Time.between(Time.now,
                                               Time.now + 365.days),
                     location: Faker::Address.street_address,
                     description: Faker::Lorem.paragraph(4),
                     images_link: Faker::Internet.url,
                     link: Faker::Internet.url)
end

# Articles
rand(5..10).times do
  Article.create(title: Faker::Company.catch_phrase,
                 date: Faker::Time.between(Time.new(2006),
                                           Time.now),
                 current: [true, false].sample,
                 text: Faker::Lorem.paragraphs(rand(2..5)).join("\r\n\r\n"))
end

# Videos
(2005...Time.new.year).each do |year|
  rand(5).times do
    Video.create(title: Faker::Book.title,
                 link: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
                 year: year)
  end
end
