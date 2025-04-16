abstract class Failure {
  final String message;
  Failure(this.message);

  @override
  String toString() {
    return message;
  }
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

class TimesUpFailure extends Failure {
  TimesUpFailure(super.message);
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}
