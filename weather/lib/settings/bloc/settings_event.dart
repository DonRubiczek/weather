part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class ChangeTheme extends SettingsEvent {
  ChangeTheme({required this.themeId, required this.context});

  final int themeId;
  final BuildContext context;
}

class ChangeMetricSystem extends SettingsEvent {
  ChangeMetricSystem({required this.systemId, required this.context});

  final int systemId;
  final BuildContext context;
}
