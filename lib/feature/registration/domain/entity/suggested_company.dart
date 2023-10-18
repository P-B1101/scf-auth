import 'package:equatable/equatable.dart';

class SuggestedCompany extends Equatable {
  final String name;
  final String nationalId;
  final int? annualFinancialInteractionAmount;

  const SuggestedCompany({
    required this.nationalId,
    required this.annualFinancialInteractionAmount,
    required this.name,
  });

  @override
  List<Object?> get props => [
        name,
        nationalId,
        annualFinancialInteractionAmount,
      ];

  factory SuggestedCompany.init() => const SuggestedCompany(
        nationalId: '',
        annualFinancialInteractionAmount: null,
        name: '',
      );

  bool get invalidName => name.isEmpty;
  bool get invalidEconomicId => nationalId.isEmpty || getEconomicId == null;
  bool get invalidFinancialIteraction => annualFinancialInteractionAmount == null;

  int? get getEconomicId => int.tryParse(nationalId);

  SuggestedCompany copyWith({
    String? name,
    String? nationalId,
  }) =>
      SuggestedCompany(
        nationalId: nationalId ?? this.nationalId,
        annualFinancialInteractionAmount: annualFinancialInteractionAmount,
        name: name ?? this.name,
      );

  SuggestedCompany updateFinancialInteraction(int? financialInteraction) =>
      SuggestedCompany(
        nationalId: nationalId,
        annualFinancialInteractionAmount: financialInteraction,
        name: name,
      );
}
