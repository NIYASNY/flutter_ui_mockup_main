import 'dart:convert';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../home/domain/models/product.dart';
import '../../domain/models/cart_items.dart';

const _kCartKey = 'cart_state_v1';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final s = prefs.getString(_kCartKey);
      if (s != null) {
        final decoded = jsonDecode(s) as List<dynamic>;
        state = decoded.map((e) => CartItem.fromJson(Map<String, dynamic>.from(e))).toList();
      }
    } catch (_) {
      // ignore load errors (start with empty cart)
      state = [];
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kCartKey, jsonEncode(state.map((e) => e.toJson()).toList()));
  }

  void addToCart(Product p, {int qty = 1}) {
    final idx = state.indexWhere((c) => c.product.id == p.id);
    if (idx >= 0) {
      final updated = List<CartItem>.from(state);
      updated[idx] = updated[idx].copyWith(quantity: updated[idx].quantity + qty);
      state = updated;
    } else {
      state = [...state, CartItem(product: p, quantity: qty)];
    }
    _save();
  }

  void increment(Product p) {
    addToCart(p, qty: 1);
  }

  void decrement(Product p) {
    final idx = state.indexWhere((c) => c.product.id == p.id);
    if (idx < 0) return;
    final list = List<CartItem>.from(state);
    final current = list[idx];
    if (current.quantity > 1) {
      list[idx] = current.copyWith(quantity: current.quantity - 1);
      state = list;
    } else {
      list.removeAt(idx);
      state = list;
    }
    _save();
  }

  void remove(Product p) {
    state = state.where((c) => c.product.id != p.id).toList();
    _save();
  }

  void clear() {
    state = [];
    _save();
  }

  int get totalItems => state.fold(0, (s, e) => s + e.quantity);

  double get totalPrice => state.fold(0.0, (s, e) => s + e.product.price * e.quantity);
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) => CartNotifier());
