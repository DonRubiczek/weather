import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/backend/backend.dart';
import 'package:weather/settings/bloc/settings_bloc.dart';
import 'package:weather/settings/widget/settings_option_metric.dart';
import 'package:weather/settings/widget/settings_option_theme.dart';
import 'package:weather/theme/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage._({Key? key}) : super(key: key);

  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (_) => const SettingsPage._(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(
        settingsRepository: context.read<Backend>().settingsRepository,
      ),
      child: SettingsView(),
    );
  }
}

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        key: const Key('settingsAppBar'),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        bloc: BlocProvider.of<SettingsBloc>(context),
        builder: (context, state) {
          if (state is AppSettingsChanged)
            return buildPage(context);
          else
            return buildPage(context);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context, listen: true).theme;
    var bloc = BlocProvider.of<SettingsBloc>(context);

    return Container(
      color: theme.backgroundColor,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Theme', style: theme.headline3),
          ),
          SettingsOptionTheme(
            title: 'Light',
            value: 0,
            onChanged: (value) => bloc.add(
              ChangeTheme(themeId: value, context: context),
            ),
          ),
          Divider(
            color: theme.bodyTextColor,
            height: 1,
          ),
          SettingsOptionTheme(
            title: 'Dark',
            value: 1,
            onChanged: (value) => bloc.add(
              ChangeTheme(themeId: value, context: context),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 15, left: 8, right: 8, bottom: 8),
            child: Text(
              'Unit system',
              style: theme.headline3,
            ),
          ),
          SettingsOptionMetric(
            title: 'Metric',
            value: 0,
            onChanged: (value) => bloc.add(
              ChangeMetricSystem(systemId: value, context: context),
            ),
          ),
          Divider(
            color: theme.bodyTextColor,
            height: 1,
          ),
          SettingsOptionMetric(
            title: 'Imperial',
            value: 1,
            onChanged: (value) => bloc.add(
              ChangeMetricSystem(systemId: value, context: context),
            ),
          )
        ],
      ),
    );
  }
}
