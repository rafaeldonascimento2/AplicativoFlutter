import 'package:flutter/material.dart';

class CartIcon extends StatelessWidget {
  final int itemCount;
  final VoidCallback onTap;

  const CartIcon({required this.itemCount, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: onTap,
        ),
        if (itemCount > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              constraints: BoxConstraints(minWidth: 20, minHeight: 20),
              child: Text(
                itemCount.toString(),
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
