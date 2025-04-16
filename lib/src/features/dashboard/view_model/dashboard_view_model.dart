import 'package:brasil_cripto/src/core/errors/failure.dart';
import 'package:brasil_cripto/src/features/shared/models/search_model.dart';
import 'package:brasil_cripto/src/features/shared/models/favorite_model.dart';
import 'package:brasil_cripto/src/features/shared/repositories/favorite/favorite_repository.dart';
import 'package:brasil_cripto/src/features/shared/repositories/search/search_repository.dart';
import 'package:brasil_cripto/src/features/shared/view_model/view_model_state.dart';
import 'package:flutter/material.dart';

class DashboardViewModel {
  final SearchRepository _searchRepository;
  final FavoriteRepository _favoriteRepository;

  DashboardViewModel(this._searchRepository, this._favoriteRepository);

  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  ValueNotifier<ViewModelState<Failure, List<SearchModel>>> searchState = ValueNotifier(InitialState());
  ValueNotifier<ViewModelState<Failure, List<FavoriteModel>?>> favoriteState = ValueNotifier(InitialState());

  int favoriteLenght = 0;
  int searchListIndex = 0;
  List<SearchModel> searchList = [];
  String _oldQuery = '';

  Future<void> doSearch(String query) async {
    searchState.value = LoadingState();

    if (query.isEmpty) {
      searchList = [];
      searchState.value = InitialState();
      return;
    }

    final result = await _searchRepository.search(query, _oldQuery, searchList.length);

    searchState.value = result.fold(
      (e) => ErrorState(e),
      (s) {
        final newItems = s
            .where(
              (item) => !searchList.any((existing) => existing.id == item.id),
            )
            .toList();

        searchList += newItems;
        _oldQuery = query;
        return SuccessState(searchList);
      },
    );
  }

  Future<void> toggleFavorite(FavoriteModel model) async {
    favoriteState.value = LoadingState();
    await _favoriteRepository.toggleFavorite(model);
    await getFavorites();
  }

  Future<bool> isFavorite(String id) {
    return _favoriteRepository.isFavorite(id);
  }

  Future<void> getFavorites() async {
    final result = await _favoriteRepository.getFavorites();
    favoriteLenght = result.length;
    favoriteState.value = SuccessState(null);
  }

  void clear() {
    searchList = [];
    searchController.text = '';
    getFavorites();
  }
}
