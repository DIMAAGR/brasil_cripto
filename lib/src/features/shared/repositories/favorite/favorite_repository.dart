import 'package:brasil_cripto/src/features/shared/models/favorite_model.dart';

abstract class FavoriteRepository {
  Future<void> toggleFavorite(FavoriteModel coin);
  Future<bool> isFavorite(String id);
  Future<List<FavoriteModel>> getFavorites();
}
