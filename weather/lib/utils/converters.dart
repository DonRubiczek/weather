import 'package:flutter/material.dart';
import 'package:weather/theme/app_specific_theme.dart';

Icon convertWindDirToIcon(
  String compass,
  BuildContext context,
) {
  switch (compass) {
    case 'N':
      return Icon(
        Icons.north,
        color: context.theme.secondaryColor,
      );
    case 'S':
      return Icon(
        Icons.south,
        color: context.theme.secondaryColor,
      );
    case 'W':
      return Icon(
        Icons.west,
        color: context.theme.secondaryColor,
      );
    case 'E':
      return Icon(
        Icons.east,
        color: context.theme.secondaryColor,
      );
    case 'NW':
      return Icon(
        Icons.north_west,
        color: context.theme.secondaryColor,
      );
    case 'NE':
      return Icon(
        Icons.north_east,
        color: context.theme.secondaryColor,
      );
    case 'SW':
      return Icon(
        Icons.south_west,
        color: context.theme.secondaryColor,
      );
    case 'SE':
      return Icon(
        Icons.south_east,
        color: context.theme.secondaryColor,
      );
    default:
      return Icon(
        Icons.south_east,
        color: context.theme.secondaryColor,
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
