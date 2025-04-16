import 'dart:async';

import 'package:brasil_cripto/src/core/errors/failure.dart';
import 'package:brasil_cripto/src/features/details/models/details_model.dart';
import 'package:brasil_cripto/src/features/details/repository/details_repository.dart';
import 'package:brasil_cripto/src/features/shared/view_model/view_model_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class DetailsViewModel {
  final DetailsRepository _repository;
  final Connectivity _connectivity;

  ValueNotifier<ViewModelState<Failure, void>> detailsState = ValueNotifier(InitialState());
  DetailsModel? details;

  StreamSubscription? _internetWatcher;
  StreamSubscription? _remoteWatcher;

  DetailsViewModel(this._repository, this._connectivity);

  void stopWatchers() {
    _internetWatcher?.cancel();
    _remoteWatcher?.cancel();
  }

  Future<void> init([String? id]) async {
    detailsState.value = LoadingState();

    final hasConnection = await _hasInternet();

    if (hasConnection) {
      _remoteWatcher?.cancel();
      _startInternetWatcher(id ?? details!.id);
    } else {
      _getFromLocal(id ?? details!.id);
    }
  }

  Future<void> _getFromLocal(String id) async {
    final result = await _repository.getDetailsLocal(id);
    result.fold(
      (e) {
        detailsState.value = ErrorState(e);
      },
      (data) {
        details = data;
        detailsState.value = SuccessState(null);
      },
    );
  }

  Stream<void> _startRemoteWatcher(String id) async* {
    while (await _hasInternet()) {
      final result = await _repository.getDetailsRemote(id);

      result.fold((e) {
        detailsState.value = ErrorState(ServerFailure('Erro ao atualizar dados em tempo real'));
      }, (s) {
        details = s;
        detailsState.value = SuccessState(null);
      });

      await Future.delayed(const Duration(seconds: 60));
    }

    if ((await _hasInternet()) == false) {
      _remoteWatcher?.cancel();
    }
  }

  void _startInternetWatcher(String id) {
    _internetWatcher ??= _connectivity.onConnectivityChanged.listen((result) {
      if (result.first != ConnectivityResult.none) {
        _remoteWatcher = _startRemoteWatcher(id).listen((_) {});
      } else {
        _remoteWatcher?.cancel();
      }
    });
  }

  Future<bool> _hasInternet() async {
    final result = await _connectivity.checkConnectivity();
    return result.first != ConnectivityResult.none;
  }

  void dispose() {
    _remoteWatcher?.cancel();
    _internetWatcher?.cancel();
  }
}
