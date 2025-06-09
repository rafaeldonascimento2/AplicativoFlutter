import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/features/menu/model/pizza.dart';

class CartFirestoreDao {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId;

  CartFirestoreDao({required this.userId});

  CollectionReference get _cartCollection =>
      _firestore.collection('users').doc(userId).collection('cart');

  /// Busca todos os itens do carrinho
  Future<List<Pizza>> getCart() async {
    final snapshot = await _cartCollection.get();
    return snapshot.docs
        .map((doc) => Pizza.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  /// Adiciona item ao carrinho ou atualiza a quantidade se já existir
  Future<void> addItem(
    String name,
    double price,
    int quantity,
    String size,
    String crust,
    String observation,
  ) async {
    final normalizedObservation =
        observation.trim().isEmpty ? "Sem observação" : observation.trim();
    final id = Pizza.generateId(name, size, crust, normalizedObservation);
    final docRef = _cartCollection.doc(id);

    final doc = await docRef.get();
    if (doc.exists) {
      final existing = Pizza.fromMap(doc.data() as Map<String, dynamic>);
      print(
        'Atualizando quantidade de ${existing.name} para ${existing.quantity + quantity}',
      );
      await docRef.update({"quantity": existing.quantity + quantity});
    } else {
      final pizza = Pizza(
        name: name,
        price: price,
        quantity: quantity,
        size: size,
        crust: crust,
        observation: normalizedObservation,
      );
      print('Adicionando novo item ao carrinho: ${pizza.name}');
      await docRef.set(pizza.toMap());
    }
  }

  /// Remove o item do carrinho baseado nas características
  Future<void> removeItem(
    String name,
    String size,
    String crust,
    String observation,
  ) async {
    final normalizedObservation =
        observation.trim().isEmpty ? "Sem observação" : observation.trim();
    final id = Pizza.generateId(name, size, crust, normalizedObservation);
    final docRef = _cartCollection.doc(id);

    print('Tentando remover item com id: $id');
    final doc = await docRef.get();
    if (doc.exists) {
      await docRef.delete();
      print('Item removido com sucesso!');
    } else {
      print('Item com id $id não encontrado para remoção.');
    }
  }

  /// Diminui a quantidade de um item, ou remove se for 1
  Future<void> decreaseQuantityById(String id) async {
    final docRef = _cartCollection.doc(id);
    final doc = await docRef.get();

    if (doc.exists) {
      final pizza = Pizza.fromMap(doc.data() as Map<String, dynamic>);
      if (pizza.quantity > 1) {
        print(
          'Diminuindo quantidade de ${pizza.name} para ${pizza.quantity - 1}',
        );
        await docRef.update({"quantity": pizza.quantity - 1});
      } else {
        print('Quantidade é 1. Removendo ${pizza.name}');
        await docRef.delete();
      }
    } else {
      print(
        'Documento com id $id não encontrado ao tentar diminuir quantidade.',
      );
    }
  }

  /// Remove todos os itens do carrinho
  Future<void> clearCart() async {
    final snapshot = await _cartCollection.get();
    for (var doc in snapshot.docs) {
      print('Removendo item do carrinho: ${doc.id}');
      await doc.reference.delete();
    }
  }

  /// Calcula o total atual do carrinho
  Future<double> calculateTotal() async {
    final items = await getCart();
    return items.fold<double>(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }

  /// Retorna a quantidade total de itens no carrinho
  Future<int> getItemCount() async {
    final items = await getCart();
    return items.fold<int>(0, (sum, item) => sum + item.quantity);
  }
}
