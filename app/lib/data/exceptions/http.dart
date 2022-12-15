import 'base.dart';

class BadRequestException extends AppException {
  int get statusCode => 400;

  const BadRequestException(message) : super(message);
}

class UnAuthorizedException extends AppException {
  int get statusCode => 400;

  const UnAuthorizedException(message) : super(message);
}

class ForbiddenException extends AppException {
  int get statusCode => 400;

  const ForbiddenException(message) : super(message);
}

class NotFoundException extends AppException {
  int get statusCode => 400;

  const NotFoundException(message) : super(message);
}

class InternalServerException extends AppException {
  int get statusCode => 400;

  const InternalServerException(message) : super(message);
}
