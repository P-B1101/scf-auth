import 'package:flutter/material.dart';
import '../../utils/assets.dart';

class AnimatedLineWidget extends StatefulWidget {
  const AnimatedLineWidget({
    super.key,
  });

  @override
  State<AnimatedLineWidget> createState() => _AnimatedLineWidgetState();
}

class _AnimatedLineWidgetState extends State<AnimatedLineWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final isForward = _controller.status == AnimationStatus.forward;
        return Align(
          alignment: Tween<Alignment>(
            begin: const Alignment(0, -1.5),
            end: const Alignment(0, 1.5),
          )
              .animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Curves.linear,
                ),
              )
              .value,
          child: Container(
            width: double.infinity,
            height: 64,
            alignment: isForward ? Alignment.bottomCenter : Alignment.topCenter,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.white.withOpacity(isForward ? .75 : 0),
                  Colors.white.withOpacity(isForward ? 0 : .75)
                ],
              ),
            ),
            child: child,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 1,
        color: MColors.redColor,
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:hi_pay/core/utils/assets.dart';
// import 'package:hi_pay/core/utils/ui_utils.dart';

// class AnimatedLineWidget extends StatefulWidget {
//   const AnimatedLineWidget({
//     super.key,
//   });

//   @override
//   State<AnimatedLineWidget> createState() => _AnimatedLineWidgetState();
// }

// class _AnimatedLineWidgetState extends State<AnimatedLineWidget>
//     with TickerProviderStateMixin {
//   late final AnimationController _controller;
//   late final AnimationController _lineController;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     )..repeat(reverse: true);

//     _lineController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     )..repeat(reverse: true);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _lineController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         AnimatedBuilder(
//           animation: _controller,
//           builder: (context, child) {
//             final isForward = _controller.status == AnimationStatus.forward;
//             return Align(
//               alignment: Tween<Alignment>(
//                 begin: const Alignment(0, -1.85),
//                 end: const Alignment(0, 1.85),
//               )
//                   .animate(
//                     CurvedAnimation(
//                       parent: _controller,
//                       curve: Curves.linear,
//                     ),
//                   )
//                   .value,
//               child: Container(
//                 // duration: UiUtils.duration * 4,
//                 width: double.infinity,
//                 height: 100,
//                 alignment:
//                     isForward ? Alignment.bottomCenter : Alignment.topCenter,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.bottomCenter,
//                     end: Alignment.topCenter,
//                     colors: [
//                       Colors.white.withOpacity(isForward ? .5 : 0),
//                       Colors.white.withOpacity(isForward ? 0 : .5)
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//         AnimatedBuilder(
//           animation: _lineController,
//           builder: (context, child) => Align(
//             alignment: Tween<Alignment>(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             )
//                 .animate(
//                   CurvedAnimation(
//                     parent: _lineController,
//                     curve: Curves.linear,
//                   ),
//                 )
//                 .value,
//             child: child,
//           ),
//           child: Container(
//             width: double.infinity,
//             height: 1,
//             color: MColors.redColor,
//           ),
//         ),
//       ],
//     );
//   }
// }
