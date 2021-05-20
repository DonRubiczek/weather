part of 'day_forecast_bloc.dart';

@immutable
abstract class DayForecastEvent extends Equatable {}

class GetLocationDayForecast extends DayForecastEvent {
  GetLocationDayForecast({
    required this.locationId,
    required this.date,
  });

  final String locationId;
  final String date;

  @override
  List<Object?> get props => [locationId, date];
}
