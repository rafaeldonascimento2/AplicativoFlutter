class Pizza {
  //tudo da pizza
  String name;
  double price;
  int quantity;
  String size;
  String crust;
  String observation;

  Pizza({
    required this.name,
    required this.price,
    required this.quantity,
    required this.size,
    required this.crust,
    required this.observation,
  });

  Map<String, dynamic> toMap() {
    return {
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
      price: map["price"],
      quantity: map["quantity"],
      size: map["size"],
      crust: map["crust"],
      observation: map["observation"],
    );
  }

  Pizza copyWith({
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
}
