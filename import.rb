# Use this file to import the sales information into the
# the database.

require "pg"
require "csv"
require "pry"

def db_connection
  begin
    connection = PG.connect(dbname: "korning")
    yield(connection)
  ensure
    connection.close
  end
end

@employees_array = []
@customers_array = []
@products_array = []
@frequencies_array = []

@sales = []

db_connection do |conn|
  CSV.foreach('sales.csv', :headers => true, header_converters: :symbol) do |row|
    @employees_array << row[:employee].split(/[()]/)
    @customers_array << row[:customer_and_account_no].split(/[()]/)
    @products_array << row[:product_name]
    @frequencies_array << row[:invoice_frequency]
    @sales << row
  end

  @employees_array = @employees_array.uniq!
  @customers_array = @customers_array.uniq!
  @products_array = @products_array.uniq!

# binding.pry
  @employees_array.each do |name, email|
    conn.exec_params("INSERT INTO employees (name, email) VALUES ($1, $2)",
    [name, email])
  end

  @customers_array.each do |name, account|
    conn.exec_params("INSERT INTO customers (name, account_number) VALUES ($1, $2)",
    [name, account])
  end

  @products_array.each do |product|
    conn.exec_params("INSERT INTO products (name) VALUES ($1)",
    [product])
  end

  @frequencies_array.each do |time|
    conn.exec_params("INSERT INTO frequencies (frequency) VALUES ($1)",
    [time])
  end

  @sales.each do |row|
    conn.exec_params("INSERT INTO invoices (employee_name, customer_name, frequency, invoice_no, sale_date, sale_amount, units_sold) VALUES ($1, $2, $3, $4, $5, $6, $7)",
    [row[:employee], row[:customer_and_account_no], row[:invoice_frequency], row[:invoice_no], row[:sale_date],
    row[:sale_amount][1..-1].to_f, row[:units_sold]])
  end
end


# @ingredients_array.each do |value, item|
#   puts "#{value}. #{item}"
# end
