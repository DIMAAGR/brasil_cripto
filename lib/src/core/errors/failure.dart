abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

class ParsingFailure extends Failure {
  ParsingFailure(super.message);
}

class MaximumReachedFailure extends Failure {
  MaximumReachedFailure(super.message);
}
