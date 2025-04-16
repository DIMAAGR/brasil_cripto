import 'package:brasil_cripto/src/core/errors/failure.dart';
import 'package:brasil_cripto/src/features/shared/models/favorite_model.dart';
import 'package:brasil_cripto/src/features/shared/repositories/favorite/favorite_repository.dart';
import 'package:brasil_cripto/src/features/shared/view_model/view_model_state.dart';
import 'package:flutter/material.dart';

class FavoriteViewModel {
  final FavoriteRepository _repository;

  FavoriteViewModel(this._repository);

  ValueNotifier<ViewModelState<Failure, List<FavoriteModel>?>> favoriteState = ValueNotifier(InitialState());
  List<FavoriteModel> favoriteList = [];

  Future<void> toggleFavorite(FavoriteModel model) async {
    favoriteState.value = LoadingState();
    await _repository.toggleFavorite(model);
    await getFavorites();
  }

  Future<bool> isFavorite(String id) {
    return _repository.isFavorite(id);
  }

  Future<void> getFavorites() async {
    final result = await _repository.getFavorites();
    favoriteList = result;
    favoriteState.value = SuccessState(null);
  }
}
