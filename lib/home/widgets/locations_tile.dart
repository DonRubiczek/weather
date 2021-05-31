import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/backend/backend.dart';
import 'package:weather/location/location_page.dart';
import 'package:weather/repository/model/location.dart';
import 'package:weather/theme/app_specific_theme.dart';

import 'package:weather/l10n/l10n.dart';

class LocationsTile extends StatelessWidget {
  const LocationsTile({
    Key? key,
    required this.location,
  }) : super(key: key);

  final Location location;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key(
        context.l10n.home_page_locations_tile_key,
      ),
      onTap: () => Navigator.push(
        context,
        LocationPage.route(
          location: location,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      leading: Container(
        padding: const EdgeInsets.only(
          right: 12.0,
        ),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              width: 1.0,
              color: context.theme.bodyTextColor,
            ),
          ),
        ),
        child: Icon(
          Icons.stars,
          color: context.theme.primaryColor,
        ),
      ),
      title: Text(
        '${location.title}',
        style: TextStyle(
          color: context.theme.bodyTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        children: [
          Row(
            children: <Widget>[
              Icon(
                Icons.location_city,
                color: context.theme.secondaryColor,
              ),
              Text(
                // ignore: prefer_interpolation_to_compose_strings
                '${location.locationType} ' +
                    _prepareLocationLattLongFormat(
                      location.lattLong.split(',').first,
                      0,
                      context,
                    ) +
                    ' ' +
                    _prepareLocationLattLongFormat(
                      location.lattLong.split(',').last,
                      1,
                      context,
                    ),
                style: TextStyle(
                  color: context.theme.bodyTextColor,
                ),
              )
            ],
          ),
          location.distance != null
              ? Text(
                  context.read<Backend>().settingsRepository.metricId == 0
                      ? '${context.l10n.home_page_locations_tile_distance}'
                          '${location.distance}'
                          '${context.l10n.home_page_locations_tile_metres}'
                      : '${context.l10n.home_page_locations_tile_distance}'
                          '${(location.distance! / 0.9144).round()}'
                          '${context.l10n.home_page_locations_tile_yards}',
                  style: TextStyle(
                    color: context.theme.bodyTextColor,
                  ),
                )
              : Container(),
        ],
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: context.theme.bodyTextColor,
        size: 30.0,
      ),
    );
  }

  String _prepareLocationLattLongFormat(
    String value,
    int valueId,
    BuildContext context,
  ) {
    value = value.substring(
      0,
      value.indexOf('.') + 3,
    );
    var isMinus = value.contains('-');
    if (valueId == 0) {
      switch (isMinus) {
        case true:
          return '$value' '${context.l10n.home_page_locations_tile_south}';
        case false:
          return '$value' '${context.l10n.home_page_locations_tile_north}';
        default:
          return value;
      }
    } else {
      switch (isMinus) {
        case true:
          return '$value' '${context.l10n.home_page_locations_tile_west}';
        case false:
          return '$value' '${context.l10n.home_page_locations_tile_east}';
        default:
          return value;
      }
    }
  }
}
