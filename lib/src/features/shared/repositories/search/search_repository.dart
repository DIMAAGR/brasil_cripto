import 'package:brasil_cripto/src/core/errors/failure.dart';
import 'package:brasil_cripto/src/features/shared/models/search_model.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<SearchModel>>> search(String query, String oldQuery, [int index]);
}
