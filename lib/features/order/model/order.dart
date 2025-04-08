import '../../menu/model/pizza.dart';

class Order {
  // Order model
  final List<Pizza> items;
  final double total;
  final String date;

  Order({required this.items, required this.total, required this.date});

  Map<String, dynamic> toMap() {
    return {
      "items": items.map((pizza) => pizza.toMap()).toList(),
      "total": total,
      "date": date,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      items: (map["items"] as List).map((item) => Pizza.fromMap(item)).toList(),
      total: map["total"],
      date: map["date"],
    );
  }
}
