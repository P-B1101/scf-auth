import 'package:equatable/equatable.dart';

class ProvinceCity extends Equatable {
  final String id;
  final String title;
  final List<ProvinceCity> cities;

  const ProvinceCity({
    required this.id,
    required this.title,
    required this.cities,
  });

  @override
  List<Object?> get props => [id, title, cities];
}
