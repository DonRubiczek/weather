part of 'day_forecast_bloc.dart';

@immutable
abstract class DayForecastState {}

class Initial extends DayForecastState {}

class DayForecastCollected extends DayForecastState {
  DayForecastCollected(this.data);

  final List<ConsolidatedWeather> data;
}

class Error extends DayForecastState {}

class Loading extends DayForecastState {}
