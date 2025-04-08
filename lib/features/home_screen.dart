import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/auth/ui/login_view.dart';
import 'package:flutter_application_1/features/cart/core/controllers/cart_controller.dart';
import 'package:flutter_application_1/features/favorites/ui/favorites_screen.dart'; // Importe a tela de favoritos
import 'package:flutter_application_1/features/infos/about_screen.dart';
import 'package:flutter_application_1/features/menu/ui/pizza_list_screen.dart';
import 'package:flutter_application_1/features/menu/ui/pizza_search_delegate.dart';
import 'package:flutter_application_1/features/cart/ui/cart_screen.dart';
import 'package:flutter_application_1/features/order/ui/orders_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late List<Widget> _pages;
  final CartController _cartController = CartController();

  @override
  void initState() {
    super.initState();
    _updatePages();
  }

  void _updatePages() {
    _pages = [
      PizzaListScreen(),
      FavoritesScreen(), // Nova aba de favoritos
      const OrdersScreen(),
      const AboutScreen(),
    ];
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
              showSearch(context: context, delegate: PizzaSearchDelegate());
            },
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () async {
                  await _navigateWithFade(context, CartScreen());
                  setState(() {});
                },
              ),
              if (_cartController.itemCount > 0)
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
                      _cartController.itemCount.toString(),
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
              await _navigateWithFade(context, LoginView());
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
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_pizza),
            label: 'Pizzas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Pedidos'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Sobre'),
        ],
      ),
    );
  }
}
