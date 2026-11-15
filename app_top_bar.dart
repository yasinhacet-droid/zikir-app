import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';

/// Einheitliche, transparente AppBar für alle Screens.
PreferredSizeWidget buildAppBar({
  required Widget title,
  List<Widget>? actions,
}) {
  return AppBar(
    title: title,
    actions: actions,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    foregroundColor: AppColors.cream,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    titleTextStyle: const TextStyle(
      color: AppColors.cream,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    ),
  );
}
