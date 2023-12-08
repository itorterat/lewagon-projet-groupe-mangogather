require "open-uri"
Message.destroy_all
Conversation.destroy_all
Review.destroy_all
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

puts "\nCreating categories...\n"
categories = categories_data.map { |category_data| Category.create!(category_data) }
puts "Finished creating categories!\n"

puts "\nAdding images to categories...\n"
Category.find_by(name: 'Mécanique').photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'mecanique.png')), filename: 'mecanique.png')
Category.find_by(name: 'Informatique').photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'informatique.png')), filename: 'informatique.png')
Category.find_by(name: 'Bricolage').photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'bricolage.png')), filename: 'bricolage.png')
Category.find_by(name: 'Jardinage').photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'jardinage.png')), filename: 'jardinage.png')
Category.find_by(name: 'Ménage').photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'menage.png')), filename: 'menage.png')
Category.find_by(name: 'Sport').photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'sport.png')), filename: 'sport.png')
Category.find_by(name: 'Cuisine').photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'cuisine.png')), filename: 'cuisine.png')
Category.find_by(name: 'Transport').photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'transport.png')), filename: 'transport.png')
puts "\nFinished adding images to categories!\n"

first_names = [
  "John", "Jane", "Bob", "Alice", "Marc", "Laura", "Maxime", "Sophie", "Pierre",
  "Marie", "Antoine", "Clara", "Julien", "Charlotte", "Thomas", "Camille",
  "Lucas", "Émilie", "Louis", "Anaïs", "Arthur", "Léa", "Jules", "Juliette",
  "Gabriel", "Zoé", "Raphaël", "Lola", "Alexandre", "Inès", "Paul", "Manon",
  "Hugo", "Sarah", "Mathis", "Elisa", "Enzo", "Chloé", "Théo", "Eva",
  "Patrick", "Cécile", "Nicolas", "Léna", "Guillaume", "Adrien"
]

last_names = [
  "Smithy", "Doe", "Brown", "White", "Martin", "Davis", "Leroy", "Moreau", "Petit",
  "Durand", "Lefebvre", "Garcia", "Dupont", "Simon", "Michel", "Bernard",
  "Roux", "Vincent", "Fournier", "Morel", "Girard", "Andre", "Lefevre", "Mercier",
  "Dupuis", "Lambert", "Bonnet", "Francois", "Martinez", "Legrand", "Garnier",
  "Faure", "Rousseau", "Blanc", "Guerin", "Muller", "Henry", "Roussel", "Nicolas",
  "Perrin", "Morin", "Mathieu", "Clement", "Gauthier", "Dumont", "Lopez"
]

cities = [
  "Paris", "Versailles", "Nanterre", "Suresnes", "Meudon",
  "Évry", "Orly", "Lyon", "Marseille", "Toulouse",
  "Nice", "Nantes", "Strasbourg", "Montpellier", "Bordeaux",
  "Lille", "Rennes", "Reims", "Dijon", "Toulon"
]

descriptions = ["professionnel", "talentueux"]

puts "\nCreatings our pitch users...\n"
lilian = User.create!(
  first_name: "Lilian",
  last_name: "Annette",
  balance: rand(1000..2000),
  description: "Je suis quelqu'un de très sportif et j'aime aider les gens. Je suis également très à l'aise en mécanique (voitures et motos) !",
  city: "Paris",
  email: "lilian@annette.com",
  password: "123456"
)

lilian.photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'lilian.png')), filename: 'lilian.png')
lilian_sport = Service.create!(user: lilian, category: Category.find_by(name: 'Sport'))
lilian_meca = Service.create!(user: lilian, category: Category.find_by(name: 'Mécanique'))

rym = User.create!(
  first_name: "Rym",
  last_name: "Badji",
  balance: rand(1000..2000),
  description: "Passionnée d'informatique et grande cuisinière, je serais ravie de vous donner un coup de main !",
  city: "Paris",
  email: "rym@badji.com",
  password: "123456"
)

rym.photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'rym.png')), filename: 'rym.png')
rym_info = Service.create!(user: rym, category: Category.find_by(name: 'Informatique'))
rym_cook = Service.create!(user: rym, category: Category.find_by(name: 'Cuisine'))

yaya = User.create!(
  first_name: "Yaya",
  last_name: "Niang",
  balance: rand(1000..2000),
  description: "J'adorerais vous aider dans vos projets de bricolage, et je peux aider en informatique si besoin !",
  city: "Paris",
  email: "yaya@niang.com",
  password: "123456"
)

yaya.photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'yaya.png')), filename: 'yaya.png')
Service.create!(user: yaya, category: Category.find_by(name: 'Bricolage'))
yaya_info = Service.create!(user: yaya, category: Category.find_by(name: 'Informatique'))

