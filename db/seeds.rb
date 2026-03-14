# db/seeds.rb

puts "Limpando banco de dados..."
OrderItem.destroy_all if defined?(OrderItem)
Order.destroy_all if defined?(Order)
Product.destroy_all
Category.destroy_all

puts "Criando categorias..."
cat_almoco = Category.create!(name: "Almoço Executivo", position: 1)
cat_frango = Category.create!(name: "Frangos Assados", position: 2)
cat_pizza  = Category.create!(name: "Pizzas Tradicionais", position: 3)
cat_bebida = Category.create!(name: "Bebidas", position: 4)

puts "Criando produtos da Galeteria..."
Product.create!([
  { name: "Frango Inteiro Assado", description: "Frango suculento na brasa, acompanha farofa.", price: 45.00, category: cat_frango, shift: :lunch },
  { name: "Baião de Dois G", description: "Baião cremoso com queijo coalho e bacon.", price: 25.00, category: cat_almoco, shift: :lunch },
  { name: "Combo Família", description: "1 Frango + Baião G + Guaraná 2L.", price: 75.00, category: cat_almoco, shift: :lunch }
])

puts "Criando produtos da Pizzaria..."
Product.create!([
  { name: "Pizza Calabresa", description: "Molho de tomate, mussarela, calabresa e cebola.", price: 40.00, category: cat_pizza, shift: :dinner },
  { name: "Pizza Portuguesa", description: "Presunto, ovos, azeitona e cobertura de mussarela.", price: 48.00, category: cat_pizza, shift: :dinner },
  { name: "Pizza Frango com Catupiry", description: "Frango desfiado com o legítimo Catupiry.", price: 50.00, category: cat_pizza, shift: :dinner }
])

puts "Criando bebidas (disponíveis em ambos)..."
Product.create!([
  { name: "Coca-Cola 2L", description: "Gelada.", price: 12.00, category: cat_bebida, shift: :both },
  { name: "Suco de Laranja 500ml", description: "Natural da fruta.", price: 8.00, category: cat_bebida, shift: :both }
])

puts "Seed finalizado com sucesso!"