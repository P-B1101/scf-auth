import 'package:equatable/equatable.dart';

class SignUpResponse extends Equatable {
  final String trackingId;
  const SignUpResponse({
    required this.trackingId,
  });

  @override
  List<Object?> get props => [trackingId];
}
