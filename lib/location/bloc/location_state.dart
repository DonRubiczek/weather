part of 'location_bloc.dart';

@immutable
abstract class LocationState extends Equatable {}

class Initial extends LocationState {
  @override
  List<Object?> get props => [];
}

class LocationDataCollected extends LocationState {
  LocationDataCollected(this.data);

  final LocationData data;

  @override
  List<Object?> get props => [data];
}

class Error extends LocationState {
  @override
  List<Object?> get props => [];
}

class Loading extends LocationState {
  @override
  List<Object?> get props => [];
}
