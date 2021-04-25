part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class Initial extends HomeState {}

class Loading extends HomeState {}

class LocationsCollected extends HomeState {
  LocationsCollected(this.locations);

  final List<Location> locations;
}

class Error extends HomeState {}
