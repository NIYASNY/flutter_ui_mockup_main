// EVENTS
abstract class FavoriteEvent {}

class ToggleFavorite extends FavoriteEvent {
  final int index;
  ToggleFavorite(this.index);
}

// STATE
class FavoriteState {
  final Set<int> favoriteIndices;
  FavoriteState({required this.favoriteIndices});

  FavoriteState copyWith({Set<int>? favoriteIndices}) {
    return FavoriteState(
      favoriteIndices: favoriteIndices ?? this.favoriteIndices,
    );
  }
}