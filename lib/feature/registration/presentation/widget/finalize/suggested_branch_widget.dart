import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scf_auth/core/utils/ui_utils.dart';
import 'package:scf_auth/feature/registration/presentation/cubit/registration_controller_cubit.dart';
import 'package:scf_auth/feature/registration/presentation/widget/finalize/edit_title.dart';
import 'package:scf_auth/feature/registration/presentation/widget/finalize/read_only_widgets.dart';

import '../../../../language/manager/localizatios.dart';

class FinalizeSuggestedBranchWidget extends StatelessWidget {
  const FinalizeSuggestedBranchWidget({
    super.key,
    required this.onSuggestedBranchEditClick,
  });

  final Function() onSuggestedBranchEditClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EditTitle(
          title: Strings.of(context).registration_steps_suggested_branch,
          onEditClick: onSuggestedBranchEditClick,
        ),
        const SizedBox(height: 68),
        SizedBox(
          width: UiUtils.maxWidth,
          child: BlocBuilder<RegistrationControllerCubit,
              RegistrationControllerState>(
            builder: (context, state) {
              return ReadOnlyWidgets(
                label: Strings.of(context).registration_steps_suggested_branch,
                hintTxt:
                    Strings.of(context).registration_steps_suggested_branch,
                value: state.selectedBranch?.title ?? '',
              );
            },
          ),
        ),
      ],
    );
  }
}
