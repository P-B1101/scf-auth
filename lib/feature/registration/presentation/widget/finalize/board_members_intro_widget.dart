import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scf_auth/core/utils/extensions.dart';
import 'package:scf_auth/core/utils/ui_utils.dart';
import 'package:scf_auth/feature/registration/presentation/cubit/registration_controller_cubit.dart';
import 'package:scf_auth/feature/registration/presentation/widget/finalize/edit_title.dart';
import 'package:scf_auth/feature/registration/presentation/widget/finalize/read_only_widgets.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../language/manager/localizatios.dart';

class BoardMembersIntroWidget extends StatelessWidget {
  const BoardMembersIntroWidget({
    super.key,
    required this.onBoardMembersIntroEditClick,
  });

  final Function() onBoardMembersIntroEditClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EditTitle(
          title: Strings.of(context).board_members_introduction,
          onEditClick: onBoardMembersIntroEditClick,
        ),
        const SizedBox(height: 68),
        SizedBox(
          width: UiUtils.maxWidth,
          child: BlocBuilder<RegistrationControllerCubit,
              RegistrationControllerState>(
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      spacing: 8,
                      runSpacing: 24,
                      children: [
                        //نام مدیرعامل
                        ReadOnlyWidgets(
                          label: Strings.of(context).ceo_name_label,
                          hintTxt: Strings.of(context).ceo_name_label,
                          value: state.ceoInfo.name,
                        ),
                        //کدملی مدیرعامل
                        ReadOnlyWidgets(
                          label: Strings.of(context).ceo_national_code_label,
                          hintTxt: Strings.of(context).ceo_national_code_label,
                          value: state.ceoInfo.nationalCode,
                        ),
                        ReadOnlyWidgets(
                          label: Strings.of(context).ceo_birth_date_label,
                          hintTxt: Strings.of(context).ceo_birth_date_label,
                          value: state.ceoInfo.birthDate?.toDateString,
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: 45,
                      bottom: 24,
                    ),
                    child: Divider(color: MColors.primaryColor),
                  ),
                  ListView.separated(
                    separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsetsDirectional.only(
                        top: 45,
                        bottom: 24,
                      ),
                      child: Divider(color: MColors.primaryColor),
                    ),
                    itemCount: state.boardMemberInfo.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      spacing: 8,
                      runSpacing: 24,
                      children: [
                        //نام عضو هیئت میدیره
                        ReadOnlyWidgets(
                          label:
                              "${Strings.of(context).board_member_name_label} ${(index + 1).toStringValue(context)}",
                          hintTxt: Strings.of(context).board_member_name_label,
                          value: state.boardMemberInfo[index].name,
                        ),
                        //کدملی عضو هیئت مدیره
                        ReadOnlyWidgets(
                          label:
                              '${Strings.of(context).board_member_national_code_label} ${(index + 1).toStringValue(context)}',
                          hintTxt: Strings.of(context)
                              .board_member_national_code_label,
                          value: state.boardMemberInfo[index].nationalCode,
                        ),
                        ReadOnlyWidgets(
                          label:
                              '${Strings.of(context).board_member_birth_date_label} ${(index + 1).toStringValue(context)}',
                          hintTxt:
                              Strings.of(context).board_member_birth_date_label,
                          value: state
                              .boardMemberInfo[index].birthDate?.toDateString,
                        ),
                      ],
                    ),
                  ),
                  // ...List.generate(
                  //   state.boardMemberInfo.length,
                  //   (index) => Padding(
                  //     padding: const EdgeInsetsDirectional.only(top: 34),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         //نام عضو هیئت میدیره
                  //         ReadOnlyWidgets(
                  //           label:
                  //               "${Strings.of(context).board_member_name_label} ${(index + 1).toStringValue(context)}",
                  //           hintTxt:
                  //               Strings.of(context).board_member_name_label,
                  //           value: state.boardMemberInfo[index].name,
                  //         ),
                  //         //کدملی عضو هیئت مدیره
                  //         ReadOnlyWidgets(
                  //           label:
                  //               '${Strings.of(context).board_member_national_code_label} ${(index + 1).toStringValue(context)}',
                  //           hintTxt: Strings.of(context)
                  //               .board_member_national_code_label,
                  //           value: state.boardMemberInfo[index].nationalCode,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
