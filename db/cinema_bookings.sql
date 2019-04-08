DROP TABLE tickets;
DROP TABLE screenings;
DROP TABLE films;
DROP TABLE customers;



CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name VARCHAR,
  funds INT
);

CREATE TABLE films (
  id SERIAL PRIMARY KEY,
  title VARCHAR,
  price INT
);

CREATE TABLE screenings (
  id SERIAL PRIMARY KEY,
  showtime VARCHAR,
  film_id INT REFERENCES films(id) ON DELETE CASCADE,
  full_capacity INT
);

CREATE TABLE tickets (
  id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT REFERENCES films(id) ON DELETE CASCADE
);
