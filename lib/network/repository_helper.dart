import 'package:dartz/dartz.dart';
import 'package:segundo_parcia_backend/constants.dart';

class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

extension TaskX<T extends Either<Object, U>, U> on Task<T> {
  Task<Either<Failure, U>> mapLeftToFailure() {
    return this.map(
      (either) => either.leftMap((obj) {
        try {
          return obj as Failure;
        } catch (e) {
          return Failure(genericError);
        }
      }),
    );
  }
}