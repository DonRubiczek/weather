import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/theme/theme_provider.dart';

Icon convertWindDirToIcon(String compass, BuildContext context) {
  var themeProvider = Provider.of<ThemeProvider>(context, listen: false).theme;
  switch (compass) {
    case 'N':
      return Icon(
        Icons.north,
        color: themeProvider.secondaryColor,
      );
    case 'S':
      return Icon(
        Icons.south,
        color: themeProvider.secondaryColor,
      );
    case 'W':
      return Icon(
        Icons.west,
        color: themeProvider.secondaryColor,
      );
    case 'E':
      return Icon(
        Icons.east,
        color: themeProvider.secondaryColor,
      );
    case 'NW':
      return Icon(
        Icons.north_west,
        color: themeProvider.secondaryColor,
      );
    case 'NE':
      return Icon(
        Icons.north_east,
        color: themeProvider.secondaryColor,
      );
    case 'SW':
      return Icon(
        Icons.south_west,
        color: themeProvider.secondaryColor,
      );
    case 'SE':
      return Icon(
        Icons.south_east,
        color: themeProvider.secondaryColor,
      );
    default:
      return Icon(
        Icons.south_east,
        color: themeProvider.secondaryColor,
      );
  }
}

enum TemperatureUnit { kelvin, celsius, fahrenheit }

class Temperature {
  Temperature(this._kelvin);

  final double _kelvin;

  double get kelvin => _kelvin;

  double get celsius => _kelvin - 273.15;

  double get fahrenheit => _kelvin * (9 / 5) - 459.67;

  double as(TemperatureUnit unit) {
    switch (unit) {
      case TemperatureUnit.kelvin:
        return kelvin;
      case TemperatureUnit.celsius:
        return celsius;
      case TemperatureUnit.fahrenheit:
        return fahrenheit;
    }
  }
}
