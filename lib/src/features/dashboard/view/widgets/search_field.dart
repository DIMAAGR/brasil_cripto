import 'package:brasil_cripto/src/core/constants/routes.dart';
import 'package:brasil_cripto/src/core/theme/theme.dart';
import 'package:brasil_cripto/src/features/shared/models/search_model.dart';
import 'package:brasil_cripto/src/features/shared/models/favorite_model.dart';
import 'package:brasil_cripto/src/features/shared/view/widgets/favorite_list_tile_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchField extends StatelessWidget {
  final Future<bool> Function(String id) isFavorite;
  final Function(String?)? onSaved;
  final VoidCallback getFavorites;
  final Function(String)? onChanged;
  final ScrollController scrollController;
  final TextEditingController controller;
  final Function(FavoriteModel) onFavoritePressed;
  final List<SearchModel>? searchResult;
  final VoidCallback onSearchButtonTap;
  final VoidCallback clear;
  const SearchField({
    super.key,
    this.onSaved,
    required this.controller,
    this.onChanged,
    this.searchResult,
    required this.scrollController,
    required this.onFavoritePressed,
    required this.isFavorite,
    required this.getFavorites,
    required this.onSearchButtonTap,
    required this.clear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: searchResult!.isNotEmpty ? 256 : 48,
      decoration: BoxDecoration(
        color: AppTheme.colors(context).input,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          TextFormField(
            onFieldSubmitted: onSaved,
            onChanged: onChanged,
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Digite o nome ou símbolo da moeda',
              isDense: true,
              filled: true,
              prefix: const SizedBox(width: 8),
              fillColor: AppTheme.colors(context).input,
              suffixIcon: GestureDetector(
                onTap: onSearchButtonTap,
                child: Container(
                  margin: const EdgeInsets.all(6),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppTheme.colors(context).inputSecondary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.search,
                    color: AppTheme.colors(context).input,
                  ),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          if (searchResult!.isNotEmpty)
            SizedBox(
              height: 200,
              child: ListView.separated(
                itemCount: searchResult!.length,
                controller: scrollController,
                separatorBuilder: (_, __) => Divider(
                  color: AppTheme.colors(context).inputSecondary,
                  endIndent: 16,
                  indent: 16,
                ),
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Modular.to.pushNamed(
                        AppRoutes.details,
                        arguments: {'id': searchResult![index].id},
                      ).then((_) {
                        clear();
                      });
                    },
                    leading: Container(
                      height: 48,
                      width: 48,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: searchResult![index].large!,
                        placeholder: (_, __) => Center(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircularProgressIndicator(
                              color: AppTheme.colors(context).inputSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(searchResult![index].name ?? ''),
                    subtitle: Text(searchResult![index].symbol ?? ''),
                    trailing: FavoriteListTileButton(
                      isFavorite: isFavorite,
                      searchResult: searchResult![index],
                      onFavoritePressed: onFavoritePressed,
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
