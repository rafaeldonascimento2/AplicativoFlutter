import 'package:flutter/material.dart';

class PizzaDetailsScreen extends StatefulWidget {
  final String name;
  final double basePrice;
  final String image;
  final String description;
  final Function(String, double, int, String, String, String) addToCart;
  final bool isPizza;

  PizzaDetailsScreen({
    required this.name,
    required this.basePrice,
    required this.image,
    required this.description,
    required this.addToCart,
    required this.isPizza,
  });

  @override
  _PizzaDetailsScreenState createState() => _PizzaDetailsScreenState();
}

class _PizzaDetailsScreenState extends State<PizzaDetailsScreen> { //detalhes do item
  int quantity = 1; 
  String selectedSize = "Médio";
  String selectedCrust = "Sem borda";
  String observation = "";
  bool observationSent = false;
  late double currentPrice;

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

  @override
  void initState() {
    super.initState();
    currentPrice = widget.basePrice + (widget.isPizza ? sizePrices[selectedSize]! : 0.0);
  }

  void _updatePrice() {
    setState(() {
      currentPrice = widget.basePrice +
          sizePrices[selectedSize]! +
          (widget.isPizza ? crustPrices[selectedCrust]! : 0.0);
    });
  }

 void _sendObservation() {
  if (observation.trim().isEmpty) {
    // Exibe um aviso caso a observação esteja vazia
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Por favor, escreva uma observação antes de enviar."),
        backgroundColor: Colors.red,
      ),
    );
    return; // Para a execução da função
  }

  setState(() {
    observationSent = true;
  });

  Future.delayed(Duration(seconds: 2), () {
    setState(() {
      observationSent = false;
    });
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: SingleChildScrollView( // 🔹 Permite rolar a tela e evita o overflow
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                widget.image,
                height: 150,
                errorBuilder: (context, error, stackTrace) {
                  return Text("Imagem não encontrada", style: TextStyle(color: Colors.red));
                },
              ),
              SizedBox(height: 10),
              Text(widget.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text(widget.description, style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
              SizedBox(height: 10),

              if (widget.isPizza)
                Column(
                  children: [
                    Text("Escolha o tamanho:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    DropdownButton<String>(
                      value: selectedSize,
                      items: sizePrices.keys.map((size) {
                        return DropdownMenuItem<String>(
                          value: size,
                          child: Text("$size (+R\$ ${sizePrices[size]!.toStringAsFixed(2)})"),
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

              Text("Preço unitário: R\$ ${currentPrice.toStringAsFixed(2)}", style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),

              if (widget.isPizza)
                Column(
                  children: [
                    Text("Adicionar borda recheada:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    DropdownButton<String>(
                      value: selectedCrust,
                      items: crustPrices.keys.map((crust) {
                        return DropdownMenuItem<String>(
                          value: crust,
                          child: Text("$crust (+R\$ ${crustPrices[crust]!.toStringAsFixed(2)})"),
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
                    Text("Observação:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    TextField(
                      onChanged: (text) {
                        observation = text;
                      },
                      decoration: InputDecoration(
                        hintText: "Ex: Sem azeitona, bem assada...",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _sendObservation,
                      child: Text("Enviar Observação"),
                    ),
                    if (observationSent)
                      Text("Observação enviada!", style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold)),
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
                  Text("$quantity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
              Text("Total: R\$ ${(currentPrice * quantity).toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  widget.addToCart(
                    widget.name,
                    currentPrice,
                    quantity,
                    widget.isPizza ? selectedSize : "-",
                    widget.isPizza ? selectedCrust : "-",
                    widget.isPizza ? observation : "-", // Adicionando observação ao pedido
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${widget.name} adicionada ao carrinho!")),
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
