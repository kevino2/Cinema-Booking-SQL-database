require_relative('../db/sql_runner.rb')
class Film
  attr_accessor :title, :price
  attr_reader :id
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
 end

  def save
    sql = "INSERT INTO films (title, price)
            VALUES ($1, $2)
            RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values)[0]
    @id = film['id'].to_i
  end

  def self.all()
   sql = "SELECT * FROM films"
   result = SqlRunner.run (sql)
   return result.map { |film| Film.new(film)}
  end

  def self.delete_all()
   sql = "DELETE FROM films"
   values = []
   SqlRunner.run (sql)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE films
          SET (title, price)
          = ($1, $2)
          WHERE id = $3"
   values = [@title, @price, @id]
   SqlRunner.run(sql, values)
  end

  def customer_film_views()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON tickets.customer_id = customers.id WHERE film_id = $1"
    values = [@id]
    customers = SqlRunner.run(sql, values).first
    return customers.map { |cust| customers
      Customer.new(cust) }
    end


end
