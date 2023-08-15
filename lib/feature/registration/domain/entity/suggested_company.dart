import 'package:equatable/equatable.dart';

class SuggestedCompany extends Equatable {
  final String name;
  final String economicId;
  final int? financialInteraction;

  const SuggestedCompany({
    required this.economicId,
    required this.financialInteraction,
    required this.name,
  });

  @override
  List<Object?> get props => [
        name,
        economicId,
        financialInteraction,
      ];

  factory SuggestedCompany.init() => const SuggestedCompany(
        economicId: '',
        financialInteraction: null,
        name: '',
      );

  bool get invalidName => name.isEmpty;
  bool get invalidEconomicId => economicId.isEmpty || getEconomicId == null;
  bool get invalidFinancialIteraction => financialInteraction == null;

  int? get getEconomicId => int.tryParse(economicId);

  SuggestedCompany copyWith({
    String? name,
    String? economicId,
  }) =>
      SuggestedCompany(
        economicId: economicId ?? this.economicId,
        financialInteraction: financialInteraction,
        name: name ?? this.name,
      );

  SuggestedCompany updateFinancialInteraction(int? financialInteraction) =>
      SuggestedCompany(
        economicId: economicId,
        financialInteraction: financialInteraction,
        name: name,
      );
}
