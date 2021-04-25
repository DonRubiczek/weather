import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:weather/backend/backend.dart';
import 'package:weather/theme/theme_provider.dart';
import 'package:weather/utils/constants.dart';

class AppBuilder extends StatefulWidget {
  const AppBuilder({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _AppBuilderState createState() => _AppBuilderState();
}

class _AppBuilderState extends State<AppBuilder> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<ThemeProvider>(context, listen: false).update(
          Provider.of<Backend>(context, listen: false)
              .sharedPreferences
              .getInt(CONSTANTS.SHARED_PREF_KEY_THEME));
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
