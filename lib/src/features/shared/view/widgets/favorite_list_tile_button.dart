import 'package:brasil_cripto/src/features/shared/models/favorite_model.dart';
import 'package:brasil_cripto/src/features/shared/models/search_model.dart';
import 'package:flutter/material.dart';

class FavoriteListTileButton extends StatelessWidget {
  const FavoriteListTileButton({
    super.key,
    required this.isFavorite,
    required this.searchResult,
    required this.onFavoritePressed,
  });
  final Future<bool> Function(String id) isFavorite;
  final SearchModel searchResult;
  final Function(FavoriteModel p1)? onFavoritePressed;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: isFavorite(searchResult.id!),
        builder: (context, snap) {
          return IconButton(
              onPressed: () {
                if (onFavoritePressed != null) {
                  onFavoritePressed!(
                    FavoriteModel(
                      id: searchResult.id!,
                      symbol: searchResult.symbol!,
                      name: searchResult.name!,
                      larger: searchResult.large!,
                    ),
                  );
                }
              },
              icon: Icon(
                (snap.data ?? false) ? Icons.star : Icons.star_border,
              ));
        });
  }
}
