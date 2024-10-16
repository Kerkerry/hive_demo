import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  const Failure({required this.statusCode, required this.message});
  final int? statusCode;
  final String? message;

  @override
  List<Object?> get props => [message, statusCode];
}
