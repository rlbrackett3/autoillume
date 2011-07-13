# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Daley', city: cities.first)

require 'ffaker'
require 'factory_girl'
require 'database_cleaner'

DatabaseCleaner[:active_record].strategy = :truncation

puts "CLEARING THE DATABASE!"
DatabaseCleaner.clean
puts "DATABASE CLEAN AS A WHISTLE!"

# create an Admin user
puts "Creating an Admin user."
default_admin = Admin.create(
  username: "testuser",
  email: "user@test.com",
  password: "foobar"
)
default_admin.save
puts "#{default_admin.username} successfully created!"

puts "Creating a draft post."
draft_post = default_admin.posts.create(
  title: 'Draft Post'#,
  # body: 'This is a draft post.'
)
draft_post.state = "draft"
draft_post.save
puts "Draft post created successfully."

puts "Creating a published post."
published_post = default_admin.posts.create(
  title: 'Published Post'#,
  # body: 'This is a published post.'
)
published_post.state = "published"
published_post.save

puts "Creating a Photo Section."
photo_section = published_post.photo_sections.create(
  position: 0
)
photo = photo_section.build_photo(
  title: "First image section."
)
# process the image with carrierwave
photo.image = File.open("#{Rails.root}/app/assets/images/rails.png")
photo.save
photo_section.save
puts "Photo Section created successfully."

puts "Creating a Text Section."
text_section = published_post.text_sections.create(
  body: "This is a text section. It is capible of being formatted with *textile*.\n\n
        h1. This should be a header.\n\n
        This should be a new paragraph.\n
        This should be a new line in this paragraph.",
  position: 1
)
puts "Text Section created successfully."
puts "Published post created successfully."

puts "THE DATABASE IS NOW FILLED WITH SAMPLE DATA!"