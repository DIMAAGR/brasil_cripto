import 'package:brasil_cripto/src/core/data/datasource/local_datasource.dart';
import 'package:brasil_cripto/src/core/data/datasource/remote_datasource.dart';
import 'package:brasil_cripto/src/core/errors/failure.dart';
import 'package:brasil_cripto/src/features/shared/models/search_model.dart';
import 'package:brasil_cripto/src/features/shared/repositories/search/search_repository.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl implements SearchRepository {
  final RemoteDatasource _remote;
  final LocalDatasource _local;

  SearchRepositoryImpl(this._remote, this._local);

  @override
  Future<Either<Failure, List<SearchModel>>> search(String query, String oldQuery, [int index = 0]) async {
    try {
      final localResult = await _local.getSearchPaged(query, startIndex: index, limit: 10);
      if (localResult.isNotEmpty && localResult.length >= 5) {
        final models = localResult.map((e) => SearchModel.fromJson(e)).toList();
        return Right(models);
      }

      if (query != oldQuery) {
        final remoteResult = await _remote.search(query);

        return remoteResult.fold(
          (error) => Left(error),
          (success) async {
            await _local.saveSearch(success);
            return Right(success.map((e) => SearchModel.fromJson(e)).toList());
          },
        );
      } else {
        return Left(MaximumReachedFailure('Máximo Alcançado'));
      }
    } catch (e) {
      return Left(ParsingFailure('Erro inesperado ao buscar moedas'));
    }
  }
}
