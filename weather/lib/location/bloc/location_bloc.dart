import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather/repository/model/location_data.dart';
import 'package:weather/repository/weather_repository.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc(
    this.weatherRepository,
  ) : super(Initial());

  final WeatherRepository weatherRepository;

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is GetLocationData) {
      yield* mapLocationByNameToState(event);
    }
  }

  Stream<LocationState> mapLocationByNameToState(
    GetLocationData event,
  ) async* {
    yield Loading();

    final result =
        await weatherRepository.locationInformation(event.locationId);

    if (result.data != null)
      yield LocationDataCollected(result.data!);
    else
      yield Error();
  }
}
