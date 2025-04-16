import 'package:brasil_cripto/src/core/data/datasource/local_datasource.dart';
import 'package:brasil_cripto/src/features/shared/models/favorite_model.dart';
import 'package:brasil_cripto/src/features/shared/repositories/favorite/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final LocalDatasource _local;

  FavoriteRepositoryImpl(this._local);

  @override
  Future<void> toggleFavorite(FavoriteModel coin) async {
    final favorites = await getFavorites();
    final exists = favorites.any((e) => e.id == coin.id);

    if (exists) {
      await _local.removeFavorite(coin.id);
    } else {
      await _local.saveFavorite(coin.toJson());
    }
  }

  @override
  Future<List<FavoriteModel>> getFavorites() async {
    final rawList = await _local.getFavorites();
    return rawList.map((e) => FavoriteModel.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  @override
  Future<bool> isFavorite(String id) async {
    final favorites = await getFavorites();
    return favorites.any((e) => e.id == id);
  }
}
