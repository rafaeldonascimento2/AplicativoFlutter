import 'package:flutter/material.dart';
import 'orders_screen.dart';
import 'about_screen.dart';
import 'login_screen.dart';
import 'cart_screen.dart';
import '../widgets/pizza_list_screen.dart';
import '../widgets/pizza_search_delegate.dart';
import '../models/order.dart';
import '../models/pizza.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Pizza> cart = [];
  List<Order> orders = [];
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _updatePages();
  }

  void _updatePages() {
    _pages = [
      PizzaListScreen(addToCart: addToCart),
      OrdersScreen(orders: orders),
      AboutScreen(),
    ];
  }

  void addToCart(String name, double price, int quantity, String size, String crust, String observation) {
    setState(() {
      bool exists = false;

      for (var item in cart) {
        if (item.name == name && item.size == size && item.crust == crust) {
          item.quantity += quantity;
          exists = true;
          break;
        }
      }

      if (!exists) {
        cart.add(Pizza(
          name: name,
          price: price,
          quantity: quantity,
          size: size,
          crust: crust,
          observation: observation.isNotEmpty ? observation : "Sem observação",
        ));
      }
    });
  }

  void finalizeOrder() {
    if (cart.isNotEmpty) {
      setState(() {
        orders.insert(0, Order(
          items: List.from(cart),
          total: cart.fold(0.0, (sum, item) => sum + (item.price * item.quantity)),
          date: DateTime.now().toString(),
        ));
        cart.clear();
        _updatePages();
      });
    }
  }

  int getCartItemCount() {
    return cart.fold(0, (sum, item) => sum + item.quantity);
  }

  Future<void> _navigateWithFade(BuildContext context, Widget page) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pizzaria Flutter'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: PizzaSearchDelegate(addToCart: (name, price, quantity, size, crust) {
                  addToCart(name, price, quantity, size, crust, "");
                }),
              );
            },
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () async {
                  await _navigateWithFade(
                    context,
                    CartScreen(
                      cartItems: cart,
                      finalizeOrder: finalizeOrder,
                    ),
                  );
                  setState(() {});
                },
              ),
              if (getCartItemCount() > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(minWidth: 20, minHeight: 20),
                    child: Text(
                      getCartItemCount().toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await _navigateWithFade(context, LoginScreen());
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.local_pizza), label: 'Pizzas'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Pedidos'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Sobre'),
        ],
      ),
    );
  }
}
