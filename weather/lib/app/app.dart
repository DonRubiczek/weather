import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather/backend/backend.dart';
import 'package:weather/home/home_page.dart';
import 'package:weather/l10n/l10n.dart';
import 'package:weather/theme/app_specific_theme.dart';
import 'package:weather/theme/app_builder.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.backend}) : super(key: key);

  final Backend backend;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: context.theme.primaryColor,
      theme: context.theme.themeData,
      themeMode: ThemeMode.system,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const AppBuilder(
        child: HomePage(),
      ),
    );
  }
}
