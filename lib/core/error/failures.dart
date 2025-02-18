import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String code;

  const Failure({
    required this.message,
    required this.code,
  });

  @override
  List<Object> get props => [message, code];
}

class ServerFailure extends Failure {
  const ServerFailure({
    required String message,
    String code = 'SERVER_ERROR',
  }) : super(message: message, code: code);
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    String message = 'No internet connection',
    String code = 'NETWORK_ERROR',
  }) : super(message: message, code: code);
}

class CacheFailure extends Failure {
  const CacheFailure({
    String message = 'Cache error',
    String code = 'CACHE_ERROR',
  }) : super(message: message, code: code);
} 