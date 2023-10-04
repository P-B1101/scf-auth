import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scf_auth/feature/registration/presentation/cubit/registration_controller_cubit.dart';
import 'package:scf_auth/feature/registration/presentation/widget/finalize/edit_title.dart';
import 'package:scf_auth/feature/registration/presentation/widget/finalize/read_only_widgets.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/ui_utils.dart';
import '../../../../language/manager/localizatios.dart';

class AddressContactInfoWidget extends StatelessWidget {
  const AddressContactInfoWidget({
    super.key,
    required this.onAddressContactEditClick,
    required this.onWatchingLocationClick,
  });

  final Function() onAddressContactEditClick;
  final Function() onWatchingLocationClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EditTitle(
          title: Strings.of(context).address_and_contact_info,
          onEditClick: onAddressContactEditClick,
        ),
        const SizedBox(height: 68),
        BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
          builder: (context, state) {
            return SizedBox(
              width: UiUtils.maxWidth,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      runSpacing: 40,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        //شماره موبایل
                        ReadOnlyWidgets(
                          label: Strings.of(context).mobile_label,
                          hintTxt: Strings.of(context).mobile_label,
                          value: state.mobileNumber,
                        ),
                        //شماره ثابت
                        ReadOnlyWidgets(
                          label: Strings.of(context).phone_label,
                          hintTxt: Strings.of(context).phone_label,
                          value: state.phoneNumber,
                        ),
                        // ایمیل
                        ReadOnlyWidgets(
                          label: Strings.of(context).email_label,
                          hintTxt: Strings.of(context).email_label,
                          value: state.email,
                        ),
                        //وبسایت
                        ReadOnlyWidgets(
                          label: Strings.of(context).website_label,
                          hintTxt: Strings.of(context).website_label,
                          value: state.website,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 38),
                  const Divider(
                    color: MColors.primaryColor,
                  ),
                  const SizedBox(height: 23),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.address.length,
                    separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsetsDirectional.only(top: 14, bottom: 38),
                      child: Divider(color: MColors.primaryColor),
                    ),
                    itemBuilder: ((context, index) => Wrap(
                          runSpacing: 40,
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            //استان
                            ReadOnlyWidgets(
                              label: Strings.of(context).province_label,
                              hintTxt: Strings.of(context).province_label,
                              value: state.address[index].province?.title,
                            ),
                            //شهر
                            ReadOnlyWidgets(
                              label: Strings.of(context).city_label,
                              hintTxt: Strings.of(context).city_label,
                              value: state.address[index].city?.title,
                            ),
                            //آدرس
                            ReadOnlyWidgets(
                              label: Strings.of(context).address_label,
                              hintTxt: Strings.of(context).address_label,
                              value: state.address[index].address,
                              isLong: true,
                            ),
                            const SizedBox(height: 15),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: onWatchingLocationClick,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Fonts.location,
                                      color: MColors.primaryColor,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      Strings.of(context).watching_location,
                                      style: const TextStyle(
                                        color: MColors.primaryColor,
                                        fontSize: 16,
                                        fontWeight: Fonts.regular400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
