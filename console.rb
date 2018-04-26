require("pry")

require_relative("models/movie")
require_relative("models/star")
require_relative("models/casting")

Star.delete_all()
Movie.delete_all()

movie1 = Movie.new({
  "title" => "The Big Lebowski",
  "genre" => "Comedy",
  "rating" => 4
})
movie1.save()

movie2 = Movie.new({
  "title" => "2001: A Space Odyssey",
  "genre" => "Science Fiction",
  "rating" => 5
})
movie2.save()

star1 = Star.new({
  "first_name" => "Jeff",
  "last_name" => "Bridges"
})
star1.save()

star2 = Star.new({
  "first_name" => "Keir",
  "last_name" => "Dullea"
})
star2.save()

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

binding.pry
nil