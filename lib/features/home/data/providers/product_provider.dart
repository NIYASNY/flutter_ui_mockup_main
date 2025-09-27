import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/product.dart';

final productsFutureProvider = FutureProvider<List<Product>>((ref) async {
  try {
    final jsonStr = await rootBundle.loadString('assets/products.json');
    final data = jsonDecode(jsonStr) as List<dynamic>;
    return data.map((e) => Product.fromJson(Map<String, dynamic>.from(e))).toList();
  } catch (e) {
    throw Exception('Failed to load products: $e');
  }
});
