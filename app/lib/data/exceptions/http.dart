import 'base.dart';

class BadRequestException extends AppException {
  int get statusCode => 400;

  const BadRequestException(String message) : super(message);
}

class UnAuthorizedException extends AppException {
  int get statusCode => 400;

  const UnAuthorizedException(String message) : super(message);
}

class ForbiddenException extends AppException {
  int get statusCode => 400;

  const ForbiddenException(String message) : super(message);
}

class NotFoundException extends AppException {
  int get statusCode => 400;

  const NotFoundException(String message) : super(message);
}

class InternalServerException extends AppException {
  int get statusCode => 400;

  const InternalServerException(String message) : super(message);
}
