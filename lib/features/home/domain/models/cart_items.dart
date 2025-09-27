import 'package:flutter_ui_mockup_main/features/home/domain/models/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({required this.product, required this.quantity});

  CartItem copyWith({int? quantity}) => CartItem(product: product, quantity: quantity ?? this.quantity);

  Map<String, dynamic> toJson() => {
        'product': product.toJson(),
        'quantity': quantity,
      };

  factory CartItem.fromJson(Map<String, dynamic> j) => CartItem(
        product: Product.fromJson(Map<String, dynamic>.from(j['product'])),
        quantity: (j['quantity'] as num).toInt(),
      );
}
