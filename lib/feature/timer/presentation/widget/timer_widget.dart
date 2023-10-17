import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/ui_utils.dart';
import '../cubit/timer_controller_cubit.dart';

typedef TimerWidgetBuilder = Widget Function(Duration remainTime);

class TimerWidget extends StatefulWidget {
  final String? id;
  final TimerWidgetBuilder builder;
  final Widget action;

  const TimerWidget({
    super.key,
    required this.action,
    required this.builder,
    this.id,
  });

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _addNewEventAndStart();
    });
  }

  @override
  void didUpdateWidget(covariant TimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.id != widget.id) {
      _addNewEventAndStart();
    }
  }

  void _addNewEventAndStart() {
    if (widget.id == null) return;
    final state = context.read<TimerControllerCubit>().addEvent(widget.id!);
    if (state.startTimer) _startTimer();
  }

  void _startTimer() {
    if (_timer != null) _stopTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        _stopTimer();
        return;
      }
      if (widget.id == null) return;
      final isFinished = context.read<TimerControllerCubit>().tick(widget.id!);
      if (isFinished) _stopTimer();
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TimerControllerCubit, TimerControllerState>(
      listenWhen: (previous, current) =>
          previous.startTimer != current.startTimer,
      listener: (context, state) {
        if (state.startTimer) _startTimer();
      },
      buildWhen: (previous, current) =>
          (previous.getDurationOf(widget.id ?? '') !=
              current.getDurationOf(widget.id ?? '')) ||
          (previous.isFinished(widget.id ?? '') !=
              current.isFinished(widget.id ?? '')),
      builder: (context, state) => AnimatedCrossFade(
        duration: UiUtils.duration,
        sizeCurve: UiUtils.curve,
        firstCurve: UiUtils.curve,
        secondCurve: UiUtils.curve,
        crossFadeState: widget.id == null || state.isFinished(widget.id ?? '')
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        firstChild: widget.builder(state.getDurationOf(widget.id ?? '')),
        secondChild: widget.action,
      ),
    );
  }
}
