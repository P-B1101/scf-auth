import 'package:scf_auth/feature/registration/domain/entity/suggested_company.dart';

class SuggestedCompanyModel extends SuggestedCompany {
  const SuggestedCompanyModel({
    required super.nationalId,
    required super.annualFinancialInteractionAmount,
    required super.name,
  });

  factory SuggestedCompanyModel.fromEntity(SuggestedCompany entity) =>
      SuggestedCompanyModel(
        nationalId: entity.nationalId,
        annualFinancialInteractionAmount:
            entity.annualFinancialInteractionAmount,
        name: entity.name,
      );

  factory SuggestedCompanyModel.fromJson(Map<String, dynamic> json) =>
      SuggestedCompanyModel(
        annualFinancialInteractionAmount:
            json['annualFinancialInteractionAmount'],
        name: json['businessUnitFullName'],
        nationalId: json['nationalId'],
      );

  Map<String, dynamic> get toJson => {
        'businessUnitFullName': name,
        'nationalId': nationalId,
        'annualFinancialInteractionAmount': annualFinancialInteractionAmount,
      };
}
