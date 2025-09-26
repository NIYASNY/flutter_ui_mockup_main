import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/favourite/favourite_bloc.dart';
import '../bloc/favourite/favourite_event.dart';

class HomeListScreen extends StatelessWidget {
  const HomeListScreen({super.key});

  final List<Map<String, dynamic>> spas = const [
    {
      "name": "Renew Day Spa",
      "address": "120B, Spinne Arcade, Flat No 102",
      "category": "Unisex",
      "rating": 4.5,
      "distance": "3.5 km",
      "offer": "Flat 10% Off above value of 200",
      "image": "assets/spa1.jpg",
    },
    {
      "name": "Mystical Mantra Spa",
      "address": "120B, Spinne Arcade, Flat No 102",
      "category": "Male",
      "rating": 4.5,
      "distance": "3.5 km",
      "offer": "",
      "image": "assets/spa2.jpeg",
    },
    {
      "name": "Bodhi Retreat Spa",
      "address": "120B, Spinne Arcade, Flat No 102",
      "category": "Female",
      "rating": 4.5,
      "distance": "3.5 km",
      "offer": "Flat 10% Off above value of 200",
      "image": "assets/spa3.jpeg",
    },
    {
      "name": "Eternal Bliss Ayurvedic",
      "address": "120B, Spinne Arcade, Flat No 102",
      "category": "Female",
      "rating": 4.5,
      "distance": "3.5 km",
      "offer": "",
      "image": "assets/spa4.jpg",
    },
  ];

  void _showTopSnackBar(BuildContext context, String message, Color bgColor,
      {bool navigate = false}) {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1E8),
      body: SafeArea(
        child: Column(
          children: [
            //TOP BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications_none,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            ),

            //SEARCH BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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

            //SPA LIST
            const SizedBox(height: 15),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, state) {
                      return ListView.builder(
                        padding: const EdgeInsets.only(top: 12),
                        itemCount: spas.length,
                        itemBuilder: (context, index) {
                          final spa = spas[index];
                          final isFavorite =
                              state.favoriteIndices.contains(index);
                
                          return GestureDetector(
                            onTap: () {
                              context.push('/store-profile', extra: spa);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.asset(
                                          spa["image"],
                                          width: 90,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                
                                      //DETAILS
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    spa["name"],
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    context
                                                        .read<FavoriteBloc>()
                                                        .add(ToggleFavorite(index));
                
                                                    if (isFavorite) {
                                                      _showTopSnackBar(
                                                        context,
                                                        "Removed from cart",
                                                        Colors.redAccent,
                                                      );
                                                    } else {
                                                      _showTopSnackBar(
                                                        context,
                                                        "Card added successfully",
                                                        Colors.green,
                                                        navigate: true,
                                                      );
                                                    }
                                                  },
                                                  child: Icon(
                                                    isFavorite
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: isFavorite
                                                        ? Colors.red
                                                        : Colors.brown,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              spa["address"],
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              spa["category"],
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              children: [
                                                const Icon(Icons.star,
                                                    color: Colors.orange,
                                                    size: 16),
                                                const SizedBox(width: 4),
                                                Text(
                                                  "${spa["rating"]}",
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                const Icon(Icons.location_on,
                                                    color: Colors.grey, size: 16),
                                                const SizedBox(width: 4),
                                                Text(
                                                  spa["distance"],
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
                
                                  if (spa["offer"] != "")
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        spa["offer"],
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
