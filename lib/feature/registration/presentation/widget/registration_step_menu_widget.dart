import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scf_auth/core/components/animated/warning_widget.dart';

import '../../../../core/utils/assets.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/ui_utils.dart';
import '../cubit/registration_controller_cubit.dart';

class RegistrationStepMenuWidget extends StatelessWidget {
  final Function(RegistrationSteps) onStepClick;
  const RegistrationStepMenuWidget({
    super.key,
    required this.onStepClick,
  });

  @override
  Widget build(BuildContext context) {
    const items = RegistrationSteps.values;
    return Container(
      width: double.infinity,
      height: 43,
      color: MColors.primaryColor.withOpacity(.3),
      alignment: AlignmentDirectional.centerStart,
      child:
          BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.step != current.step) ||
            (previous.errorStep != current.errorStep),
        builder: (context, state) => ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (context, index) => _ItemWidget(
            isWarned: items[index] == state.errorStep,
            item: items[index],
            onStepClick: onStepClick,
            isSelected: items[index] == state.step,
          ),
          separatorBuilder: (context, index) => const Center(
            child: Text(
              '/',
              style: TextStyle(
                fontSize: 20,
                fontWeight: Fonts.regular400,
                color: MColors.primaryColor,
              ),
            ),
          ),
          itemCount: items.length,
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final RegistrationSteps item;
  final bool isSelected;
  final bool isWarned;
  final Function(RegistrationSteps) onStepClick;
  const _ItemWidget({
    Key? key,
    required this.item,
    required this.onStepClick,
    required this.isSelected,
    required this.isWarned,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onStepClick(item),
            child: isWarned
                ? WarningWidget(
                    startColor: MColors.errorColor,
                    endColor: MColors.featureBoxColorOf(context),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: Fonts.regular400,
                    ),
                    child: _text,
                  )
                : AnimatedDefaultTextStyle(
                    duration: UiUtils.duration,
                    curve: UiUtils.curve,
                    style: TextStyle(
                      fontFamily: Fonts.yekan,
                      fontSize: 18,
                      fontWeight: Fonts.regular400,
                      color: isSelected
                          ? MColors.primaryColor
                          : MColors.featureBoxColorOf(context),
                    ),
                    child: _text,
                  ),
          ),
        ),
      ),
    );
  }

  Widget get _text =>
      Builder(builder: (context) => Text(item.toStringValue(context)));
}
