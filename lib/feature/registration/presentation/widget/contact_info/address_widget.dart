import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scf_auth/core/components/button/m_button.dart';
import 'package:scf_auth/feature/dialog/manager/dialog_manager.dart';

import '../../../../../core/components/input/m_input_widget.dart';
import '../../../../../core/components/text/input_label_widget.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../cdn/domain/entity/province_city.dart';
import '../../../../cdn/presentation/bloc/province_city_bloc.dart';
import '../../../../drop_down/presentation/widget/m_drop_down_widget.dart';
import '../../../../language/manager/localizatios.dart';

typedef AddressChangeListener = void Function(String address);
typedef ProvinceChangeListener = void Function(ProvinceCity province);
typedef CityChangeListener = void Function(ProvinceCity city);
typedef LatLngChangeListener = void Function(double? lat, double? lng);

class AddressWidget extends StatefulWidget {
  final String address;
  final String? error;
  final AddressChangeListener onAddressChange;
  final ProvinceChangeListener onProvinceChange;
  final CityChangeListener onChangeCity;
  final LatLngChangeListener onChangeLatLng;
  final bool hasLabel;
  final Function()? onDelete;
  final ProvinceCity? province;
  final ProvinceCity? city;
  final String? provinceError;
  final String? cityError;
  final double? lat;
  final double? lng;
  final bool hasDivider;
  const AddressWidget({
    super.key,
    required this.address,
    required this.error,
    required this.hasLabel,
    required this.onAddressChange,
    required this.onDelete,
    required this.onChangeCity,
    required this.onChangeLatLng,
    required this.onProvinceChange,
    required this.city,
    required this.cityError,
    required this.lat,
    required this.lng,
    required this.province,
    required this.provinceError,
    required this.hasDivider,
  });

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  final _controller = TextEditingController();
  final _node = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.address;
  }

  @override
  void dispose() {
    _controller.dispose();
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Wrap(
          spacing: 86,
          children: [
            _provinceWidget,
            _cityWidget,
          ],
        ),
        if (widget.hasLabel) const SizedBox(height: 40),
        if (widget.hasLabel)
          InputLabelWidget(
            Strings.of(context).address_label,
            hasError: _hasError,
          ),
        const SizedBox(height: 18),
        MInputWidget(
          controller: _controller,
          focusNode: _node,
          hint: Strings.of(context).address_hint,
          onTextChange: widget.onAddressChange,
          error: widget.error,
          autofillHints: const [AutofillHints.fullStreetAddress],
          isMultiLine: true,
          height: 90,
          suffixWidget: _hasDelete
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: InkWell(
                      onTap: _onDeleteClick,
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Icon(
                          Fonts.trash,
                          size: 20,
                          color: MColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                )
              : null,
        ),
        const SizedBox(height: 10),
        _actionRowWidget,
        if (widget.hasDivider) const SizedBox(height: 8),
        if (widget.hasDivider) _dividerWidget,
      ],
    );
  }

  Widget get _dividerWidget => Builder(
        builder: (context) => Container(
          height: .5,
          width: double.infinity,
          color: MColors.primaryColor,
        ),
      );

  Widget get _provinceWidget =>
      BlocBuilder<ProvinceCityBloc, ProvinceCityState>(
        builder: (context, bState) => MDropDownWidget<ProvinceCity>(
          items: bState.items,
          titleBuilder: (item) => item?.title,
          selectedItem: widget.province,
          hint: Strings.of(context).province_hint,
          label: widget.hasLabel ? Strings.of(context).province_label : null,
          isLoading: bState is ProvinceCityLoadingState,
          onItemSelected: widget.onProvinceChange,
          error: widget.provinceError,
        ),
      );

  Widget get _cityWidget => BlocBuilder<ProvinceCityBloc, ProvinceCityState>(
        builder: (context, bState) => MDropDownWidget<ProvinceCity>(
          items: widget.province?.cities ?? [],
          titleBuilder: (item) => item?.title,
          selectedItem: widget.city,
          hint: Strings.of(context).city_hint,
          label: widget.hasLabel ? Strings.of(context).city_label : null,
          isLoading: bState is ProvinceCityLoadingState,
          onItemSelected: widget.onChangeCity,
          error: widget.cityError,
        ),
      );

  Widget get _actionRowWidget => Builder(
        builder: (context) => Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _addOrEditLatLng,
            if (_hasLatLng) _deleteLatLng,
            _hasDelete ? _deleteAddress : const SizedBox(width: 100),
          ],
        ),
      );

  Widget get _addOrEditLatLng => Builder(
        builder: (context) => MButtonWidget.textWithIcon(
          onClick: _onAddOrEditLatLngClick,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 5,
              bottom: 10,
              end: 16,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: Icon(
                    Fonts.location,
                    size: 16,
                    color: MColors.primaryColor,
                  ),
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    _hasLatLng
                        ? Strings.of(context).edit_lat_lng
                        : Strings.of(context).add_lat_lng,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: Fonts.regular400,
                      color: MColors.primaryTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget get _deleteLatLng => Builder(
        builder: (context) => MButtonWidget.textWithIcon(
          onClick: _onDeleteLatLngClick,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 5,
              bottom: 10,
              end: 16,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: Icon(
                    Fonts.trash,
                    size: 20,
                    color: MColors.primaryColor,
                  ),
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    Strings.of(context).delete_lat_lng,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: Fonts.regular400,
                      color: MColors.primaryTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget get _deleteAddress => Builder(
        builder: (context) => MButtonWidget.textWithIcon(
          onClick: _onDeleteClick,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 5,
              bottom: 10,
              end: 16,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: Icon(
                    Fonts.trash,
                    size: 22,
                    color: MColors.primaryColor,
                  ),
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    Strings.of(context).delete_address,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: Fonts.regular400,
                      color: MColors.primaryTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void _onDeleteClick() {
    widget.onDelete?.call();
  }

  void _onAddOrEditLatLngClick() async {
    final result = await DialogManager.instance.showSelectLocationDialog(
      context: context,
      lat: widget.lat,
      lng: widget.lng,
    );
    if (result == null || !mounted) return;
    widget.onChangeLatLng(result.lat, result.lng);
  }

  void _onDeleteLatLngClick() {
    widget.onChangeLatLng(null, null);
  }

  bool get _hasError => widget.error != null && widget.error!.isNotEmpty;

  bool get _hasDelete => widget.onDelete != null;

  bool get _hasLatLng => widget.lat != null && widget.lng != null;
}
