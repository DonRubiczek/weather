part of 'location_bloc.dart';

@immutable
abstract class LocationEvent extends Equatable {}

class GetLocationData extends LocationEvent {
  GetLocationData({required this.locationId});

  final String locationId;

  @override
  List<Object?> get props => [locationId];
}
