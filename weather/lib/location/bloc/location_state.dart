part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class Initial extends LocationState {}

class LocationDataCollected extends LocationState {
  LocationDataCollected(this.data);

  final LocationData data;
}

class Error extends LocationState {}

class Loading extends LocationState {}
