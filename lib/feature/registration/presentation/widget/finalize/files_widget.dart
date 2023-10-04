import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scf_auth/feature/registration/presentation/cubit/registration_controller_cubit.dart';
import 'package:scf_auth/feature/registration/presentation/widget/finalize/edit_title.dart';
import 'package:scf_auth/feature/registration/presentation/widget/finalize/read_only_widgets.dart';

import '../../../../../core/utils/ui_utils.dart';
import '../../../../language/manager/localizatios.dart';

class FilesWidget extends StatelessWidget {
  const FilesWidget({
    super.key,
    required this.onFileEditClick,
    required this.onSeeDocumentClick,
  });

  final Function() onFileEditClick;
  final Function() onSeeDocumentClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EditTitle(
          title: Strings.of(context).files,
          onEditClick: onFileEditClick,
        ),
        const SizedBox(height: 68),
        SizedBox(
          width: UiUtils.maxWidth,
          child: BlocBuilder<RegistrationControllerCubit,
              RegistrationControllerState>(
            builder: (context, state) {
              return Wrap(
                runSpacing: 40,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  //اساس نامه
                  ReadOnlyWidgets(
                    label: Strings.of(context).statute_label,
                    hintTxt: Strings.of(context).statute_label,
                    value: state.statute?.fileName,
                    seeDocIcon: Icons.remove_red_eye,
                    onSeeDocumentClick: onSeeDocumentClick,
                  ),
                  //روز نامه
                  ReadOnlyWidgets(
                    label: Strings.of(context).newspaper_label,
                    hintTxt: Strings.of(context).newspaper_label,
                    value: state.newspaper?.fileName,
                    seeDocIcon: Icons.remove_red_eye,
                    onSeeDocumentClick: onSeeDocumentClick,
                  ),
                  //تراز نامه
                  ReadOnlyWidgets(
                    label: Strings.of(context).balance_sheet_label,
                    hintTxt: Strings.of(context).balance_sheet_label,
                    value: state.balanceSheet?.fileName,
                    seeDocIcon: Icons.remove_red_eye,
                    onSeeDocumentClick: onSeeDocumentClick,
                  ),
                  //صورت سود زیان
                  ReadOnlyWidgets(
                    label: Strings.of(context).profit_and_loss_statement_label,
                    hintTxt:
                        Strings.of(context).profit_and_loss_statement_label,
                    value: state.profitAndLossStatement?.fileName,
                    seeDocIcon: Icons.remove_red_eye,
                    onSeeDocumentClick: onSeeDocumentClick,
                  ),
                  //سایر
                  ...List.generate(
                    state.otherDocuments.length,
                    (index) => ReadOnlyWidgets(
                      label: index == 0 ? Strings.of(context).other : null,
                      hintTxt: Strings.of(context).other,
                      value: state.otherDocuments[index]?.fileName,
                      seeDocIcon: Icons.remove_red_eye,
                      onSeeDocumentClick: onSeeDocumentClick,
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
