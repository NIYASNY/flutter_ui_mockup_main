import 'package:flutter_riverpod/legacy.dart';

// store product ids that are favorited
final favoriteProvider = StateProvider<Set<String>>((ref) => <String>{});
