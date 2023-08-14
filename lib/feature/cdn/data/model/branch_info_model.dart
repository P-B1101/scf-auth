import 'package:scf_auth/feature/cdn/domain/entity/branch_info.dart';

class BranchInfoModel extends BranchInfo {
  const BranchInfoModel({
    required super.id,
    required super.lat,
    required super.lng,
    required super.title,
  });

  factory BranchInfoModel.fromJson(Map<String, dynamic> json) =>
      BranchInfoModel(
        id: json['id'],
        lat: json['latitude'],
        lng: json['longitude'],
        title: json['title'],
      );

  factory BranchInfoModel.fromEntity(BranchInfo entity) => BranchInfoModel(
        id: entity.id,
        lat: entity.lat,
        lng: entity.lng,
        title: entity.title,
      );

  Map<String, dynamic> get toJson => {
        'id': id,
        'latitude': lat,
        'longitude': lng,
        'title': title,
      };
}
