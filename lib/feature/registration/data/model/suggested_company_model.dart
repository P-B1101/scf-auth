import 'package:scf_auth/feature/registration/domain/entity/suggested_company.dart';

class SuggestedCompanyModel extends SuggestedCompany {
  const SuggestedCompanyModel({
    required super.economicId,
    required super.financialInteraction,
    required super.name,
  });

  factory SuggestedCompanyModel.fromEntity(SuggestedCompany entity) =>
      SuggestedCompanyModel(
        economicId: entity.economicId,
        financialInteraction: entity.financialInteraction,
        name: entity.name,
      );

  Map<String, dynamic> get toJson => {
        'enterpriseFullName': name,
        'economicNationalId': int.tryParse(economicId),
        'annualFinancialInteractionAmount': financialInteraction?.toString(),
      };
}
