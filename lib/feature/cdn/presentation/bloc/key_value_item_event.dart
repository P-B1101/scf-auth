part of 'key_value_item_bloc.dart';

sealed class KeyValueItemEvent extends Equatable {
  const KeyValueItemEvent();

  @override
  List<Object> get props => [];
}

final class GetKeyValueItemEvent extends KeyValueItemEvent {
  final CDNRequestType requestType;

  const GetKeyValueItemEvent({
    required this.requestType,
  });

  @override
  List<Object> get props => [requestType];
}