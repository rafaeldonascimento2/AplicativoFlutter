import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/cart/core/controllers/cart_controller.dart';
import 'package:flutter_application_1/features/favorites/core/controller/favorites_controller.dart';
import 'package:flutter_application_1/features/menu/model/pizza.dart';

class PizzaDetailsScreen extends StatefulWidget {
  final String name;
  final double basePrice;
  final String image;
  final String description;
  final bool isPizza;

  const PizzaDetailsScreen({
    super.key,
    required this.name,
    required this.basePrice,
    required this.image,
    required this.description,
    required this.isPizza,
  });

  @override
  _PizzaDetailsScreenState createState() => _PizzaDetailsScreenState();
}

class _PizzaDetailsScreenState extends State<PizzaDetailsScreen> {
  int quantity = 1;
  String selectedSize = "Médio";
  String selectedCrust = "Sem borda";
  String observation = "";
  bool observationSent = false;
  late double currentPrice;

  FavoritesController? _favoritesController;
  final CartController _cartController = CartController();

  final Map<String, double> sizePrices = {
    "Pequeno": 0.0,
    "Médio": 5.00,
    "Grande": 10.00,
  };

  final Map<String, double> crustPrices = {
    "Sem borda": 0.0,
    "Cheddar": 6.00,
    "Catupiry": 7.00,
    "Chocolate": 5.00,
  };

  Pizza get _currentPizza => Pizza(
    name: widget.name,
    price: currentPrice,
    quantity: quantity,
    size: widget.isPizza ? selectedSize : "-",
    crust: widget.isPizza ? selectedCrust : "-",
    observation: widget.isPizza ? observation : "-",
  );

  @override
  void initState() {
    super.initState();
    currentPrice =
        widget.basePrice + (widget.isPizza ? sizePrices[selectedSize]! : 0.0);

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _favoritesController = FavoritesController(userId: user.uid);
      _favoritesController!.addListener(_updateFavoritesState);
    }
  }

  void _updateFavoritesState() {
    setState(() {});
  }

  @override
  void dispose() {
    _favoritesController?.removeListener(_updateFavoritesState);
    super.dispose();
  }

  void _updatePrice() {
    setState(() {
      currentPrice =
          widget.basePrice +
          sizePrices[selectedSize]! +
          (widget.isPizza ? crustPrices[selectedCrust]! : 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: [
          IconButton(
            icon: Icon(
              (_favoritesController?.isFavorite(_currentPizza) ?? false)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () async {
              if (_favoritesController == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Faça login para usar favoritos"),
                  ),
                );
                return;
              }

              final isFav = _favoritesController!.isFavorite(_currentPizza);

              if (isFav) {
                await _favoritesController!.removeFromFavorites(_currentPizza);
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Removido dos favoritos")),
                );
              } else {
                await _favoritesController!.addToFavorites(_currentPizza);
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Adicionado aos favoritos!")),
                );
              }

              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                widget.image,
                height: 150,
                errorBuilder: (context, error, stackTrace) {
                  return Text(
                    "Imagem não encontrada",
                    style: TextStyle(color: Colors.red),
                  );
                },
              ),
              SizedBox(height: 10),
              Text(
                widget.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                widget.description,
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 10),

              if (widget.isPizza)
                Column(
                  children: [
                    Text(
                      "Escolha o tamanho:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<String>(
                      value: selectedSize,
                      items:
                          sizePrices.keys.map((size) {
                            return DropdownMenuItem<String>(
                              value: size,
                              child: Text(
                                "$size (+R\$ ${sizePrices[size]!.toStringAsFixed(2)})",
                              ),
                            );
                          }).toList(),
                      onChanged: (newSize) {
                        if (newSize != null) {
                          setState(() {
                            selectedSize = newSize;
                            _updatePrice();
                          });
                        }
                      },
                    ),
                    SizedBox(height: 10),
                  ],
                ),

              Text(
                "Preço unitário: R\$ ${currentPrice.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              if (widget.isPizza)
                Column(
                  children: [
                    Text(
                      "Adicionar borda recheada:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<String>(
                      value: selectedCrust,
                      items:
                          crustPrices.keys.map((crust) {
                            return DropdownMenuItem<String>(
                              value: crust,
                              child: Text(
                                "$crust (+R\$ ${crustPrices[crust]!.toStringAsFixed(2)})",
                              ),
                            );
                          }).toList(),
                      onChanged: (newCrust) {
                        if (newCrust != null) {
                          setState(() {
                            selectedCrust = newCrust;
                            _updatePrice();
                          });
                        }
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),

              if (widget.isPizza)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Observação:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      onChanged: (text) {
                        observation = text;
                      },
                      decoration: InputDecoration(
                        hintText: "Ex: Sem azeitona, bem assada...",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) quantity--;
                      });
                    },
                  ),
                  Text(
                    "$quantity",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.green),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),

              SizedBox(height: 20),
              Text(
                "Total: R\$ ${(currentPrice * quantity).toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  await _cartController.addToCart(
                    widget.name,
                    currentPrice,
                    quantity,
                    widget.isPizza ? selectedSize : "-",
                    widget.isPizza ? selectedCrust : "-",
                    widget.isPizza ? observation : "-",
                  );

                  if (!mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${widget.name} adicionada ao carrinho!"),
                    ),
                  );
                },
                child: Text("Adicionar ao Carrinho"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
