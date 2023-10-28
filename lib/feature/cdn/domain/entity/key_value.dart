import 'package:equatable/equatable.dart';

class KeyValue extends Equatable {
  final String? id;
  final String? title;

  const KeyValue({
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props => [id, title];
}
