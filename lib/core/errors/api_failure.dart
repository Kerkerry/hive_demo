import 'package:buub/core/errors/api_exception.dart';
import 'package:buub/core/errors/failure.dart';

class APIFailure extends Failure {
  const APIFailure({required super.statusCode, required super.message});
  APIFailure.fromException({required APIException e})
      : this(statusCode: e.statusCode, message: e.message);
}
