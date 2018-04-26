class Casting
  attr_accessor :movie_id, :star_id
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @movie_id = options["movie_id"].to_i
    @star_id = options["star_id"].to_i
  end

  def save()
    sql = "INSERT INTO castings (movie_id, star_id) values ($1, $2) RETURNING id"
    values = [@movie_id, @star_id]
    casting = SqlRunner.run(sql, values).first()
    @id = casting["id"].to_i
  end

  def delete()
    sql = "DELETE FROM castings WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM castings;"
    SqlRunner.run(sql)
  end
end
