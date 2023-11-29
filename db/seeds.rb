Booking.destroy_all
Service.destroy_all
Category.destroy_all
User.destroy_all

users_data = [
  { first_name: 'John', last_name: 'Smith', balance: 100, description: 'professionnel', city: 'Paris', email: 'john@smith.com', password: '123456' },
  { first_name: 'Jane', last_name: 'Doe', balance: 200, description: 'talentueux', city: 'Evry', email: 'jane@doe.com', password: '123456' },
  { first_name: 'Bob', last_name: 'Dylan', balance: 400, description: 'professionnel', city: 'Nantes', email: 'bob@dylan.com', password: '123456' },
  { first_name: 'Lois', last_name: 'Sanders', balance: 150, description: 'talentueux', city: 'Lyon', email: 'lois@sanders.com', password: '123456' },
  { first_name: 'Pierre', last_name: 'Cardoe', balance: 300, description: 'professionnel', city: 'Lille', email: 'pierre@cardoe.com', password: '123456' },
  { first_name: 'Pearce', last_name: 'Lover', balance: 250, description: 'talentueux', city: 'Toulouse', email: 'pearce@lover.com', password: '123456' }
]

users = users_data.map { |user_data| User.create!(user_data) }

categories_data = [
                    { name: 'Mécanique', price: 100 },
                    { name: 'Informatique', price: 140 },
                    { name: 'Bricolage', price: 105 },
                    { name: 'Jardinage', price: 110 },
                    { name: 'Ménage', price: 100 },
                    { name: 'Sport', price: 120 },
                    { name: 'Cuisine', price: 115 },
                    { name: 'Transport', price: 130 }
                  ]

categories = categories_data.map { |category_data| Category.create!(category_data) }

users.each do |user|
  selected_categories = categories.sample(rand(1..4))
  selected_categories.each do |category|
    Service.create!(
      user: user,
      category: category
    )
  end
end