import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scf_auth/core/utils/ui_utils.dart';
import 'package:scf_auth/feature/registration/presentation/cubit/registration_controller_cubit.dart';
import 'package:scf_auth/feature/registration/presentation/widget/finalize/edit_title.dart';
import 'package:scf_auth/feature/registration/presentation/widget/finalize/read_only_widgets.dart';

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReadOnlyWidgets(
                        label: Strings.of(context).ceo_name_label,
                        hintTxt: Strings.of(context).ceo_name_label,
                        value: state.ceoInfo.name,
                      ),
                      ReadOnlyWidgets(
                        label: Strings.of(context).ceo_national_code_label,
                        hintTxt: Strings.of(context).ceo_national_code_label,
                        value: state.ceoInfo.nationalCode,
                      ),
                    ],
                  ),
                  const SizedBox(height: 34),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     ReadOnlyWidgets(
                  //       label: Strings.of(context).ceo_name_label,
                  //       hintTxt: Strings.of(context).ceo_name_label,
                  //       value: state.ceoInfo.name,
                  //     ),
                  //     ReadOnlyWidgets(
                  //       label: Strings.of(context).ceo_national_code_label,
                  //       hintTxt: Strings.of(context).ceo_national_code_label,
                  //       value: state.ceoInfo.nationalCode,
                  //     ),
                  //   ],
                  // ),
                  ...state.boardMemberInfo
                      .map((e) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ReadOnlyWidgets(
                                label:
                                    Strings.of(context).board_member_name_label,
                                hintTxt:
                                    Strings.of(context).board_member_name_label,
                                value: e.name,
                              ),
                              ReadOnlyWidgets(
                                label: Strings.of(context)
                                    .board_member_national_code_label,
                                hintTxt: Strings.of(context)
                                    .board_member_national_code_label,
                                value: e.nationalCode,
                              ),
                            ],
                          ))
                      .toList()
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
