import 'package:equatable/equatable.dart';

class BranchInfo extends Equatable {
  final String id;
  final String? title;
  final double? lat;
  final double? lng;

  const BranchInfo({
    required this.id,
    required this.title,
    required this.lat,
    required this.lng,
  });

  @override
  List<Object?> get props => [id, title, lat, lng];
}
