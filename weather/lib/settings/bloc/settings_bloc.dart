import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:weather/repository/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({required this.settingsRepository}) : super(Initial());

  final SettingsRepository settingsRepository;

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is ChangeMetricSystem) {
      yield* mapChangeMetricSystemToState(event);
    } else if (event is ChangeTheme) {
      yield* mapChangeThemeToState(event);
    }
  }

  Stream<SettingsState> mapChangeMetricSystemToState(
    ChangeMetricSystem event,
  ) async* {
    await settingsRepository.setMetricVariable(
      event.systemId,
    );

    yield AppSettingsChanged();
  }

  Stream<SettingsState> mapChangeThemeToState(
    ChangeTheme event,
  ) async* {
    await settingsRepository.setThemeVariable(
      event.themeId,
    );

    yield AppSettingsChanged();
  }
}
