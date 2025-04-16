import 'dart:async';

import 'package:brasil_cripto/src/core/constants/routes.dart';
import 'package:brasil_cripto/src/core/theme/theme.dart';
import 'package:brasil_cripto/src/features/search/view_model/search_view_model.dart';
import 'package:brasil_cripto/src/features/shared/view/widgets/favorite_list_tile_button.dart';
import 'package:brasil_cripto/src/features/shared/view/widgets/wait_message.dart';
import 'package:brasil_cripto/src/features/shared/view_model/view_model_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchView extends StatefulWidget {
  final SearchViewModel viewModel;
  final String? search;

  const SearchView({super.key, required this.viewModel, this.search});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    if (widget.search != null && widget.search!.isNotEmpty) {
      widget.viewModel.doSearch(widget.search!);
      widget.viewModel.textEditingController.text = widget.search!;
    }

    widget.viewModel.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final controller = widget.viewModel.scrollController;

    if (controller.position.pixels >= controller.position.maxScrollExtent - 100) {
      if (_debounce?.isActive ?? false) _debounce!.cancel();

      _debounce = Timer(const Duration(milliseconds: 500), () {
        widget.viewModel.doSearch(widget.viewModel.textEditingController.text);
      });
    }
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 1000), () {
      widget.viewModel.searchListIndex = 0;
      widget.viewModel.searchList.clear();
      widget.viewModel.doSearch(value);
    });
  }

  @override
  void dispose() {
    widget.viewModel.scrollController.removeListener(_onScroll);
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pesquisar')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: widget.viewModel.textEditingController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Digite o nome ou símbolo da moeda',
                isDense: true,
                filled: true,
                prefix: const SizedBox(width: 8),
                fillColor: AppTheme.colors(context).input,
                suffixIcon: GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppTheme.colors(context).inputSecondary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.search, color: AppTheme.colors(context).input),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: widget.viewModel.searchState,
            builder: (context, value, _) {
              if ((value is InitialState || value is LoadingState) && widget.viewModel.searchList.isEmpty) {
                return const Center(child: WaitMessage());
              }

              return Expanded(
                child: ListView.separated(
                  controller: widget.viewModel.scrollController,
                  itemCount: widget.viewModel.searchList.length,
                  separatorBuilder: (_, __) => Divider(
                    color: AppTheme.colors(context).inputSecondary,
                    endIndent: 16,
                    indent: 16,
                  ),
                  itemBuilder: (context, index) {
                    final coin = widget.viewModel.searchList[index];
                    return ListTile(
                      onTap: () {
                        Modular.to.pushNamed(
                          AppRoutes.details,
                          arguments: {'id': coin.id},
                        );
                      },
                      leading: Container(
                        height: 48,
                        width: 48,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: CachedNetworkImage(
                          imageUrl: coin.large ?? '',
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
                      title: Text(coin.name ?? ''),
                      subtitle: Text(coin.symbol ?? ''),
                      trailing: FavoriteListTileButton(
                        isFavorite: widget.viewModel.isFavorite,
                        searchResult: coin,
                        onFavoritePressed: (data) async {
                          await widget.viewModel.toggleFavorite(data);
                          setState(() {});
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
