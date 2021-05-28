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
