import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather/backend/backend.dart';
import 'package:weather/settings/bloc/settings_bloc.dart';
import 'package:weather/theme/app_specific_theme.dart';

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
        title: const Text(
          'Settings',
        ),
        leading: IconButton(
          key: const Key(
            'settingsAppBarBackButton',
          ),
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
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
    var bloc = BlocProvider.of<SettingsBloc>(context);

    return Container(
      color: context.theme.backgroundColor,
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 15,
      ),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Theme',
              style: context.theme.headline3,
            ),
          ),
          SettingsOptionTheme(
            key: const Key(
              'settingsLightThemeOption',
            ),
            title: 'Light',
            value: 0,
            onChanged: (value) => bloc.add(
              ChangeTheme(themeId: value),
            ),
          ),
          Divider(
            color: context.theme.bodyTextColor,
            height: 1,
          ),
          SettingsOptionTheme(
            title: 'Dark',
            key: const Key('settingsDarkThemeOption'),
            value: 1,
            onChanged: (value) => bloc.add(
              ChangeTheme(themeId: value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              left: 8,
              right: 8,
              bottom: 8,
            ),
            child: Text(
              'Unit system',
              style: context.theme.headline3,
            ),
          ),
          SettingsOptionMetric(
            title: 'Metric',
            key: const Key(
              'settingsMetricSystemOption',
            ),
            value: 0,
            onChanged: (value) => bloc.add(
              ChangeMetricSystem(systemId: value),
            ),
          ),
          Divider(
            color: context.theme.bodyTextColor,
            height: 1,
          ),
          SettingsOptionMetric(
            title: 'Imperial',
            key: const Key(
              'settingsImperialSystemOption',
            ),
            value: 1,
            onChanged: (value) => bloc.add(
              ChangeMetricSystem(systemId: value),
            ),
          )
        ],
      ),
    );
  }
}

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
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
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
            groupValue: context.theme.runtimeType == BrightAppTheme ? 0 : 1,
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
