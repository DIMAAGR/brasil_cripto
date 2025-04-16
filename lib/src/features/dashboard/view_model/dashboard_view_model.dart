import 'package:brasil_cripto/src/core/errors/failure.dart';
import 'package:brasil_cripto/src/features/dashboard/models/search_model.dart';
import 'package:brasil_cripto/src/features/dashboard/repository/dashboard_repository.dart';
import 'package:brasil_cripto/src/features/dashboard/view_model/dashboard_view_model_state.dart';
import 'package:flutter/material.dart';

class DashboardViewModel {
  final DashboardRepository _repository;

  DashboardViewModel(this._repository);

  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  ValueNotifier<DashboardViewModelState<Failure, List<SearchModel>>> searchState = ValueNotifier(InitialState());
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

    final result = await _repository.search(query, _oldQuery, searchListIndex);

    searchState.value = result.fold(
      (e) => ErrorState(e),
      (s) {
        searchListIndex += 10;

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
}
