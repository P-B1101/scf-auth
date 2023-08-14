import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'drop_down_controller_state.dart';

class DropDownControllerCubit<T> extends Cubit<DropDownControllerState<T>> {
  DropDownControllerCubit({
    required List<T> items,
    required T? selectedItem,
  }) : super(DropDownControllerState<T>(
          items: items,
          selectedItem: selectedItem,
          isOpen: false,
        ));

  void initializeItems(List<T> items) => emit(DropDownControllerState<T>(
        items: items,
        selectedItem: state.selectedItem,
        isOpen: false,
      ));

  void onSelectedItemChange(T? selectedItem) => emit(DropDownControllerState<T>(
        items: state.items,
        selectedItem: selectedItem,
        isOpen: false,
      ));

  void openDropDown() => emit(DropDownControllerState<T>(
        items: state.items,
        selectedItem: state.selectedItem,
        isOpen: true,
      ));

  void closeDropDown() => emit(DropDownControllerState<T>(
        items: state.items,
        selectedItem: state.selectedItem,
        isOpen: false,
      ));
}
