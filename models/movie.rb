require_relative("../db/sql_runner")

class Movie
  attr_accessor :title, :genre, :rating
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @genre = options["genre"]
    @rating = options["rating"].to_i
  end

  def stars()
    sql = "SELECT stars.* FROM stars
      INNER JOIN castings
      ON castings.star_id = stars.id
      WHERE castings.movie_id = $1;"
    values = [@id]
    stars_hashes = SqlRunner.run(sql, values)
    return Star.map_items(stars_hashes)
  end

  def save()
    sql = "INSERT INTO movies (title, genre, rating) values ($1, $2, $3) RETURNING id"
    values = [@title, @genre, @rating]
    movie = SqlRunner.run(sql, values).first()
    @id = movie["id"].to_i
  end

  def update()
    sql = "UPDATE movies SET (title, genre, rating) = ($1, $2, $3) WHERE id = $4"
    values = [@title, @genre, @rating, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM movies WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.map_items(items)
    items.map { |item| self.new(item)}
  end

  def self.delete_all()
    sql = "DELETE FROM movies;"
    SqlRunner.run(sql)
  end
end
