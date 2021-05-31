import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/theme/app_specific_theme.dart';
import 'package:weather/l10n/l10n.dart';

class ErrorCard extends StatelessWidget {
  ErrorCard({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        color: context.theme.secondaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          errorMessage.isNotEmpty
                              ? errorMessage
                              : context.l10n.error_card_default_message,
                          style: context.theme.headline3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Icon(
                        Icons.error,
                        size: 50,
                        color: context.theme.errorColor,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
