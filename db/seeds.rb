if Rails.env.development?
  5.times do
    Category.create!(name: Faker::Commerce.department)
  end
  categories = Category.all

  10.times do
    User.create!(email: Faker::Internet.email,
                 password: Faker::Internet.password,
                 name: Faker::Name.name)
  end
  users = User.all

  users.take(5).each do |user|
    Seller.create!(user: user,
                   confirmed: [true, false].sample)
  end
  sellers = Seller.all
  confirmed_sellers = Seller.where(confirmed: true)
  confirmed_seller_users = confirmed_sellers.map{ |seller| seller.user }

  20.times do
    Listing.create!(name: Faker::Commerce.product_name,
                    description: Faker::Lorem.paragraph,
                    price: Faker::Commerce.price,
                    user: confirmed_seller_users.sample,
                    category: categories.sample,
                    image: Rails.root.join("app/assets/images/favicon.png").open)
  end
  listings = Listing.all

  20.times do
    Order.create!(address: Faker::Address.street_address,
                  city: Faker::Address.city,
                  state: Faker::Address.state,
                  listing: listings.sample,
                  buyer: users.sample,
                  seller: confirmed_seller_users.sample)
  end
  orders = Order.all

  User.create!(email: 'admin@example.com',
               password: '12345678',
               name: 'Admin',
               role: 'admin')
  users = User.all

  [Category, User, Seller, Listing, Order].each do |model|
    puts "#{model}: #{model.count}"
  end
end
