import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injectable_container.dart';
import '../cubit/timer_controller_cubit.dart';

class TimerWidgetWrapper extends StatelessWidget {
  final Widget child;
  const TimerWidgetWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimerControllerCubit>(
      create: (context) => getIt<TimerControllerCubit>(),
      child: child,
    );
  }
}
