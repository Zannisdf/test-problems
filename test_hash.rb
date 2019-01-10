def read_products(file_name)
file = File.open(file_name, 'r')
products = file.readlines.map(&:chomp).map { |lines| lines.split(', ') }
file.close
products
end

def menu
  puts 'Ingrese una opción:'
  puts '1) Mostrar los productos y su stock.'
  puts '2) Mostrar stock total de cada producto.'
  puts '3) Mostrar producto con mayor stock.'
  puts '4) Mostrar producto con menor stock.'
  puts '5) Mostrar productos sin stock en alguna tienda.'
  puts '6) Verificar si un producto existe.'
  puts '7) Salir.'
end

def get_total_stock(store_stock)
  store_stock.map(&:to_i).sum
end

def show_products(products)
  products.each { |prod, stock| puts "#{prod}: #{stock.join(' ')}" }
end

def show_total_stock(products)
  products.each do |prod, stock|
    puts "#{prod}: #{get_total_stock(stock)}"
  end
end

def show_most_stock(products)
  max = ['', 0]
  products.each do |prod, stock|
    current_stock = get_total_stock(stock)
    max = [prod, current_stock] if current_stock > max.last
  end
  puts "#{max.first}: #{max.last}"
end

def show_less_stock(products)
  min = ['', nil]
  products.each do |prod,stock|
    current_stock = get_total_stock(stock)
    min = [prod, current_stock] if min.last == nil || min.last > current_stock
  end
  puts "#{min.first}: #{min.last}"
end

def show_stock_zero(products)
  products.each {|prod, stock| puts prod if stock.include? '0' }
end

def show_product_existence(products, prod_to_verify)
  puts products.key?(prod_to_verify) ? 'Si' : 'No'
end

products = read_products('inventario.csv').map { |prod| [prod.first, prod[1..-1]] }.to_h
ask = true
while ask
  menu
  input = gets.to_i
  if input == 1
    show_products(products)
  elsif input == 2
    show_total_stock(products)
  elsif input == 3
    show_most_stock(products)
  elsif input == 4
    show_less_stock(products)
  elsif input == 5
    show_stock_zero(products)
  elsif input == 6
    puts 'Ingrese el producto a verificar:'
    prod_to_verify = gets.chomp
    show_product_existence(products, prod_to_verify)
  elsif input == 7
    puts 'Adios!'
    ask = false
  else
    puts 'Opción inválida.'
  end
end
