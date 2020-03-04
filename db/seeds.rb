# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [
    "abc@email.com",
    "pqr@email.com",
    "xyz@email.com"
]

for u in users
    user = User.create(email: u, password: "123456")    
    p = user.create_profile(name: u.split("@")[0], phone: "0466123456", location: "sydney")
    # p.listings << Listing.create(title: )
end