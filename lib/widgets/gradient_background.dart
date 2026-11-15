import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Ruhiger grüner Verlauf als Hintergrund für alle Screens.
class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.green,
              AppColors.deepGreen,
              AppColors.darkestGreen,
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
