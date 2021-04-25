import 'package:flutter/cupertino.dart';
import 'package:weather/home/widgets/locations_tile.dart';
import 'package:weather/repository/model/location.dart';
import 'package:weather/widgets/error_card.dart';

class LocationsList extends StatelessWidget {
  const LocationsList({
    Key? key,
    required this.locations,
  }) : super(key: key);

  final List<Location> locations;

  @override
  Widget build(BuildContext context) {
    if (locations.isEmpty) {
      return ErrorCard(
        errorMessage:
            'There is no location in database which fulfil search criteria',
      );
    } else {
      return Column(
        children: [
          ...locations
              .map(
                (location) => LocationsTile(
                  key: ValueKey(location.lattLong),
                  location: location,
                ),
              )
              .toList()
        ],
      );
    }
  }
}
