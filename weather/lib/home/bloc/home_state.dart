part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {}

class Initial extends HomeState {
  @override
  List<Object?> get props => [];
}

class Loading extends HomeState {
  @override
  List<Object?> get props => [];
}

class LocationsCollected extends HomeState {
  LocationsCollected(this.locations);

  final List<Location> locations;

  @override
  List<Object?> get props => [locations];
}

class Error extends HomeState {
  @override
  List<Object?> get props => [];
}
