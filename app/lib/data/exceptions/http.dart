import 'package:equatable/equatable.dart';

class AppException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const AppException(this.message, this.statusCode);
  
  @override
  List<Object?> get props => [message, statusCode];
}

class BadRequestException extends AppException {
  const BadRequestException(message) : super(message, 400);
}

class UnAuthorizedException extends AppException {
  const UnAuthorizedException(message) : super(message, 401);
}

class ForbiddenException extends AppException {
  const ForbiddenException(message) : super(message, 403);
}

class NotFoundException extends AppException {
  const NotFoundException(message) : super(message, 404);
}

class InternalServerException extends AppException {
  const InternalServerException(message) : super(message, 500);
}
