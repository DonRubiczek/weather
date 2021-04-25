import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/api/api_client.dart';
import 'package:weather/api/dio.dart';
import 'package:weather/repository/settings_repository.dart';
import 'package:weather/repository/weather_repository.dart';

abstract class Backend {
  WeatherRepository get weatherRepository;
  SettingsRepository get settingsRepository;

  ApiClient get apiClient;

  SharedPreferences get sharedPreferences;

  //SettingsBloc get settingsBloc;
}

class AppBackend extends Backend {
  AppBackend._(
      {required this.weatherRepository,
      required this.settingsRepository,
      //required this.settingsBloc,
      required this.apiClient,
      required this.sharedPreferences});

  @override
  final WeatherRepository weatherRepository;
  @override
  final SettingsRepository settingsRepository;

  @override
  final ApiClient apiClient;

  @override
  final SharedPreferences sharedPreferences;

  //@override
  //final SettingsBloc settingsBloc;

  static AppBackend? _instance;
  static AppBackend? get instance {
    if (_instance != null) {
      return _instance;
    }
    throw Exception('Missing backend');
  }

  static Future<AppBackend?> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final apiClient = ApiClient(
      dio,
    );

    final weatherRepository = WeatherRepository(apiClient);
    final settingsRepository = SettingsRepository(sharedPreferences);

    //final settingsBloc = SettingsBloc(preferences: sharedPreferences);

    _instance = AppBackend._(
      weatherRepository: weatherRepository,
      settingsRepository: settingsRepository,
      apiClient: apiClient,
      sharedPreferences: sharedPreferences,
      //settingsBloc: settingsBloc,
    );

    return instance;
  }
}
