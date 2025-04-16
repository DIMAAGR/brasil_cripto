import 'package:brasil_cripto/src/core/constants/routes.dart';
import 'package:brasil_cripto/src/core/theme/theme.dart';
import 'package:brasil_cripto/src/features/favorites/view_model/favorite_view_model.dart';
import 'package:brasil_cripto/src/features/shared/models/favorite_model.dart';
import 'package:brasil_cripto/src/features/shared/view/widgets/wait_message.dart';
import 'package:brasil_cripto/src/features/shared/view_model/view_model_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavoriteView extends StatefulWidget {
  final FavoriteViewModel viewModel;
  const FavoriteView({super.key, required this.viewModel});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  void initState() {
    widget.viewModel.getFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: ValueListenableBuilder(
        valueListenable: widget.viewModel.favoriteState,
        builder: (context, value, __) {
          if (value is InitialState && widget.viewModel.favoriteList.isEmpty || value is LoadingState && widget.viewModel.favoriteList.isEmpty) {
            return const Center(
              child: WaitMessage(),
            );
          } else {
            return ListView.separated(
              itemCount: widget.viewModel.favoriteList.length,
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
                      arguments: {'id': widget.viewModel.favoriteList[index].id},
                    );
                  },
                  leading: Container(
                    height: 48,
                    width: 48,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.viewModel.favoriteList[index].larger,
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
                  title: Text(widget.viewModel.favoriteList[index].name),
                  subtitle: Text(widget.viewModel.favoriteList[index].symbol),
                  trailing: IconButton(
                      onPressed: () {
                        widget.viewModel.toggleFavorite(
                          FavoriteModel(
                            id: widget.viewModel.favoriteList[index].id,
                            symbol: widget.viewModel.favoriteList[index].symbol,
                            name: widget.viewModel.favoriteList[index].name,
                            larger: widget.viewModel.favoriteList[index].larger,
                          ),
                        );
                      },
                      icon: const Icon(Icons.delete)),
                );
              },
            );
          }
        },
      ),
    );
  }
}
