import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/zikir_data.dart';
import 'screens/home_screen.dart';
import 'services/storage_service.dart';
import 'state/zikir_controller.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await StorageService.create();
  final controller = ZikirController(storage: storage, items: kZikirList);

  runApp(ZikirApp(controller: controller));
}

class ZikirApp extends StatelessWidget {
  const ZikirApp({super.key, required this.controller});

  final ZikirController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zikir',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      locale: const Locale('de'),
      supportedLocales: const [Locale('de')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: HomeScreen(controller: controller),
    );
  }
}
