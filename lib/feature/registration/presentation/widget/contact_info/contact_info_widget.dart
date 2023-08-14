import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scf_auth/core/utils/extensions.dart';

import '../../../../../core/components/button/m_button.dart';
import '../../../../../core/components/input/m_input_widget.dart';
import '../../../../../core/components/text/input_label_widget.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/ui_utils.dart';
import '../../../../language/manager/localizatios.dart';
import '../../../../router/app_router.gr.dart';
import '../../cubit/registration_controller_cubit.dart';
import 'address_widget.dart';

@RoutePage()
class ContactInfoWidget extends StatefulWidget {
  const ContactInfoWidget({
    super.key,
  });

  @override
  State<ContactInfoWidget> createState() => _ContactInfoWidgetState();
}

class _ContactInfoWidgetState extends State<ContactInfoWidget> {
  final _mobileController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();

  final _mobileNode = FocusNode();
  final _phoneNode = FocusNode();
  final _emailNode = FocusNode();
  final _websiteNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final state = context.read<RegistrationControllerCubit>().state;
    _mobileController.text = state.mobileNumber;
    _phoneController.text = state.phoneNumber;
    _emailController.text = state.email;
    _websiteController.text = state.website;
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _mobileNode.dispose();
    _phoneNode.dispose();
    _emailNode.dispose();
    _websiteNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 56),
                      _titleWidget,
                      const SizedBox(height: 64),
                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: UiUtils.maxWidth + 48,
                          ),
                          child: _inputListWidget,
                        ),
                      ),
                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: UiUtils.maxWidth,
                          ),
                          child: _addressWidget,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        _actionButtonsWidget,
      ],
    );
  }

  Widget get _titleWidget => Builder(
        builder: (context) => SizedBox(
          width: double.infinity,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: Strings.of(context).contact_info_title1),
                TextSpan(
                  text: Strings.of(context).contact_info_title2,
                  style: const TextStyle(
                    color: MColors.primaryColor,
                  ),
                )
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: Fonts.regular400,
              fontFamily: Fonts.yekan,
              color: MColors.textColorOf(context),
            ),
          ),
        ),
      );

  Widget get _inputListWidget => Builder(
        builder: (context) => Wrap(
          spacing: 86,
          runSpacing: 40,
          children: [
            _mobileWidget,
            _phoneWidget,
            _emailWidget,
            _websiteWidget,
          ],
        ),
      );

  Widget get _mobileWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.showError != current.showError) ||
            (previous.mobileNumber != current.mobileNumber),
        builder: (context, state) => ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: UiUtils.maxInputSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabelWidget(
                Strings.of(context).mobile_label,
                hasError: state.showError && state.invalidMobile,
              ),
              const SizedBox(height: 18),
              MInputWidget(
                controller: _mobileController,
                focusNode: _mobileNode,
                nextFocusNode: _phoneNode,
                keyboardType: TextInputType.phone,
                autofillHints: const [AutofillHints.telephoneNumber],
                hint: Strings.of(context).mobile_hint,
                onTextChange:
                    context.read<RegistrationControllerCubit>().updateMobile,
                error: () {
                  if (!state.showError || !state.invalidMobile) {
                    return null;
                  }
                  if (state.mobileNumber.isEmpty) {
                    return Strings.of(context).empty_mobile_error;
                  }
                  return Strings.of(context).invalid_mobile_error;
                }(),
                maxLength: 13,
                closeKeyboardOnFinish: false,
              ),
            ],
          ),
        ),
      );

  Widget get _phoneWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.showError != current.showError) ||
            (previous.phoneNumber != current.phoneNumber),
        builder: (context, state) => ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: UiUtils.maxInputSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabelWidget(
                Strings.of(context).phone_label,
                hasError: state.showError && state.invalidPhone,
              ),
              const SizedBox(height: 18),
              MInputWidget(
                controller: _phoneController,
                focusNode: _phoneNode,
                nextFocusNode: _emailNode,
                keyboardType: TextInputType.phone,
                autofillHints: const [AutofillHints.telephoneNumberNational],
                hint: Strings.of(context).phone_hint,
                onTextChange:
                    context.read<RegistrationControllerCubit>().updatePhone,
                error: () {
                  if (!state.showError || !state.invalidPhone) {
                    return null;
                  }
                  return Strings.of(context).empty_phone_error;
                }(),
                maxLength: 11,
                closeKeyboardOnFinish: false,
              ),
            ],
          ),
        ),
      );

  Widget get _emailWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.showError != current.showError) ||
            (previous.email != current.email),
        builder: (context, state) => ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: UiUtils.maxInputSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabelWidget(
                Strings.of(context).email_label,
                hasError: state.showError && state.invalidEmail,
              ),
              const SizedBox(height: 18),
              MInputWidget(
                controller: _emailController,
                focusNode: _emailNode,
                nextFocusNode: _websiteNode,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                hint: Strings.of(context).email_hint,
                onTextChange:
                    context.read<RegistrationControllerCubit>().updateEmail,
                error: () {
                  if (!state.showError || !state.invalidEmail) {
                    return null;
                  }
                  if (state.email.isEmpty) {
                    return Strings.of(context).empty_email_error;
                  }
                  return Strings.of(context).wrong_email_error;
                }(),
              ),
            ],
          ),
        ),
      );

  Widget get _websiteWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.showError != current.showError) ||
            (previous.website != current.website),
        builder: (context, state) => ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: UiUtils.maxInputSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabelWidget(
                Strings.of(context).website_label,
                hasError: state.showError && state.invalidWebsite,
              ),
              const SizedBox(height: 18),
              MInputWidget(
                controller: _websiteController,
                focusNode: _websiteNode,
                keyboardType: TextInputType.url,
                autofillHints: const [AutofillHints.url],
                hint: Strings.of(context).website_hint,
                onTextChange:
                    context.read<RegistrationControllerCubit>().updateWebsite,
                error: () {
                  if (!state.showError || !state.invalidWebsite) {
                    return null;
                  }
                  if (state.website.isEmpty) {
                    return Strings.of(context).empty_website_error;
                  }
                  return Strings.of(context).wrong_website_error;
                }(),
              ),
            ],
          ),
        ),
      );

  // Widget get _provinceCityWidget => Builder(
  //       builder: (context) => Wrap(
  //         spacing: 86,
  //         runSpacing: 40,
  //         children: [
  //           _provinceWidget,
  //           _cityWidget,
  //         ],
  //       ),
  //     );

  Widget get _addressWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.address != current.address) ||
            previous.showError != current.showError,
        builder: (context, state) {
          final items = state.address;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List.generate(
                  items.length,
                  (index) => AddressWidget(
                        hasDivider:
                            index < items.length - 1 || state.canAddAddress,
                        address: items[index].address,
                        hasLabel: index == 0,
                        onAddressChange: (address) => context
                            .read<RegistrationControllerCubit>()
                            .updateAddressAddressAt(index, address),
                        province: items[index].province,
                        city: items[index].city,
                        lat: items[index].lat,
                        lng: items[index].lng,
                        onChangeCity: (city) => context
                            .read<RegistrationControllerCubit>()
                            .updateAddressCityAt(index, city),
                        onChangeLatLng: (lat, lng) => context
                            .read<RegistrationControllerCubit>()
                            .updateAddressLatLngAt(index, lat, lng),
                        onProvinceChange: (province) => context
                            .read<RegistrationControllerCubit>()
                            .updateAddressProvinceAt(index, province),
                        error: () {
                          if (!state.showError ||
                              !state.invalidAddress ||
                              items[index].isValidAddress) {
                            return null;
                          }
                          return Strings.of(context).empty_address_error;
                        }(),
                        provinceError: () {
                          if (!state.showError ||
                              !state.invalidAddress ||
                              items[index].isValidProvince) {
                            return null;
                          }
                          return Strings.of(context).empty_province_error;
                        }(),
                        cityError: () {
                          if (!state.showError ||
                              !state.invalidAddress ||
                              items[index].isValidCity) {
                            return null;
                          }
                          return Strings.of(context).empty_city_error;
                        }(),
                        onDelete: index == 0
                            ? null
                            : () => context
                                .read<RegistrationControllerCubit>()
                                .deleteAddress(index),
                      )),
              _addAddressButtonWidget,
            ],
          );
        },
      );

  Widget get _addAddressButtonWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.canAddAddress != current.canAddAddress) ||
            (previous.address != current.address),
        builder: (context, state) => SizedBox(
          width: UiUtils.maxInputSize,
          child: AnimatedCrossFade(
            duration: UiUtils.duration,
            sizeCurve: UiUtils.curve,
            firstCurve: UiUtils.curve,
            secondCurve: UiUtils.curve,
            crossFadeState: state.canAddAddress
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: MButtonWidget.textWithIcon(
                onClick: _onAddMoreAdressClick,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 10,
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
                          Fonts.plus,
                          size: 12,
                          color: MColors.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        Strings.of(context).add_more_address.replaceFirst('\$0',
                            (state.address.length + 1).toStringValue(context)),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: Fonts.regular400,
                          color: MColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            secondChild: const SizedBox(width: UiUtils.maxInputSize),
          ),
        ),
      );

  Widget get _actionButtonsWidget => Builder(
        builder: (context) => Container(
          constraints: const BoxConstraints(maxWidth: UiUtils.maxWidth),
          padding: const EdgeInsets.only(bottom: 56, top: 24),
          child: Wrap(
            spacing: 86,
            runSpacing: 40,
            children: [
              _backButtonWidget,
              _nextButtonWidget,
            ],
          ),
        ),
      );

  Widget get _nextButtonWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) => previous.isEnable != current.isEnable,
        builder: (context, state) => MButtonWidget(
          onClick: _onContactInfoNextClick,
          title: Strings.of(context).next_step_label,
          width: UiUtils.maxInputSize,
          isEnable: state.isEnable,
        ),
      );

  Widget get _backButtonWidget => Builder(
        builder: (context) => MButtonWidget.outline(
          onClick: _onBackClick,
          title: Strings.of(context).back_step_label,
          width: UiUtils.maxInputSize,
        ),
      );

  void _onBackClick() {
    final state = context.read<RegistrationControllerCubit>().onBackClick();
    if (state == null) return;
    AutoTabsRouter.of(context).setActiveIndex(state.step.index);
    context.replaceRoute(const SuggestedCompanyRoute());
  }

  void _onAddMoreAdressClick() {
    context.read<RegistrationControllerCubit>().addAddress();
  }

  void _onContactInfoNextClick() {
    final state = context.read<RegistrationControllerCubit>().onNextClick();
    if (state == null) return;
    AutoTabsRouter.of(context).setActiveIndex(state.step.index);
    context.replaceRoute(const SuggestedBranchRoute());
  }
}
