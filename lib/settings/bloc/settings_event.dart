part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent extends Equatable {}

class ChangeTheme extends SettingsEvent {
  ChangeTheme({required this.themeId});

  final int themeId;

  @override
  List<Object> get props => [themeId];
}

class ChangeMetricSystem extends SettingsEvent {
  ChangeMetricSystem({required this.systemId});

  final int systemId;

  @override
  List<Object> get props => [systemId];
}
