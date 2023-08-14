import 'package:equatable/equatable.dart';

class SelectedLocation extends Equatable {
  final double lat;
  final double lng;

  const SelectedLocation({
    required this.lat,
    required this.lng,
  });

  @override
  List<Object?> get props => [lat, lng];
}
