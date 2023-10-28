import 'package:equatable/equatable.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/utils/extensions.dart';

class Director extends Equatable {
  final String name;
  final String nationalCode;
  final Position? position;
  final Jalali? birthDate;

  const Director({
    required this.name,
    required this.nationalCode,
    required this.position,
    required this.birthDate,
  });

  @override
  List<Object?> get props => [
        name,
        nationalCode,
        position,
        birthDate,
      ];

  factory Director.boardMember() => const Director(
        name: '',
        nationalCode: '',
        position: Position.member,
        birthDate: null,
      );

  factory Director.ceo() => const Director(
        name: '',
        nationalCode: '',
        position: Position.ceo,
        birthDate: null,
      );

  bool get invalidName => name.isEmpty;

  bool get invalidNationalCode => !nationalCode.isValidNationalCode;

  bool get emptyNationalCode => nationalCode.isEmpty;

  bool get invalidBirthDate => birthDate == null;

  bool get isCeo => position == Position.ceo;

  Director copyWith({
    String? name,
    String? nationalCode,
    Jalali? birthDate,
  }) =>
      Director(
        name: name ?? this.name,
        nationalCode: nationalCode ?? this.nationalCode,
        position: position,
        birthDate: birthDate ?? this.birthDate,
      );
}
