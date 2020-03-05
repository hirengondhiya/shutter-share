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
];
for i in 1..15
    users << Faker::Internet.email
end
for u in users
    user = User.create(email: u, password: "123456")
    p = user.create_profile(name: u.split("@")[0], phone: "0466123456", location: "sydney")
    # image_path = "seed_images/profile_#{Faker::Number.within(range: 1..4)}.jpg"
    # filename = "#{p.name}.jpg"

    # p.picture.attach(io: File.open(image_path, filename: filename, content_type: "image/jpeg")
end

for i in 1..50
    l = Listing.create(
        title: Faker::Lorem.sentence(word_count: 10),
        description: Faker::Lorem.paragraphs(number: 3),
        brand: Faker::Lorem.word,
        model: Faker::Lorem.word,
        rate: Faker::Number.within(range: 1..50),
        category: Faker::Number.within(range: 0..2),
        profile_id: Faker::Number.within(range: 1..users.length),
    )
end