irvin = User.create!(
  first_name: "Irvin",
  last_name: "Torterat",
  balance: rand(1000..2000),
  description: "J'ADORE le bricolage, le ménage, le jardinage et l'informatique ! LAISSEZ moi vous aider !",
  city: "Paris",
  email: "irvin@torterat.com",
  password: "123456"
)

irvin.photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'irvin.png')), filename: 'irvin.png')
Service.create!(user: irvin, category: Category.find_by(name: 'Bricolage'))
Service.create!(user: irvin, category: Category.find_by(name: 'Ménage'))
irvin_jardinage = Service.create!(user: irvin, category: Category.find_by(name: 'Jardinage'))
irvin_info = Service.create!(user: irvin, category: Category.find_by(name: 'Informatique'))

ken = User.create!(
  first_name: "Ken",
  last_name: "Juste",
  balance: rand(1000..2000),
  description: "Slt tt le monde moi c JUSTE Ken et jvais vou aidér! G grave de l'esspérience dan tout en fait ;) ;) ;)",
  city: "Paris",
  email: "ken@juste.com",
  password: "123456"
)

ken.photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'ken.png')), filename: 'irvin.png')
Service.create!(user: ken, category: Category.find_by(name: 'Bricolage'))
Service.create!(user: ken, category: Category.find_by(name: 'Ménage'))
Service.create!(user: ken, category: Category.find_by(name: 'Jardinage'))
Service.create!(user: ken, category: Category.find_by(name: 'Informatique'))
Service.create!(user: ken, category: Category.find_by(name: 'Transport'))
Service.create!(user: ken, category: Category.find_by(name: 'Cuisine'))
puts "\nFinished creating our pitch users!\n"

users = []

puts "\nCreating users...\n"
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
  u.save!
  users << u
end
puts "\nFinished creating users!\n"

puts "\nCreating services..."
puts users
users.each do |user|
  print "U#{user.id} - "
  selected_categories = Category.all.sample(rand(0..5))
  selected_categories.each do |category|
    Service.create!(user: user, category: category)
  end
  print "S#{selected_categories.count} / "
end
puts "\nFinished creating services!\n"

random_user = users.sample
Conversation.create!(sender: lilian, recipient: random_user)
Message.create!(content: "Merci pour la dernière fois", author: random_user, receiver: lilian, conversation: Conversation.last, created_at: DateTime.new(2023, 12, 1, 9, 14))

Conversation.create!(sender: lilian, recipient: irvin)
Message.create!(content: "Pas de souci, on fera ça ensemble la prochaine fois!", author: lilian, receiver: irvin, conversation: Conversation.last, created_at: DateTime.new(2023, 11, 21, 22, 0))
Conversation.create!(sender: lilian, recipient: yaya)
Message.create!(content: "A la prochaine ! Merci encore :)", author: yaya, receiver: lilian, conversation: Conversation.last, created_at: DateTime.new(2023, 11, 25, 18, 0))
Conversation.create!(sender: lilian, recipient: ken)
Message.create!(content: "SLT LILIAN SA TE DIS DE FAIRRE DU SPOR AVEC MOI ???", author: ken, receiver: lilian, conversation: Conversation.last, created_at: DateTime.new(2023, 12, 07, 22, 0))

# LILIAN
Booking.create!(author: irvin, service: lilian_sport, date: DateTime.new(2023, 11, 22, 15, 45), created_at: DateTime.new(2023, 11, 21, 21, 9), difficulty: "easy", status: "approved", price: 180)
Booking.create!(author: yaya, service: lilian_meca, date: DateTime.new(2023, 11, 29, 9, 0), created_at: DateTime.new(2023, 11, 22, 12, 5),difficulty: "normal", status: "declined", price: 140)

random_user = users.sample
Booking.create!(author: random_user, service: lilian_meca, date: DateTime.new(2023, 12, 8, 13, 0), created_at: DateTime.new(2023, 12, 1, 9, 14), difficulty: "hard", status: "pending", price: 160)


Booking.create!(author: lilian, service: yaya_info, date: DateTime.new(2023, 11, 24, 18, 0), created_at: DateTime.new(2023, 11, 21, 10, 23), difficulty: "normal", status: "approved", price: 200)
Review.create!(author: lilian, booking: Booking.last, comment: "Super service !", rating: 5)

Booking.create!(author: lilian, service: irvin_jardinage, date: DateTime.new(2023, 11, 28, 10, 0), created_at: DateTime.new(2023, 11, 25, 12, 54), difficulty: "hard", status: "declined", price: 210)

