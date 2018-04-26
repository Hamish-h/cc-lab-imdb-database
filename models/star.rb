require_relative("../db/sql_runner")

class Star
  attr_accessor :first_name, :last_name, :fee
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @first_name = options["first_name"]
    @last_name = options["last_name"]
    @fee = options["fee"].to_i
  end

  def movies()
    sql = "SELECT movies.* FROM movies
      INNER JOIN castings
      ON castings.movie_id = movies.id
      WHERE castings.star_id = $1;"
    values = [@id]
    movies_hashes = SqlRunner.run(sql, values)
    return Movie.map_items(movies_hashes)
  end

  def save()
    sql = "INSERT INTO stars (first_name, last_name, fee) values ($1, $2, $3) RETURNING id"
    values = [@first_name, @last_name, @fee]
    star = SqlRunner.run(sql, values).first()
    @id = star["id"].to_i
  end

  def update()
    sql = "UPDATE stars SET (first_name, last_name, fee) = ($1, $2, $3) WHERE id = $4"
    values = [@first_name, @last_name, @fee, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM stars WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.map_items(items)
    items.map { |item| self.new(item)}
  end

  def self.delete_all()
    sql = "DELETE FROM stars;"
    SqlRunner.run(sql)
  end
end
