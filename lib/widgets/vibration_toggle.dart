import 'package:flutter/material.dart';

import '../state/zikir_controller.dart';

/// AppBar-Button zum Ein-/Ausschalten der Vibration.
class VibrationToggle extends StatelessWidget {
  const VibrationToggle({super.key, required this.controller});

  final ZikirController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final enabled = controller.vibrationEnabled;
        return IconButton(
          tooltip: enabled ? 'Vibration ausschalten' : 'Vibration einschalten',
          icon: Icon(enabled ? Icons.vibration : Icons.mobile_off),
          onPressed: () {
            controller.setVibration(!enabled);
            final messenger = ScaffoldMessenger.of(context);
            messenger.hideCurrentSnackBar();
            messenger.showSnackBar(
              SnackBar(
                content: Text(enabled ? 'Vibration aus' : 'Vibration an'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        );
      },
    );
  }
}
