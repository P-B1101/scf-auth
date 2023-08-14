part of 'drop_down_controller_cubit.dart';

class DropDownControllerState<T> extends Equatable {
  final T? selectedItem;
  final List<T> items;
  final bool isOpen;
  const DropDownControllerState({
    required this.items,
    required this.selectedItem,
    required this.isOpen,
  });

  @override
  List<Object?> get props => [items, selectedItem, isOpen];
}
