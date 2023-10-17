import 'package:equatable/equatable.dart';

class Error extends Equatable {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

class ErrorModel extends Error {
  const ErrorModel({
    required String message,
  }) : super(
          message: message,
        );

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        message: json['localeExceptionMessage'] ?? '',
      );
}