# RYM
Booking.create!(author: irvin, service: rym_info, date: DateTime.new(2023, 11, 24, 18, 0), created_at: DateTime.new(2023, 11, 21, 10, 23), difficulty: "normal", status: "approved", price: 200)
Review.create!(author: irvin, booking: Booking.last, comment: "Trop cool ! Service incroyable!", rating: 5, created_at: DateTime.new(2023, 10, 25, 9, 54))

Booking.create!(author: yaya, service: rym_cook, date: DateTime.new(2023, 11, 24, 18, 0), created_at: DateTime.new(2023, 11, 21, 10, 23), difficulty: "hard", status: "approved", price: 300)
Review.create!(author: yaya, booking: Booking.last, comment: "Le plat qu'on a réalisé était succulent !", rating: 5, created_at: DateTime.new(2023, 11, 5, 12, 12))

random_user = users.sample
Booking.create!(author: random_user, service: rym_info, date: DateTime.new(2023, 11, 24, 18, 0), created_at: DateTime.new(2023, 11, 21, 10, 23), difficulty: "normal", status: "approved", price: 300)
Review.create!(author: random_user, booking: Booking.last, comment: "Elle m'a bien aidé sur mon projet", rating: 4, created_at: DateTime.new(2023, 11, 17, 15, 9))

random_user = users.sample
Booking.create!(author: random_user, service: rym_info, date: DateTime.new(2023, 11, 24, 18, 0), created_at: DateTime.new(2023, 11, 21, 10, 23), difficulty: "easy", status: "approved", price: 300)
Review.create!(author: random_user, booking: Booking.last, comment: "Parfait", rating: 5, created_at: DateTime.new(2023, 11, 25, 11, 18))

Booking.create!(author: irvin, service: rym_cook, date: DateTime.new(2023, 11, 24, 18, 0), created_at: DateTime.new(2023, 11, 21, 10, 23), difficulty: "hard", status: "approved", price: 300)
Review.create!(author: irvin, booking: Booking.last, comment: "Quelle chef!", rating: 5, created_at: DateTime.new(2023, 11, 30, 2, 49))

random_user = users.sample
Booking.create!(author: random_user, service: rym_info, date: DateTime.new(2023, 11, 24, 18, 0), created_at: DateTime.new(2023, 11, 21, 10, 23), difficulty: "hard", status: "approved", price: 300)
Review.create!(author: random_user, booking: Booking.last, comment: "Merci beaucoup", rating: 5, created_at: DateTime.new(2023, 12, 04, 13, 33))

# KEN
Booking.create!(author: irvin, service: ken.services.sample, date: DateTime.new(2023, 11, 24, 18, 0), created_at: DateTime.new(2023, 11, 21, 10, 23), difficulty: "normal", status: "approved", price: 200)
Review.create!(author: irvin, booking: Booking.last, comment: "Vraiment pitoyable, ne faites pas appel à lui", rating: 0, created_at: DateTime.new(2023, 9, 15, 9, 24))

Booking.create!(author: yaya, service: ken.services.sample, date: DateTime.new(2023, 11, 24, 18, 0), created_at: DateTime.new(2023, 11, 21, 10, 23), difficulty: "easy", status: "approved", price: 300)
Review.create!(author: yaya, booking: Booking.last, comment: "Il n'est pas même pas venu au rendez-vous", rating: 0, created_at: DateTime.new(2023, 10, 5, 1, 9))

Booking.create!(author: rym, service: ken.services.sample, date: DateTime.new(2023, 11, 24, 18, 0), created_at: DateTime.new(2023, 11, 21, 10, 23), difficulty: "hard", status: "approved", price: 300)
Review.create!(author: rym, booking: Booking.last, comment: "Ken pense savoir tout faire, mais ne sait rien faire. Je lui ai demandé de l'aide, c'est moi qui l'ai aidé.", rating: 0, created_at: DateTime.new(2023, 11, 17, 12, 19))

random_user = users.sample
Booking.create!(author: random_user, service: ken.services.sample, date: DateTime.new(2023, 11, 24, 18, 0), created_at: DateTime.new(2023, 11, 21, 10, 23), difficulty: "easy", status: "approved", price: 300)
Review.create!(author: random_user, booking: Booking.last, comment: "Pas fou, Ken est vraiment lourd...", rating: 1, created_at: DateTime.new(2023, 11, 22, 20, 1))

random_user = users.sample
Booking.create!(author: random_user, service: ken.services.sample, date: DateTime.new(2023, 11, 24, 18, 0), created_at: DateTime.new(2023, 11, 21, 10, 23), difficulty: "easy", status: "approved", price: 300)
Review.create!(author: random_user, booking: Booking.last, comment: "J'aurai du lire les avis précédents...", rating: 2, created_at: DateTime.new(2023, 12, 2, 23, 27))
