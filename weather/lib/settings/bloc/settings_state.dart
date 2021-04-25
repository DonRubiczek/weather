part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class Initial extends SettingsState {}

class AppSettingsChanged extends SettingsState {}
