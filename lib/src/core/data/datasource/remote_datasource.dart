import 'package:brasil_cripto/src/core/data/service/api_service.dart';
import 'package:brasil_cripto/src/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

class RemoteDatasource {
  final ApiService _api;

  RemoteDatasource(this._api);

  Future<Either<Failure, List<Map<String, dynamic>>>> search(String query) async {
    try {
      final response = await _api.get(
        '/search',
        queryParameters: {
          'query': query,
        },
      );

      final coins = (response.data['coins'] as List).map((e) => Map<String, dynamic>.from(e)).toList();

      return Right(coins);
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        return Left(NetworkFailure('Sem conexão com a internet.'));
      }
      return Left(ServerFailure('Erro ao buscar criptomoedas. ${e.toString()}'));
    }
  }
}
