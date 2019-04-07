require('pry-byebug')
require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')
require_relative('models/screening.rb')

Customer.delete_all
Film.delete_all
Ticket.delete_all


film1 = Film.new ({'title' => 'Pulp Fiction', 'price' => 10})
film2 = Film.new ({'title' => 'Multi Marvel Movie Marathon', 'price' => 30})
film3 = Film.new ({'title' => 'Story of Ricky', 'price' => 5})

film1.save()
film2.save()
film3.save()

customer1 = Customer.new ({'name' => 'James Bo', 'funds' => 40})
customer2 = Customer.new ({'name' => 'Jane Doe', 'funds' => 20})
customer3 = Customer.new ({'name' => 'John Doe', 'funds' => 30})
customer4 = Customer.new ({'name' => 'Dee Leet', 'funds' => 30})

customer1.save()
customer2.save()
customer3.save()
customer4.save()

customer1.name =
("Jim Bo")
customer1.update()

customer4.delete()

film1.title =
("Plop Fiction")
film1.update()

ticket1 = Ticket.new ({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket2 = Ticket.new ({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket3 = Ticket.new ({'customer_id' => customer3.id, 'film_id' => film3.id})
ticket4 = Ticket.new ({'customer_id' => customer1.id, 'film_id' => film3.id})




customer2.buy_ticket(film3)


ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()

customer2.delete()

# customer1.films_viewed_by_customer()

screening1 = Screening.new({ "showtime" => "15:00", "film_id" => film1.id, "seats" => "50" })
screening1.save()


binding.pry
nil
