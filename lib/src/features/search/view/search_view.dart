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
  @override
  void initState() {
    if (widget.search != null && widget.search!.isNotEmpty) {
      widget.viewModel.doSearch(widget.search!);
      widget.viewModel.textEditingController.text = widget.search!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: widget.viewModel.textEditingController,
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
          ),
          ValueListenableBuilder(
            valueListenable: widget.viewModel.searchState,
            builder: (context, value, __) {
              if (value is InitialState && widget.viewModel.searchList.isEmpty || value is LoadingState && widget.viewModel.searchList.isEmpty) {
                return const Center(
                  child: WaitMessage(),
                );
              } else {
                return Expanded(
                  child: ListView.separated(
                    itemCount: widget.viewModel.searchList.length,
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
                              arguments: {'id': widget.viewModel.searchList[index].id},
                            );
                          },
                          leading: Container(
                            height: 48,
                            width: 48,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: widget.viewModel.searchList[index].large ?? '',
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
                          title: Text(widget.viewModel.searchList[index].name ?? ''),
                          subtitle: Text(widget.viewModel.searchList[index].symbol ?? ''),
                          trailing: ValueListenableBuilder(
                              valueListenable: widget.viewModel.searchState,
                              builder: (context, value, _) {
                                return FavoriteListTileButton(
                                  isFavorite: widget.viewModel.isFavorite,
                                  searchResult: widget.viewModel.searchList[index],
                                  onFavoritePressed: (data) async {
                                    await widget.viewModel.toggleFavorite(data);
                                    setState(() {});
                                  },
                                );
                              }));
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
