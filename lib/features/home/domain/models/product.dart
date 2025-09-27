class Product {
  final String id;
  final String name;
  final String address;
  final String category;
  final double rating;
  final String distance;
  final String offer;
  final String image;
  final double price;
  final String time;
  final String type;

  Product({
    required this.id,
    required this.name,
    required this.address,
    required this.category,
    required this.rating,
    required this.distance,
    required this.offer,
    required this.image,
    required this.price,
    required this.time,
    required this.type,
  });

  factory Product.fromJson(Map<String, dynamic> j) => Product(
        id: j['id'].toString(),
        name: j['name'] ?? '',
        address: j['address'] ?? '',
        category: j['category'] ?? '',
        rating: (j['rating'] as num).toDouble(),
        distance: j['distance'] ?? '',
        offer: j['offer'] ?? '',
        image: j['image'] ?? '',
        price: (j['price'] is num) ? (j['price'] as num).toDouble() : double.tryParse(j['price'].toString()) ?? 0.0,
        time: j['time'] ?? '',
        type: j['type'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'category': category,
        'rating': rating,
        'distance': distance,
        'offer': offer,
        'image': image,
        'price': price,
        'time': time,
        'type': type,
      };
}
