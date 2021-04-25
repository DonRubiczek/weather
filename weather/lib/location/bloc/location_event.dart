part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class GetLocationData extends LocationEvent {
  GetLocationData({required this.locationId});

  final String locationId;
}
