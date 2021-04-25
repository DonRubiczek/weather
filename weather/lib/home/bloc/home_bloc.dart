import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather/repository/model/location.dart';
import 'package:weather/repository/weather_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
    this.weatherRepository,
  ) : super(Initial());

  final WeatherRepository weatherRepository;

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is FindLocationByNameEvent) {
      yield* mapLocationByNameToState(event);
    }
    if (event is FindLocationByCoordinatesEvent) {
      yield* mapLocationByCoordinatesToState(event);
    }
  }

  Stream<HomeState> mapLocationByNameToState(
    FindLocationByNameEvent event,
  ) async* {
    yield Loading();

    final result =
        await weatherRepository.locationSearchByName(event.locationName);

    if (result.data != null)
      yield LocationsCollected(result.data!);
    else
      yield Error();
  }

  Stream<HomeState> mapLocationByCoordinatesToState(
    FindLocationByCoordinatesEvent event,
  ) async* {
    yield Loading();

    final result = await weatherRepository.locationSearchByCoordinates(
      event.lattitude,
      event.longitude,
    );

    if (result.data != null)
      yield LocationsCollected(result.data!);
    else
      yield Error();
  }
}
