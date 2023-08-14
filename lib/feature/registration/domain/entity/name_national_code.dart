import 'package:equatable/equatable.dart';
import 'package:scf_auth/core/utils/extensions.dart';

class NameNationalCode extends Equatable {
  final String name;
  final String nationalCode;

  const NameNationalCode({
    required this.name,
    required this.nationalCode,
  });

  @override
  List<Object?> get props => [name, nationalCode];

  factory NameNationalCode.init() =>
      const NameNationalCode(name: '', nationalCode: '');

  bool get invalidName => name.isEmpty;

  bool get invalidNationalCode => !nationalCode.isValidNationalCode;

  bool get emptyNationalCode => nationalCode.isEmpty;

  NameNationalCode copyWith({
    String? name,
    String? nationalCode,
  }) =>
      NameNationalCode(
        name: name ?? this.name,
        nationalCode: nationalCode ?? this.nationalCode,
      );
}
