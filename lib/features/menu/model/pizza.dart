import 'package:uuid/uuid.dart';

class Pizza {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String size;
  final String crust;
  final String observation;

  Pizza({
    required this.name,
    required this.price,
    required this.quantity,
    required this.size,
    required this.crust,
    required this.observation,
  }) : id = generateId(name, size, crust, observation);

  static String generateId(
    String name,
    String size,
    String crust,
    String observation,
  ) {
    return '${name}_${size}_${crust}_${observation.hashCode}';
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "quantity": quantity,
      "size": size,
      "crust": crust,
      "observation": observation,
    };
  }

  factory Pizza.fromMap(Map<String, dynamic> map) {
    return Pizza(
      name: map["name"],
      price: map["price"].toDouble(),
      quantity: map["quantity"],
      size: map["size"],
      crust: map["crust"],
      observation: map["observation"],
    );
  }

  Pizza copyWith({
    String? id,
    String? name,
    double? price,
    int? quantity,
    String? size,
    String? crust,
    String? observation,
  }) {
    return Pizza(
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      crust: crust ?? this.crust,
      observation: observation ?? this.observation,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pizza && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
