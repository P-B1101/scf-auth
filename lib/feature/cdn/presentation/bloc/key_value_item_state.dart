part of 'key_value_item_bloc.dart';

sealed class KeyValueItemState extends Equatable {
  final List<KeyValue> items;

  const KeyValueItemState({
    this.items = const [],
  });

  @override
  List<Object?> get props => [items];
}

final class KeyValueItemInitial extends KeyValueItemState {}

final class KeyValueItemLoadingState extends KeyValueItemState {
  const KeyValueItemLoadingState({
    required super.items,
  });
}

final class KeyValueItemSuccessState extends KeyValueItemState {
  const KeyValueItemSuccessState({
    required super.items,
  });
}

final class KeyValueItemFailureState extends KeyValueItemState {
  final String? message;
  const KeyValueItemFailureState({
    this.message,
    required super.items,
  });

  @override
  List<Object?> get props => [items, message];
}
