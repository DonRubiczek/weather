part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {}

class FindLocationByNameEvent extends HomeEvent {
  FindLocationByNameEvent({required this.locationName});

  final String locationName;

  @override
  List<Object?> get props => [locationName];
}

class FindLocationByCoordinatesEvent extends HomeEvent {
  FindLocationByCoordinatesEvent(
      {required this.lattitude, required this.longitude});

  final String lattitude;
  final String longitude;

  @override
  List<Object?> get props => [lattitude, longitude];
}
