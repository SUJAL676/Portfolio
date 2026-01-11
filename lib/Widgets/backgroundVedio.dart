import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BackgroundGif extends StatelessWidget {
  final String assetPath;
  final double opacity;

  const BackgroundGif({
    super.key,
    required this.assetPath,
    this.opacity = 0.35,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Opacity(
        opacity: opacity,
        child: Lottie.asset(
          assetPath,
          repeat: true,
          animate: true,
          frameRate: FrameRate.max,
        ),
      ),
    );
  }
}
