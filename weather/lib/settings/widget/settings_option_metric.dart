import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/backend/backend.dart';
import 'package:weather/theme/theme_provider.dart';

class SettingsOptionMetric extends StatelessWidget {
  SettingsOptionMetric({
    Key? key,
    required this.title,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  final String title;
  final int value;
  final Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context, listen: true).theme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
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
          Consumer<Backend>(
            builder: (context, model, _) => Radio<int>(
              value: value,
              groupValue: model.settingsRepository.metricId,
              onChanged: (value) {
                onChanged(value!);
              },
              activeColor: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}
