import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather/repository/model/consolidated_weather.dart';
import 'package:weather/repository/weather_repository.dart';

part 'day_forecast_event.dart';
part 'day_forecast_state.dart';

class DayForecastBloc extends Bloc<DayForecastEvent, DayForecastState> {
  DayForecastBloc(this.weatherRepository) : super(Initial());

  final WeatherRepository weatherRepository;

  @override
  Stream<DayForecastState> mapEventToState(
    DayForecastEvent event,
  ) async* {
    if (event is GetLocationDayForecast) {
      yield* mapGetDayForecastToState(
        event,
      );
    }
  }

  Stream<DayForecastState> mapGetDayForecastToState(
    GetLocationDayForecast event,
  ) async* {
    yield Loading();

    final result = await weatherRepository.locationDayInformation(
      event.locationId,
      event.date,
    );

    if (result.data != null)
      yield DayForecastCollected(
        result.data!.data,
      );
    else
      yield Error();
  }
}
