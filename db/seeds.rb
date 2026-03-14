# db/seeds.rb — idempotente (seguro rodar múltiplas vezes)
# Só popula se o banco estiver vazio
return if Category.exists?

puts "Criando categorias..."
cat_almoco = Category.create!(name: "Almoço Executivo",      position: 1, emoji: "🍱")
cat_frango = Category.create!(name: "Frangos Assados",       position: 2, emoji: "🍗")
cat_pizza  = Category.create!(name: "Pizzas Tradicionais",   position: 3, emoji: "🍕")
cat_bebida = Category.create!(name: "Bebidas",               position: 4, emoji: "🥤")

puts "Criando produtos da Galeteria..."
Product.create!([
  { name: "Frango Inteiro Assado",  description: "Frango suculento na brasa, acompanha farofa.", price: 45.00, category: cat_frango, shift: :lunch,  emoji: "🍗", is_featured: true },
  { name: "Baião de Dois G",        description: "Baião cremoso com queijo coalho e bacon.",     price: 25.00, category: cat_almoco, shift: :lunch,  emoji: "🍛" },
  { name: "Combo Família",          description: "1 Frango + Baião G + Guaraná 2L.",             price: 75.00, category: cat_almoco, shift: :lunch,  emoji: "🎉", is_featured: true }
])

puts "Criando produtos da Pizzaria..."
Product.create!([
  { name: "Pizza Calabresa",             description: "Molho de tomate, mussarela, calabresa e cebola.",        price: 40.00, category: cat_pizza, shift: :dinner, emoji: "🍕", is_featured: true },
  { name: "Pizza Portuguesa",            description: "Presunto, ovos, azeitona e cobertura de mussarela.",      price: 48.00, category: cat_pizza, shift: :dinner, emoji: "🍕" },
  { name: "Pizza Frango com Catupiry",   description: "Frango desfiado com o legítimo Catupiry.",               price: 50.00, category: cat_pizza, shift: :dinner, emoji: "🍕", is_customizable: true }
])

puts "Criando bebidas (disponíveis em ambos)..."
Product.create!([
  { name: "Coca-Cola 2L",       description: "Gelada.",          price: 12.00, category: cat_bebida, shift: :both, emoji: "🥤" },
  { name: "Suco de Laranja 500ml", description: "Natural da fruta.", price: 8.00, category: cat_bebida, shift: :both, emoji: "🍊" }
])

puts "Seed finalizado com sucesso!"