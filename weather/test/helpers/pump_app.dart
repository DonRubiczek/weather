import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather/day_forecast/bloc/day_forecast_bloc.dart';
import 'package:weather/home/bloc/home_bloc.dart';
import 'package:weather/location/bloc/location_bloc.dart';
import 'package:weather/repository/weather_repository.dart';
import 'package:weather/settings/bloc/settings_bloc.dart';
import 'package:weather/theme/theme_provider.dart';

class MockLocationBloc extends MockBloc<LocationEvent, LocationState>
    implements LocationBloc {}

class MockDayForecastBloc extends MockBloc<DayForecastEvent, DayForecastState>
    implements DayForecastBloc {}

class MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState>
    implements SettingsBloc {}

class FakeLocationEvent extends Fake implements LocationEvent {}

class FakeLocationState extends Fake implements LocationState {}

class FakeSettingsEvent extends Fake implements SettingsEvent {}

class FakeSettingsState extends Fake implements SettingsState {}

class FakeHomeEvent extends Fake implements HomeEvent {}

class FakeHomeState extends Fake implements HomeState {}

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class MockWeatherRepository extends Mock implements WeatherRepository {}

extension AppTester on WidgetTester {
  Future<void> pumpApp(
    Widget widgetUnderTest, {
    WeatherRepository? weatherRepository,
    DayForecastBloc? dayForecastBloc,
    LocationBloc? locationBloc,
    SettingsBloc? settingsBloc,
    HomeBloc? homeBloc,
    TargetPlatform? platform,
    NavigatorObserver? navigatorObserver,
  }) async {
    registerFallbackValue<HomeEvent>(FakeHomeEvent());
    registerFallbackValue<HomeState>(FakeHomeState());
    registerFallbackValue<SettingsEvent>(FakeSettingsEvent());
    registerFallbackValue<SettingsState>(FakeSettingsState());
    registerFallbackValue<LocationEvent>(FakeLocationEvent());
    registerFallbackValue<LocationState>(FakeLocationState());
    await pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(),
          ),
        ],
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(
              value: weatherRepository ?? MockWeatherRepository(),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<LocationBloc>.value(
                  value: locationBloc ?? MockLocationBloc()),
              BlocProvider<DayForecastBloc>.value(
                value: dayForecastBloc ?? MockDayForecastBloc(),
              ),
              BlocProvider<SettingsBloc>.value(
                value: settingsBloc ?? MockSettingsBloc(),
              ),
              BlocProvider<HomeBloc>.value(
                value: homeBloc ?? MockHomeBloc(),
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
        ),
      ),
    );
    await pump();
  }
}
