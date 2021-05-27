import 'package:flutter/material.dart';
import 'package:weather/theme/app_specific_theme.dart';

class SettingsOption extends StatelessWidget {
  SettingsOption({
    Key? key,
    required this.title,
    required this.onChanged,
    required this.groupValue,
    required this.value,
  }) : super(key: key);

  final String title;
  final int value;
  final int groupValue;
  final Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        color: Colors.green.withOpacity(0.1),
      ),
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: context.theme.bodyTextColor,
            ),
          ),
          Radio<int>(
            value: value,
            groupValue: groupValue,
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
