-- DEFINE YOUR DATABASE SCHEMA HERE
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS frequencies CASCADE;
DROP TABLE IF EXISTS invoices;

CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  email VARCHAR(255)
);

CREATE TABLE customers(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  account_number VARCHAR(255)
);
CREATE TABLE products(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE frequencies (
  id SERIAL PRIMARY KEY,
  frequency VARCHAR(255)
);

CREATE TABLE invoices (
  id SERIAL PRIMARY KEY,
  employee_name VARCHAR(255),
  customer_name VARCHAR(255),
  frequency VARCHAR(255),
  invoice_no INTEGER,
  sale_date DATE,
  sale_amount NUMERIC,
  units_sold INTEGER
);
