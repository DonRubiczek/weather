part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class FindLocationByNameEvent extends HomeEvent {
  FindLocationByNameEvent({required this.locationName});

  final String locationName;
}

class FindLocationByCoordinatesEvent extends HomeEvent {
  FindLocationByCoordinatesEvent(
      {required this.lattitude, required this.longitude});

  final String lattitude;
  final String longitude;
}
