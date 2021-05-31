import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather/backend/backend.dart';
import 'package:weather/settings/bloc/settings_bloc.dart';
import 'package:weather/settings/widget/setting_option.dart';
import 'package:weather/theme/app_specific_theme.dart';
import 'package:weather/l10n/l10n.dart';

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
        title: Text(
          context.l10n.settings_page_title,
        ),
        leading: IconButton(
          key: Key(
            context.l10n.settings_page_back_button_key,
          ),
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<SettingsBloc, SettingsState>(
        buildWhen: (previousState, state) {
          return state is! Error;
        },
        listener: (BuildContext context, state) {
          if (state is Error) {
            _showAlertDialog(
              context,
            );
          }
        },
        builder: (context, state) {
          return buildPage(
            context,
          );
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
              context.l10n.settings_page_theme_header,
              style: context.theme.headline3,
            ),
          ),
          SettingsOption(
            key: Key(
              context.l10n.settings_page_light_theme_key,
            ),
            title: context.l10n.settings_page_light_theme,
            value: 0,
            groupValue: context.theme.runtimeType == BrightAppTheme ? 0 : 1,
            onChanged: (value) => bloc.add(
              ChangeTheme(themeId: value),
            ),
          ),
          Divider(
            color: context.theme.bodyTextColor,
            height: 1,
          ),
          SettingsOption(
            title: context.l10n.settings_page_dark_theme,
            key: Key(
              context.l10n.settings_page_dark_theme_key,
            ),
            value: 1,
            onChanged: (value) => bloc.add(
              ChangeTheme(themeId: value),
            ),
            groupValue: context.theme.runtimeType == BrightAppTheme ? 0 : 1,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              left: 8,
              right: 8,
              bottom: 8,
            ),
            child: Text(
              context.l10n.settings_page_unit_system_header,
              style: context.theme.headline3,
            ),
          ),
          Consumer<Backend>(
            builder: (context, model, _) => SettingsOption(
              title: context.l10n.settings_page_metric_system,
              key: Key(
                context.l10n.settings_page_metric_system_key,
              ),
              value: 0,
              groupValue: model.settingsRepository.metricId!,
              onChanged: (value) => bloc.add(
                ChangeMetricSystem(
                  systemId: value,
                ),
              ),
            ),
          ),
          Divider(
            color: context.theme.bodyTextColor,
            height: 1,
          ),
          Consumer<Backend>(
            builder: (context, model, _) => SettingsOption(
              title: context.l10n.settings_page_imperial_system,
              key: Key(
                context.l10n.settings_page_imperial_system_key,
              ),
              value: 1,
              groupValue: model.settingsRepository.metricId!,
              onChanged: (value) => bloc.add(
                ChangeMetricSystem(systemId: value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showAlertDialog(BuildContext context) {
  Widget okButton = TextButton(
    child: Text(
      context.l10n.settings_page_ok_button,
    ),
    onPressed: () => Navigator.pop(
      context,
    ),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          context.l10n.settings_page_error_header,
        ),
        content: Text(
          context.l10n.settings_page_error_desc,
        ),
        actions: [
          okButton,
        ],
      );
    },
  );
}
