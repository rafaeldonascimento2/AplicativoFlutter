class MenuRamMemoryDao {
  static final MenuRamMemoryDao _instance = MenuRamMemoryDao._internal();

  factory MenuRamMemoryDao() => _instance;

  MenuRamMemoryDao._internal();

  final List<Map<String, dynamic>> pizzasSalgadas = [
    {
      "name": "Pizza Margherita",
      "price": 35.00,
      "image": "assets/pizza_margherita.png",
      "description": "Molho de tomate, mussarela e manjericão fresco.",
      "category": "Pizzas Salgadas",
    },
    {
      "name": "Pizza Pepperoni",
      "price": 40.00,
      "image": "assets/pizza_pepperoni.png",
      "description": "Pizza clássica de pepperoni com queijo derretido.",
      "category": "Pizzas Salgadas",
    },
    {
      "name": "Pizza Quatro Queijos",
      "price": 42.00,
      "image": "assets/pizza_quatro_queijos.png",
      "description": "Mussarela, parmesão, gorgonzola e provolone.",
      "category": "Pizzas Salgadas",
    },
    {
      "name": "Pizza Frango com Catupiry",
      "price": 38.00,
      "image": "assets/pizza_frango_catupiry.png",
      "description": "Pizza de frango desfiado com catupiry.",
      "category": "Pizzas Salgadas",
    },
    {
      "name": "Pizza Portuguesa",
      "price": 39.50,
      "image": "assets/pizza_portuguesa.png",
      "description": "Presunto, ovos, cebola e azeitonas.",
      "category": "Pizzas Salgadas",
    },
    {
      "name": "Pizza Calabresa",
      "price": 36.00,
      "image": "assets/pizza_calabresa.png",
      "description": "Calabresa fatiada com cebola e orégano.",
      "category": "Pizzas Salgadas",
    },
  ];

  final List<Map<String, dynamic>> pizzasDoces = [
    {
      "name": "Pizza de Chocolate",
      "price": 30.00,
      "image": "assets/pizza_chocolate.png",
      "description": "Chocolate derretido e morangos.",
      "category": "Pizzas Doces",
    },
    {
      "name": "Pizza de Banana com Canela",
      "price": 28.00,
      "image": "assets/pizza_banana.png",
      "description": "Banana caramelizada e canela.",
      "category": "Pizzas Doces",
    },
    {
      "name": "Pizza de Doce de Leite",
      "price": 32.00,
      "image": "assets/pizza_doce_leite.png",
      "description": "Cobertura de doce de leite e coco ralado.",
      "category": "Pizzas Doces",
    },
  ];

  final List<Map<String, dynamic>> bebidas = [
    {
      "name": "Refrigerante Coca-Cola",
      "price": 5.00,
      "image": "assets/coca.png",
      "description": "Lata de 350ml.",
      "category": "Bebidas",
    },
    {
      "name": "Suco de Laranja Natural",
      "price": 7.00,
      "image": "assets/suco_laranja.png",
      "description": "Suco de laranja puro e refrescante.",
      "category": "Bebidas",
    },
    {
      "name": "Água Mineral",
      "price": 3.00,
      "image": "assets/agua.png",
      "description": "Garrafa de 500ml.",
      "category": "Bebidas",
    },
  ];

  final List<Map<String, dynamic>> drinks = [
    {
      "name": "Caipirinha de Limão",
      "price": 15.00,
      "image": "assets/caipirinha.png",
      "description": "Cachaça, limão, açúcar e gelo.",
      "category": "Drinks",
    },
    {
      "name": "Negroni",
      "price": 18.00,
      "image": "assets/negroni.png",
      "description": "Gin, vermute rosso e Campari.",
      "category": "Drinks",
    },
    {
      "name": "Piña Colada",
      "price": 20.00,
      "image": "assets/pina_colada.png",
      "description": "Rum, leite de coco e abacaxi.",
      "category": "Drinks",
    },
  ];

  List<Map<String, dynamic>> getAllItems() {
    return [...pizzasSalgadas, ...pizzasDoces, ...bebidas, ...drinks];
  }

  List<Map<String, dynamic>> getPizzasSalgadas() => pizzasSalgadas;
  List<Map<String, dynamic>> getPizzasDoces() => pizzasDoces;
  List<Map<String, dynamic>> getBebidas() => bebidas;
  List<Map<String, dynamic>> getDrinks() => drinks;
}
