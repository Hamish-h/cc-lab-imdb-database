require("pry")

require_relative("models/movie")
require_relative("models/star")
require_relative("models/casting")

Star.delete_all()
Movie.delete_all()

movie1 = Movie.new({
  "title" => "The Big Lebowski",
  "genre" => "Comedy",
  "rating" => 4,
  "budget" => 500_000
})
movie1.save()

movie2 = Movie.new({
  "title" => "2001: A Space Odyssey",
  "genre" => "Science Fiction",
  "rating" => 5,
  "budget" => 2_000_000
})
movie2.save()

star1 = Star.new({
  "first_name" => "Jeff",
  "last_name" => "Bridges",
  "fee" => 40_000
})
star1.save()

star2 = Star.new({
  "first_name" => "Keir",
  "last_name" => "Dullea",
  "fee" => 100_000
})
star2.save()

star3 = Star.new({
  "first_name" => "John",
  "last_name" => "Goodman",
  "fee" => 50_000
})
star3.save()

casting1 = Casting.new({
  "movie_id" => movie1.id,
  "star_id" => star1.id
})

casting1.save()

casting2 = Casting.new({
  "movie_id" => movie2.id,
  "star_id" => star2.id
})

casting2.save()

casting3 = Casting.new({
  "movie_id" => movie1.id,
  "star_id" => star3.id
})

casting3.save()


p movie1.profit()
p movie2.profit()

binding.pry
nil