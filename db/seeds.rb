# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
images = {
    camera: ["camera_1.png", "camera_2.jpg"],
    lens: ["lens_1.jpg", "lens_2.jpg"],
    accessory: ["accessory_1.jpg","accessory_2.jpg","accessory_3.jpg"]
}

# users = [
#     "abc@email.com",
#     "pqr@email.com",
#     "xyz@email.com"
# ];

# for i in 1..15
#     users << Faker::Internet.email
# end

# for u in users
#     user = User.create(email: u, password: "123456")
#     p "created user #{user.id}"
#     profile = user.create_profile(name: u.split("@")[0], phone: "0466123456", location: "sydney")
#     p "created profile #{profile.id}"
#     image_path = "#{Rails.root.join('db/seed_images/')}profile_#{Faker::Number.within(range: 1..4)}.jpg"
#     filename = "#{profile.name.sub(" ", "_")}.jpg"
#     profile.picture.attach(io: File.open(image_path), filename: filename, content_type: "image/jpg")
#     p "attached image #{image_path} for #{profile.id}"
# end

for i in 1..48
    listing = Listing.create(
        title: Faker::Lorem.sentence(word_count: 10),
        description: Faker::Lorem.paragraphs(number: 3),
        brand: Faker::Lorem.word,
        model: Faker::Lorem.word,
        rate: Faker::Number.within(range: 1..50),
        category: Faker::Number.within(range: 0..2),
        profile_id: Faker::Number.within(range: 1..18),
    )
    p "created listing #{listing.id}"
    image_files = images[listing.category.to_sym]
    image_file = image_files[Faker::Number.within(range: 0...image_files.length)]
    image_path = "#{Rails.root.join('db/seed_images/')}#{image_file}"
    filename = "listing_#{listing.id}"
    listing.image1.attach(io: File.open(image_path), filename: filename)
    p "attached image #{image_path} to listing #{listing.id}"
end
