# db/seeds.rb

# Só popula se o banco estiver vazio (boa estratégia para performance)
return if Category.exists?

puts "Criando categorias..."
cat_almoco = Category.find_or_create_by!(name: "Almoço Executivo") { |c| c.position = 1; c.emoji = "🍱" }
cat_frango = Category.find_or_create_by!(name: "Frangos Assados") { |c| c.position = 2; c.emoji = "🍗" }
cat_pizza  = Category.find_or_create_by!(name: "Pizzas Tradicionais") { |c| c.position = 3; c.emoji = "🍕" }
cat_bebida = Category.find_or_create_by!(name: "Bebidas") { |c| c.position = 4; c.emoji = "🥤" }

puts "Criando produtos da Galeteria..."
products_galeteria = [
  { name: "Frango Inteiro Assado", description: "Frango suculento na brasa, acompanha farofa.", price: 45.00, category: cat_frango, shift: :lunch, emoji: "🍗", is_featured: true },
  { name: "Baião de Dois G", description: "Baião cremoso com queijo coalho e bacon.", price: 25.00, category: cat_almoco, shift: :lunch, emoji: "🍛" },
  { name: "Combo Família", description: "1 Frango + Baião G + Guaraná 2L.", price: 75.00, category: cat_almoco, shift: :lunch, emoji: "🎉", is_featured: true }
]

products_galeteria.each { |attrs| Product.find_or_create_by!(name: attrs[:name]) { |p| p.assign_attributes(attrs) } }

puts "Criando produtos da Pizzaria..."
products_pizzaria = [
  { name: "Pizza Calabresa", description: "Molho de tomate, mussarela, calabresa e cebola.", price: 40.00, category: cat_pizza, shift: :dinner, emoji: "🍕", is_featured: true },
  { name: "Pizza Portuguesa", description: "Presunto, ovos, azeitona e cobertura de mussarela.", price: 48.00, category: cat_pizza, shift: :dinner, emoji: "🍕" },
  { name: "Pizza Frango com Catupiry", description: "Frango desfiado com o legítimo Catupiry.", price: 50.00, category: cat_pizza, shift: :dinner, emoji: "🍕", is_customizable: true }
]

products_pizzaria.each { |attrs| Product.find_or_create_by!(name: attrs[:name]) { |p| p.assign_attributes(attrs) } }

puts "Criando bebidas..."
drinks = [
  { name: "Coca-Cola 2L", description: "Gelada.", price: 12.00, category: cat_bebida, shift: :both, emoji: "🥤" },
  { name: "Suco de Laranja 500ml", description: "Natural da fruta.", price: 8.00, category: cat_bebida, shift: :both, emoji: "🍊" }
]

drinks.each { |attrs| Product.find_or_create_by!(name: attrs[:name]) { |p| p.assign_attributes(attrs) } }

puts "Seed finalizado com sucesso!"