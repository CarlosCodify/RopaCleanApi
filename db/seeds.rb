
# clothing_types = [
#   'Camiseta de color',
#   'Camiseta blanca',
#   'Pantalón',
#   'Falda de color',
#   'Falda blanca',
#   'Chaqueta',
#   'Vestido de color',
#   'Vestido blanca',
#   'Sudadera de color',
#   'Sudadera blanca',
#   'Abrigo',
# ]

# clothing_types.each do |type|
#   ClothingType.create(name: type)
# end

Brand.create([
  { name: "Honda" },
  { name: "Suzuki" },
  { name: "Kawasaki" },
  { name: "BMW" }
])

Model.create([
  { name: "YZF-R1", year: "2023", brand: Brand.find_by(name: "Yamaha") },
  { name: "CBR1000RR-R Fireblade", year: "2023", brand: Brand.find_by(name: "Honda") },
  { name: "GSX-R1000", year: "2023", brand: Brand.find_by(name: "Suzuki") },
  { name: "Ninja ZX-10R", year: "2023", brand: Brand.find_by(name: "Kawasaki") },
  { name: "S1000RR", year: "2023", brand: Brand.find_by(name: "BMW") },
  { name: "MT-07", year: "2023", brand: Brand.find_by(name: "Yamaha") },
  { name: "CB500X", year: "2023", brand: Brand.find_by(name: "Honda") },
  { name: "V-Strom 650XT", year: "2023", brand: Brand.find_by(name: "Suzuki") },
  { name: "Versys 650", year: "2023", brand: Brand.find_by(name: "Kawasaki") },
  { name: "F850 GS", year: "2023", brand: Brand.find_by(name: "BMW") }
])
