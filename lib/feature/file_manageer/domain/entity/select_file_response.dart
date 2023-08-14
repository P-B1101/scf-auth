import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class SelectFileResponse extends Equatable {
  final String name;
  final Uint8List file;

  const SelectFileResponse({
    required this.file,
    required this.name,
  });

  @override
  List<Object?> get props => [name, file];
}
