# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
    
    #Seed DB with at least 1 Admin User
    admin=User.new({ name: "Austin Ogilvie", email: 'admin@rubystash.com',
               password: 'password', password_confirmation: 'password'})
    
    admin.toggle!(:admin)
    
    if admin.valid?
      admin.save()

    elsif admin.errors.any?
      admin.errors.full_messages.each do |msg|
        puts msg
      end
    else
      puts "****NOT VALID****"
    end