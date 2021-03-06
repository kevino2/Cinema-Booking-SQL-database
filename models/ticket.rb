require_relative('../db/sql_runner.rb')
require_relative('../models/customer.rb')
require_relative('../models/film.rb')

class Ticket
  attr_accessor :customer_id, :film_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end

  def save
    sql = "INSERT INTO tickets(customer_id, film_id)
           VALUES ($1, $2)
           RETURNING id"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values)[0]
    @id = ticket['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    results = SqlRunner.run(sql)
    return results.map { |ticket| Ticket.new(ticket)}
  end

  def self.delete_all()
   sql = "DELETE FROM tickets"
   values = []
   SqlRunner.run (sql)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
   sql = "UPDATE tickets SET (customer_id, film_id)
   VALUES ($1, $2) WHERE id = $3"
   values = [@customer_id, @film_id, @id]
   SqlRunner.run(sql, values)
  end

  # def total_tickets()
  #   sql = "SELECT COUNT.* FROM tickets
  #     WHERE tickets.customer_id = $1"
  #   values = [@id]


end
