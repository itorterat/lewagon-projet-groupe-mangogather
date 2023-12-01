require "open-uri"
Booking.destroy_all
Service.destroy_all
Category.destroy_all
User.destroy_all

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

first_names = [
  "Rym", "Yaya", "Lilian", "Irvin",
  "John", "Jane", "Bob", "Alice", "Marc", "Laura", "Maxime", "Sophie", "Pierre",
  "Marie", "Antoine", "Clara", "Julien", "Charlotte", "Thomas", "Camille",
  "Lucas", "Émilie", "Louis", "Anaïs", "Arthur", "Léa", "Jules", "Juliette",
  "Gabriel", "Zoé", "Raphaël", "Lola", "Alexandre", "Inès", "Paul", "Manon",
  "Hugo", "Sarah", "Mathis", "Elisa", "Enzo", "Chloé", "Théo", "Eva",
  "Patrick", "Cécile", "Nicolas", "Léna", "Guillaume", "Adrien"
]

last_names = [
  "Badji", "Niang", "Annette", "Torterat",
  "Smith", "Doe", "Brown", "White", "Martin", "Davis", "Leroy", "Moreau", "Petit",
  "Durand", "Lefebvre", "Garcia", "Dupont", "Simon", "Michel", "Bernard",
  "Roux", "Vincent", "Fournier", "Morel", "Girard", "Andre", "Lefevre", "Mercier",
  "Dupuis", "Lambert", "Bonnet", "Francois", "Martinez", "Legrand", "Garnier",
  "Faure", "Rousseau", "Blanc", "Guerin", "Muller", "Henry", "Roussel", "Nicolas",
  "Perrin", "Morin", "Mathieu", "Clement", "Gauthier", "Dumont", "Lopez"
]

cities = [
  "Paris", "Versailles", "Nanterre", "Suresnes", "Meudon",
  "Evry", "Orly", "Lyon", "Marseille", "Toulouse",
  "Nice", "Nantes", "Strasbourg", "Montpellier", "Bordeaux",
  "Lille", "Rennes", "Reims", "Dijon", "Toulon"
]

descriptions = ["professionnel", "talentueux"]

users = []

puts "Creating users..."
first_names.each_with_index do |first_name, index|
  print "U#{index + 1} / "
  fn = first_name
  ln = last_names[index]
  full_email = "#{fn.downcase}@#{ln.downcase}.com"

  user_data = {
    first_name: fn,
    last_name: ln,
    balance: rand(800..1500),
    description: descriptions.sample,
    city: cities.sample,
    email: full_email,
    password: "123456"
  }
  u = User.new(user_data)
  if rand(1..4) > 1
    u.photo.attach(io: URI.open(Faker::Avatar.image), filename: 'photo.jpg', content_type: 'image/jpeg')
  end
  users << u.save!
end
puts "Finished creating users!\n"

puts "\nCreating services..."
User.all.each do |user|
  print "U#{user.id} - "
  selected_categories = Category.all.sample(rand(0..5))
  selected_categories.each do |category|
    Service.create!(user: user, category: category)
  end
  print "S#{selected_categories.count} / "
end
puts "Finished creating services!\n"
