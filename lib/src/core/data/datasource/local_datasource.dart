import 'dart:convert';

import 'package:hive_ce/hive.dart';

/// Classe responsável por gerenciar o cache local.

class LocalDatasource {
  static const String coinCacheBoxName = 'crypto_cache';
  static const String detaislCacheBoxName = 'details_cache';
  static const String favoriteBoxName = 'favorite_coins';
  static const String shardPrefix = 'coins_cache_';
  static const int maxItemsPerShard = 50;
  static const int minResults = 5;

  /// Busca no cache local as moedas que correspondam à consulta [query].
  ///
  /// A busca é realizada nos shards armazenados, filtrando os resultados pelos campos "name" e "symbol".
  /// Retorna uma lista de mapas contendo os dados das moedas encontradas.
  Future<List<Map<String, dynamic>>> getSearchPaged(
    String query, {
    int startIndex = 0,
    int limit = 25,
  }) async {
    final box = await Hive.openBox('crypto_cache');
    final allKeys = box.keys.where((k) => k.toString().startsWith('coins_cache_')).toList()..sort();

    List<Map<String, dynamic>> results = [];
    int currentIndex = 0;
    int collected = 0;

    for (final key in allKeys) {
      final raw = box.get(key);
      if (raw == null || raw is! List) continue;

      final shard = raw.map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(jsonDecode(e))).toList();

      for (final item in shard) {
        final name = (item['name'] as String).toLowerCase();
        final symbol = (item['symbol'] as String).toLowerCase();

        final matches = name.contains(query.toLowerCase()) || symbol.contains(query.toLowerCase());

        if (matches) {
          if (currentIndex >= startIndex) {
            results.add(item);
            collected++;
            if (collected >= limit) return results;
          }
          currentIndex++;
        }
      }
    }
    return results;
  }

  /// Salva a lista de moedas [coins] no cache local.
  ///
  /// As moedas são divididas em shards, cada um contendo até [maxItemsPerShard] itens.
  /// Após o salvamento, shards antigos que excedem o índice atual são removidos.
  Future<void> saveSearch(List<Map<String, dynamic>> coins) async {
    final box = await Hive.openBox(coinCacheBoxName);
    int shardIndex = 0;

    for (int i = 0; i < coins.length; i += maxItemsPerShard) {
      final shard = coins.skip(i).take(maxItemsPerShard).toList();
      final encoded = shard.map(jsonEncode).toList();

      await box.put('$shardPrefix$shardIndex', encoded);
      shardIndex++;
    }

    final existingKeys = box.keys.where((k) => k.toString().startsWith(shardPrefix)).toList();

    for (final key in existingKeys) {
      final index = int.tryParse(key.toString().replaceFirst(shardPrefix, '')) ?? -1;
      if (index >= shardIndex) {
        await box.delete(key);
      }
    }
  }

  /// Remove todos os shards do cache local relacionados às pesquisas de moedas.
  ///
  /// Esta operação limpa o cache, excluindo todas as chaves que iniciam com o prefixo definido.
  Future<void> deleteSearch() async {
    final box = await Hive.openBox(coinCacheBoxName);
    final allKeys = box.keys.where((k) => k.toString().startsWith(shardPrefix)).toList();

    for (final key in allKeys) {
      await box.delete(key);
    }
  }

  Future<void> saveDetails(String id, Map<String, dynamic> data) async {
    final box = await Hive.openBox(detaislCacheBoxName);
    await box.put(id, jsonEncode(data));
  }

  Future<Map<String, dynamic>> getDetail(String id) async {
    final box = await Hive.openBox(detaislCacheBoxName);
    final raw = await box.get(id);
    if (raw == null) {
      return {};
    }

    return Map<String, dynamic>.from(jsonDecode(raw));
  }

  Future<void> saveFavorite(Map<String, dynamic> coinJson) async {
    final box = await Hive.openBox(favoriteBoxName);
    await box.put(coinJson['id'], jsonEncode(coinJson));
  }

  Future<void> removeFavorite(String id) async {
    final box = await Hive.openBox(favoriteBoxName);
    await box.delete(id);
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final box = await Hive.openBox(favoriteBoxName);
    return box.values.map((e) => Map<String, dynamic>.from(jsonDecode(e))).toList();
  }

  Future<void> clearAllFavorites() async {
    final box = await Hive.openBox(favoriteBoxName);
    box.clear();
  }
}
