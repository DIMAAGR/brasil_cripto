import 'dart:async';

import 'package:brasil_cripto/src/core/data/datasource/local_datasource.dart';
import 'package:brasil_cripto/src/core/data/datasource/remote_datasource.dart';
import 'package:brasil_cripto/src/core/errors/failure.dart';
import 'package:brasil_cripto/src/features/details/models/details_model.dart';
import 'package:brasil_cripto/src/features/details/repository/details_repository.dart';
import 'package:dartz/dartz.dart';

class DetailsRepositoryImpl implements DetailsRepository {
  final LocalDatasource _local;
  final RemoteDatasource _remote;

  DetailsRepositoryImpl(this._local, this._remote);

  @override
  Future<Either<Failure, DetailsModel>> getDetailsLocal(String id) async {
    try {
      final localResult = await _local.getDetail(id);
      if (localResult.isEmpty) {
        return Left(CacheFailure("Dados não encontrados no cache."));
      }
      return Right(DetailsModel.fromJson(localResult));
    } catch (e) {
      return Left(CacheFailure("Erro ao acessar o cache: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, DetailsModel>> getDetailsRemote(String id) async {
    try {
      final remoteResult = await _remote.getCoinDetail(id);

      return remoteResult.fold((e) => Left(e), (s) {
        _local.saveDetails(id, s);
        return Right(DetailsModel.fromJson(s));
      });
    } catch (e) {
      return Left(ServerFailure("Erro inesperado: ${e.toString()}"));
    }
  }
}
