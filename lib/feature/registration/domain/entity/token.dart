import 'package:equatable/equatable.dart';

class Token extends Equatable {
  final DateTime? issuedAt;
  final DateTime? expiredAt;
  final String token;

  const Token({
    required this.token,
    required this.expiredAt,
    required this.issuedAt,
  });

  @override
  List<Object?> get props => [
        token,
        issuedAt?.toIso8601String(),
        expiredAt?.toIso8601String(),
      ];

  Duration? get getDuration {
    if (issuedAt == null) return null;
    if (expiredAt == null) return null;
    return expiredAt!.difference(issuedAt!).abs();
  }
}
