require_relative('../db/sql_runner.rb')
class Customer
attr_accessor :name, :funds
attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
 end

  def save
    sql = "INSERT INTO customers (name, funds)
            VALUES ($1, $2)
            RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values)[0]
    @id = customer['id'].to_i
   end

   def self.all()
    sql = "SELECT * FROM customers"
    result = SqlRunner.run(sql)
    return result.map { |customer| Customer.new(customer)}
   end

   def update()
     sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
   end

   def self.delete_all()
     sql = "DELETE FROM customers"
     values = []
     SqlRunner.run(sql)
   end

   def delete()
     sql = "DELETE FROM customers WHERE id = $1"
     values = [@id]
     SqlRunner.run(sql, values)
   end

   def buy_ticket(film)
     unless @funds < film.price
       @funds -= film.price
       update()
     end
   end

   def films_viewed_by_customer()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON tickets.film_id = films.id WHERE customer_id = $1"
    values = [@id]
    films_viewed = SqlRunner.run(sql, values)
    return films_viewed.map { |film| Film.new(film) }
  end


end
