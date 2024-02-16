
clothing_types = [
  'Camiseta de color',
  'Camiseta blanca',
  'Pantalón',
  'Falda de color',
  'Falda blanca',
  'Chaqueta',
  'Vestido de color',
  'Vestido blanca',
  'Sudadera de color',
  'Sudadera blanca',
  'Abrigo',
]

clothing_types.each do |type|
  ClothingType.create(name: type)
end
