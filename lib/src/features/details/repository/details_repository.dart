import 'package:brasil_cripto/src/core/errors/failure.dart';
import 'package:brasil_cripto/src/features/details/models/details_model.dart';
import 'package:dartz/dartz.dart';

abstract class DetailsRepository {
  Future<Either<Failure, DetailsModel>> getDetailsLocal(String id);
  Future<Either<Failure, DetailsModel>> getDetailsRemote(String id);
}
