import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/providers/cart_provider.dart';
import '../../data/providers/favourite_provider.dart';
import '../../domain/models/product.dart';
import '../../data/providers/product_provider.dart';


class HomeListScreen extends ConsumerWidget {
  const HomeListScreen({super.key});

  void _showTopSnackBar(
    BuildContext context,
    String message,
    Color bgColor, {
    bool navigate = false,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      backgroundColor: bgColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    if (navigate) {
      Future.delayed(const Duration(seconds: 2), () {
        context.push('/cart');
      });
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsFutureProvider);
    final favorites = ref.watch(favoriteProvider);
    final cart = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F1E8),
      body: SafeArea(
        child: Column(
          children: [
            // ---------------- TOP BAR ----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.location_on_outlined,
                            color: Colors.brown, size: 18),
                        SizedBox(width: 6),
                        Text(
                          "Madhapur ▼",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Cart icon with badge
                  GestureDetector(
                    onTap: () => context.push('/cart'),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.brown,
                          ),
                        ),
                        if (cart.isNotEmpty)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${ref.watch(cartProvider.notifier).totalItems}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ---------------- SEARCH BAR ----------------
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Search Spa, Services...",
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ---------------- PRODUCT LIST ----------------
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: productsAsync.when(
                    data: (products) {
                      return ListView.builder(
                        padding: const EdgeInsets.only(top: 12),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final Product p = products[index];
                          final isFavorite = favorites.contains(p.id);

                          return GestureDetector(
                            onTap: () =>
                                context.push('/store-profile', extra: p.toJson()),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Image
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.asset(
                                          p.image,
                                          width: 90,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 12),

                                      // Details
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    p.name,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    final notifier = ref.read(
                                                        favoriteProvider
                                                            .notifier);
                                                    final set = Set<String>.from(
                                                        notifier.state);
                                                    if (isFavorite) {
                                                      set.remove(p.id);
                                                    } else {
                                                      set.add(p.id);
                                                    }
                                                    notifier.state = set;

                                                    _showTopSnackBar(
                                                      context,
                                                      isFavorite
                                                          ? 'Removed from favorites'
                                                          : 'Added to favorites',
                                                      isFavorite
                                                          ? Colors.redAccent
                                                          : Colors.green,
                                                    );
                                                  },
                                                  child: Icon(
                                                    isFavorite
                                                        ? Icons.favorite
                                                        : Icons
                                                            .favorite_border,
                                                    color: isFavorite
                                                        ? Colors.red
                                                        : Colors.brown,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              p.address,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              p.category,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.orange,
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  "${p.rating}",
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                const Icon(
                                                  Icons.location_on,
                                                  color: Colors.grey,
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  p.distance,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Offer
                                  if (p.offer.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        p.offer,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(color: Colors.brown),
                    ),
                    error: (err, s) => Center(
                      child: Text('Failed to load: $err'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
