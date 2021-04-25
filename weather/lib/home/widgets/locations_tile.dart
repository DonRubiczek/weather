import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/backend/backend.dart';
import 'package:weather/location/location_page.dart';
import 'package:weather/repository/model/location.dart';
import 'package:weather/theme/theme_provider.dart';

class LocationsTile extends StatefulWidget {
  const LocationsTile({
    Key? key,
    required this.location,
  }) : super(key: key);

  final Location location;

  @override
  _LocationsTileState createState() => _LocationsTileState();
}

class _LocationsTileState extends State<LocationsTile> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(
        context,
        LocationPage.route(
          location: widget.location,
        ),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: const EdgeInsets.only(right: 12.0),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              width: 1.0,
              color: Provider.of<ThemeProvider>(context, listen: false)
                  .theme
                  .bodyTextColor,
            ),
          ),
        ),
        child: Icon(Icons.stars,
            color: Provider.of<ThemeProvider>(context, listen: false)
                .theme
                .primaryColor),
      ),
      title: Text(
        '${widget.location.title}',
        style: TextStyle(
            color: Provider.of<ThemeProvider>(context, listen: false)
                .theme
                .bodyTextColor,
            fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        children: [
          Row(
            children: <Widget>[
              Icon(
                Icons.location_city,
                color: Provider.of<ThemeProvider>(context, listen: false)
                    .theme
                    .secondaryColor,
              ),
              Text(
                '${widget.location.locationType} ' +
                    _prepareLocationLattLongFormat(
                        widget.location.lattLong.split(',').first, 0) +
                    ' ' +
                    _prepareLocationLattLongFormat(
                        widget.location.lattLong.split(',').last, 1),
                style: TextStyle(
                  color: Provider.of<ThemeProvider>(context, listen: false)
                      .theme
                      .bodyTextColor,
                ),
              )
            ],
          ),
          widget.location.distance != null
              ? Text(
                  context.read<Backend>().settingsRepository.metricId == 0
                      ? 'Distance from: '
                          '${widget.location.distance} metres'
                      : 'Distance from: '
                          '${(widget.location.distance! / 0.9144).round().toStringAsFixed(0)} yards',
                  style: TextStyle(
                      color: Provider.of<ThemeProvider>(context, listen: false)
                          .theme
                          .bodyTextColor),
                )
              : Container(),
        ],
      ),
      trailing: Icon(Icons.keyboard_arrow_right,
          color: Provider.of<ThemeProvider>(context, listen: false)
              .theme
              .bodyTextColor,
          size: 30.0),
    );
  }

  String _prepareLocationLattLongFormat(String value, int valueId) {
    value = value.substring(0, value.indexOf('.') + 3);
    var isMinus = value.contains('-');
    if (valueId == 0) {
      switch (isMinus) {
        case true:
          return '${value}S';
        case false:
          return '${value}N';
        default:
          return value;
      }
    } else {
      switch (isMinus) {
        case true:
          return '${value}W';
        case false:
          return '${value}E';
        default:
          return value;
      }
    }
  }
}
