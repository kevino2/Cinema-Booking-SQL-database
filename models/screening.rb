require_relative('../db/sql_runner.rb')
require_relative('../models/film.rb')

class Screening

attr_accessor :showtime, :film_id, :full_capacity
attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @showtime = options['showtime']
    @film_id = options['film_id'].to_i
    @full_capacity = options['full_capacity'].to_i
  end

  def save()
    sql = "INSERT INTO screenings
           (showtime, film_id, full_capacity)
           VALUES
           ($1, $2, $3)
           RETURNING id"
    values = [@showtime, @film_id, @full_capacity]
    @id = SqlRunner.run(sql, values)[0]['id']
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    all_screening = SqlRunner.run(sql)
    return Screening.map_items(all_screening)
  end

  def update()
    sql = "UPDATE screenings
           SET (showtime, film_id, full_capacity) = ($1, $2, $3)
           WHERE id = $4"
    values = [@showtime, @film_id, @full_capacity, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM screenings
           WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end
end
