import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/theme/app_specific_theme.dart';
import 'package:weather/theme/theme_provider.dart';

class SettingsOptionTheme extends StatelessWidget {
  SettingsOptionTheme(
      {Key? key,
      required this.title,
      required this.onChanged,
      required this.value})
      : super(key: key);

  final String title;
  final int value;
  final Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context, listen: true).theme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
        color: Colors.green.withOpacity(0.1),
      ),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: theme.bodyTextColor,
            ),
          ),
          Radio<int>(
            value: value,
            groupValue: theme.runtimeType == BrightAppTheme ? 0 : 1,
            onChanged: (value) {
              onChanged(value!);
            },
            activeColor: Colors.green,
          )
        ],
      ),
    );
  }
}
