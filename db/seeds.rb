# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.new(
    :email                 => "huuhoangcu@gmail.com",
    :username              => "huuhoangcu",
    :full_name             => "Cù Hữu Hoàng",
    :role                  => 2,
    :is_admin              => true,
    :password              => "48342817",
    :password_confirmation => "48342817"
)
user.skip_confirmation!
user.save!