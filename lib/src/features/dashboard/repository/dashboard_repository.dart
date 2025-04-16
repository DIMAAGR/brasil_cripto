import 'package:brasil_cripto/src/core/errors/failure.dart';
import 'package:brasil_cripto/src/features/dashboard/models/search_model.dart';
import 'package:dartz/dartz.dart';

abstract class DashboardRepository {
  Future<Either<Failure, List<SearchModel>>> search(String query, String oldQuery, [int index]);
}
