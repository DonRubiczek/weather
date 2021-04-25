import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:weather/theme/theme_provider.dart';

import 'backend.dart';

class BackendProvider extends StatelessWidget {
  const BackendProvider({
    Key? key,
    required this.backend,
    required this.child,
  }) : super(key: key);

  final Backend backend;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Backend>.value(
          value: backend,
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: child,
      // MultiBlocProvider(
      //   providers: [
      //     BlocProvider<SettingsBloc>.value(value: backend.settingsBloc),
      //   ],
      //   child: child,
      // ),
    );
  }
}
