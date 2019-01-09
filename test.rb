def read_products(file_name)
file = File.open(file_name, 'r')
products = file.readlines.map(&:chomp).map { |lines| lines.split(', ') }
file.close
products
end

prod_array = read_products('inventario.csv')

def print_menu
  puts '1) Mostrar los productos y su stock.'
  puts '2) Mostrar stock total de cada producto.'
  puts '3) Mostrar producto con mayor stock.'
  puts '4) Mostrar producto con menor stock.'
  puts '5) Mostrar productos sin stock en alguna tienda.'
  puts '6) Verificar si un producto existe.'
  puts '7) Salir.'
end

def get_values array
  array[1..-1].map(&:to_i)
end

print_menu
action = gets.to_i
while action != 7
  if action == 1
    prod_array.each do |prod|
      puts "#{prod[0]}: #{get_values(prod).join(' ')}"
    end
  elsif action == 2
    prod_array.each do |prod|
      puts "#{prod[0]}: #{get_values(prod).sum}"
    end
  elsif action == 3
    max_array = ['', 0]
    prod_array.each do |prod|
      total = get_values(prod).sum
      max_array = [prod[0], total] if total > max_array[1]
    end
    puts max_array[0]
  elsif action == 4
    min_array = []
    prod_array.each do |prod|
      min_array.push prod[1..-1].map(&:to_i).sum
    end
    puts prod_array[min_array.find_index(min_array.min)][0]
  elsif action == 5
    prod_array.each { |prod| puts prod[0] if prod.include? '0'}
  elsif action == 6
    puts 'Ingrese el producto a verificar:'
    prod_to_verify = gets.chomp
    exists = false
    prod_array.each { |prod| exists = true if prod[0].downcase == prod_to_verify.downcase }
    puts exists ? 'Sí' : 'No'
  else
    puts 'Ingrese una opción válida'
    print_menu
    action = gets.to_i
  end
  print_menu
  action = gets.to_i
end
puts 'Adios!!'
