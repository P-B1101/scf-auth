import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scf_auth/core/utils/assets.dart';

class LocationPinWidget extends StatelessWidget {
  final double size;
  const LocationPinWidget({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -_width * .75),
      child: SizedBox(
        width: _width,
        height: size,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: -4,
              child: Transform(
                transform: Matrix4.rotationX(-1.2),
                alignment: Alignment.center,
                child: Container(
                  width: _width * .75,
                  height: 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: MColors.inputTextColor.withOpacity(.3),
                  ),
                ),
              ),
            ),
            Positioned(
              top: _width,
              bottom: 2,
              child: Transform.translate(
                offset: const Offset(0, -2),
                child: Container(
                  width: 3,
                  height: size,
                  decoration: BoxDecoration(
                    color: MColors.primaryColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                width: _width,
                height: _width,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: MColors.primaryColor,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/images/svg/logo.svg',
                  width: 18,
                  height: 18,
                  fit: BoxFit.contain,
                  colorFilter: const ColorFilter.mode(
                    MColors.whiteColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double get _width => size * .65;
}
