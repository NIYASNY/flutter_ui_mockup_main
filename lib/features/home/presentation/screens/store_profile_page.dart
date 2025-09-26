import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_mockup_main/features/home/presentation/widgets/service_section.dart';
import 'package:go_router/go_router.dart';

class StoreProfilePage extends StatelessWidget {
  final Map<String, dynamic> spa; // get spa data from Home screen

  const StoreProfilePage({super.key, required this.spa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // --------- MAIN CONTENT ---------
            Expanded(
              child: Stack(
                children: [
                  // Background image (fixed)
                  Container(
                    height: 220,
                    decoration: const BoxDecoration(color: Colors.black12),
                    child: Image.asset(
                      'assets/store_bg.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),

                  // Back button
                  Positioned(
                    top: 12,
                    left: 10,
                    child: CircleAvatar(
                      backgroundColor:
                          const Color.fromARGB(255, 201, 197, 196),
                      child: IconButton(
                        icon: const Icon(
                          CupertinoIcons.back,
                          size: 22,
                        ),
                        onPressed: () => context.pop(context),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 160,
                    left: 12,
                    right: 12,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 70),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // -------- STORE INFO --------
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [                   
                              ClipOval(
                                child: Image.asset(
                                  'assets/circular.jpeg',
                                  height: 54,
                                  width: 54,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    spa["name"],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: const [
                                      Icon(Icons.location_on_outlined,
                                          size: 16, color: Colors.grey),
                                      SizedBox(width: 4),
                                      Text(
                                        'Madhapur',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        '3.5',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        'km',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Icon(Icons.star,
                                          color: Colors.amber, size: 16),
                                      SizedBox(width: 4),
                                      Text(
                                        '4.5',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          // -------- Coupon Section --------
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAF7EE),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.local_offer_outlined,
                                    color: Colors.green, size: 22),
                                const SizedBox(width: 8),

                                // Coupon Text
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Use code DSaloon",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Expanded(
                                            child: Text(
                                              "Get ₹500 off on orders above 100/-",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: const [
                                              Icon(Icons.circle,
                                                  size: 6,
                                                  color: Color.fromARGB(
                                                      255, 202, 92, 52)),
                                              SizedBox(width: 2),
                                              Icon(Icons.circle,
                                                  size: 6, color: Colors.grey),
                                              SizedBox(width: 2),
                                              Icon(Icons.circle,
                                                  size: 6, color: Colors.grey),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 14),

                          // -------- Filter Chips --------
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                _buildFilterChip('All', true),
                                const SizedBox(width: 8),
                                _buildFilterChip('Home-visit'),
                                const SizedBox(width: 8),
                                _buildFilterChip('Walk-in'),
                                const SizedBox(width: 8),
                                _buildFilterChip('Male'),
                                const SizedBox(width: 8),
                                _buildFilterChip('Female'),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // -------- Service Sections --------
                          const Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ServiceSection(
                                    title: "Massage Therapy",
                                    services: [
                                      {
                                        "title": "Swedish Massage",
                                        "desc":
                                            "Experience relaxation and stress relief with long, flowing strokes and gentle kneading tech.",
                                        "price": "₹4,000",
                                        "time": "60 Mins",
                                        "type": "Walk-in",
                                        "added": true
                                      },
                                      {
                                        "title": "Deep Tissue Massage",
                                        "desc":
                                            "Loose muscle relaxation and stress relief with long, flowing strokes and gentle kneading tech.",
                                        "price": "₹6,200",
                                        "time": "60 Mins",
                                        "type": "Walk-in",
                                        "added": false
                                      },
                                      {
                                        "title": "Hot Stone Massage",
                                        "desc":
                                            "Experience relaxation and stress relief with long, flowing strokes and gentle kneading tech.",
                                        "price": "₹8,500",
                                        "time": "60 Mins",
                                        "type": "Home visit",
                                        "added": false
                                      },
                                    ],
                                  ),
                                  ServiceSection(
                                      title: "Hair Cut Wash & Style"),
                                  ServiceSection(title: "Nail Bar"),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // -------- Bottom Checkout Bar --------
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 6),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "4 Services added",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        context.push('/cart');
                      },
                      child: const Text("Check out"),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --------- Chip Builder ---------
  static Widget _buildFilterChip(String label, [bool selected = false]) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.brown.shade600 : Colors.white,
        border: Border.all(
            color: selected ? Colors.transparent : const Color(0xFFE6E0DB)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}

