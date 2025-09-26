// BLOC
import 'package:flutter_bloc/flutter_bloc.dart';
import 'favourite_event.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteState(favoriteIndices: {})) {
    on<ToggleFavorite>((event, emit) {
      final updated = Set<int>.from(state.favoriteIndices);
      if (updated.contains(event.index)) {
        updated.remove(event.index);
      } else {
        updated.add(event.index);
      }
      emit(state.copyWith(favoriteIndices: updated));
    });
  }
}