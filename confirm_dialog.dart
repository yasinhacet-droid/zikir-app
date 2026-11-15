import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Einfacher Ja/Nein-Dialog. Liefert `true`, wenn bestätigt wurde.
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'Zurücksetzen',
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: AppColors.cardGreen,
      title: Text(title, style: const TextStyle(color: AppColors.cream)),
      content: Text(message, style: const TextStyle(color: AppColors.muted)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text('Abbrechen'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return result ?? false;
}
