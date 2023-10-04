import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/button/close_button_widget.dart';
import '../../../../core/components/button/m_button.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../../dialog/presentation/base_dialog_widget.dart';
import '../../../language/manager/localizatios.dart';
import '../../domain/entity/selected_location.dart';
import 'm_map_widget.dart';

class _Cubit extends Cubit<_State> {
  _Cubit(double? lat, double? lng)
      : super(_State(
          selectedLocation: lat != null && lng != null
              ? SelectedLocation(lat: lat, lng: lng)
              : null,
        ));

  void updateSelectedLocation(double lat, double lng) =>
      emit(_State(selectedLocation: SelectedLocation(lat: lat, lng: lng)));
}

class _State extends Equatable {
  final SelectedLocation? selectedLocation;
  const _State({
    required this.selectedLocation,
  });

  @override
  List<Object?> get props => [selectedLocation];
}

class SelectLocationDialogWidget extends StatelessWidget {
  final double? lat;
  final double? lng;
  final bool isReadOnly;
  const SelectLocationDialogWidget({
    super.key,
    required this.lat,
    required this.lng,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<_Cubit>(
          create: (context) => _Cubit(lat, lng),
        )
      ],
      child: _SelectLocationDialogWidget(isReadOnly: isReadOnly),
    );
  }
}

class _SelectLocationDialogWidget extends StatelessWidget {
  const _SelectLocationDialogWidget({
    Key? key,
    required this.isReadOnly,
  }) : super(key: key);
  final bool isReadOnly;
  @override
  Widget build(BuildContext context) {
    return BaseDialogWidget(
      child: Container(
        width: UiUtils.maxWidth * .75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: MColors.whiteColor,
        ),
        child: _body,
      ),
    );
  }

  Widget get _body => Builder(
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(start: 10, top: 10),
                    child: CloseButtonWidget(color: MColors.primaryColor),
                  ),
                ),
                Center(child: _titleWidget),
              ],
            ),
            _mapWidget,
            const SizedBox(height: 32),
            if (!isReadOnly) _selectButtonWidget,
            const SizedBox(height: 22),
          ],
        ),
      );

  Widget get _titleWidget => Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.only(top: 18, bottom: 18),
          child: Text(
            (isReadOnly)
                ? Strings.of(context).location_title
                : Strings.of(context).select_location_title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: Fonts.medium500,
              color: MColors.primaryTextColor,
            ),
          ),
        ),
      );

  Widget get _mapWidget => Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 56),
          child: AspectRatio(
            aspectRatio: 1,
            child: BlocBuilder<_Cubit, _State>(
              builder: (context, state) {
                if (isReadOnly) {
                  return MMapWidget(
                    updateCamera: false,
                    lat: state.selectedLocation?.lat,
                    lng: state.selectedLocation?.lng,
                    // onLocationSelected:
                    //     context.read<_Cubit>().updateSelectedLocation,
                  );
                } //
                else {
                  return MMapWidget(
                    updateCamera: false,
                    lat: state.selectedLocation?.lat,
                    lng: state.selectedLocation?.lng,
                    onLocationSelected:
                        context.read<_Cubit>().updateSelectedLocation,
                  );
                }
              },
            ),
          ),
        ),
      );

  Widget get _selectButtonWidget => BlocBuilder<_Cubit, _State>(
        builder: (context, state) => MButtonWidget(
          onClick: () => Navigator.of(context).pop(state.selectedLocation),
          title: Strings.of(context).submit,
          width: UiUtils.maxInputSize,
          isEnable: state.selectedLocation != null,
        ),
      );
}
