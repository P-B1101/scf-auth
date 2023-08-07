import 'package:equatable/equatable.dart';

class MBaseResponse<T> extends Equatable {
  final String message;
  final T data;

  const MBaseResponse({
    required this.data,
    required this.message,
  });

  @override
  List<Object?> get props => [message, data];
}
