import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/api/api_client.dart';
import 'package:weather/backend/backend.dart';
import 'package:weather/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:weather/repository/settings_repository.dart';
import 'package:weather/repository/weather_repository.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockSettingsRepository extends Mock implements SettingsRepository {}

class MockBackend extends Mock implements AppBackend {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockApiClient extends Mock implements ApiClient {}

extension AppTester on WidgetTester {
  Future<void> pumpApp(
    Widget widgetUnderTest, {
    WeatherRepository? weatherRepository,
    SettingsRepository? settingsRepository,
    SharedPreferences? sharedPreferences,
    Backend? backend,
    ApiClient? apiClient,
    TargetPlatform? platform,
    NavigatorObserver? navigatorObserver,
  }) async {
    await pumpWidget(
      MultiProvider(
        providers: [
          Provider<Backend>.value(
            value: AppBackend(
              weatherRepository: weatherRepository ?? MockWeatherRepository(),
              settingsRepository:
                  settingsRepository ?? MockSettingsRepository(),
              sharedPreferences: sharedPreferences ?? MockSharedPreferences(),
              apiClient: apiClient ?? MockApiClient(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Very Good Flutter',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en', 'US')],
          home: Theme(
            data: ThemeData(platform: platform),
            child: Scaffold(body: widgetUnderTest),
          ),
          // navigatorObservers: [
          //   navigatorObserver ?? MockNavigatorObserver()
          // ],
        ),
      ),
      //),
    );
    await pump();
  }
}
