part of 'day_forecast_bloc.dart';

@immutable
abstract class DayForecastState extends Equatable {}

class Initial extends DayForecastState {
  @override
  List<Object?> get props => [];
}

class DayForecastCollected extends DayForecastState {
  DayForecastCollected(this.data);

  final List<ConsolidatedWeather> data;

  @override
  List<Object?> get props => [data];
}

class Error extends DayForecastState {
  @override
  List<Object?> get props => [];
}

class Loading extends DayForecastState {
  @override
  List<Object?> get props => [];
}
