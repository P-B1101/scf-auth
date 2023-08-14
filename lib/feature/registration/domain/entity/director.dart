import 'package:equatable/equatable.dart';
import 'package:scf_auth/core/utils/enums.dart';
import 'package:scf_auth/core/utils/extensions.dart';

class Director extends Equatable {
  final String name;
  final String nationalCode;
  final Position position;

  const Director({
    required this.name,
    required this.nationalCode,
    required this.position,
  });

  @override
  List<Object?> get props => [
        name,
        nationalCode,
        position,
      ];

  factory Director.boardMember() => const Director(
        name: '',
        nationalCode: '',
        position: Position.member,
      );

  factory Director.ceo() => const Director(
        name: '',
        nationalCode: '',
        position: Position.ceo,
      );

  bool get invalidName => name.isEmpty;

  bool get invalidNationalCode => !nationalCode.isValidNationalCode;

  bool get emptyNationalCode => nationalCode.isEmpty;

  Director copyWith({
    String? name,
    String? nationalCode,
  }) =>
      Director(
        name: name ?? this.name,
        nationalCode: nationalCode ?? this.nationalCode,
        position: position,
      );
}
