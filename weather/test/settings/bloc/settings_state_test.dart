import 'package:flutter_test/flutter_test.dart';
import 'package:weather/settings/bloc/settings_bloc.dart';

void main() {
  group(
    'SettingsState',
    () {
      group(
        'supports value equality',
        () {
          test(
            'when states are the same - initial',
            () {
              final stateA = Initial();
              final stateB = Initial();
              expect(
                stateA,
                equals(stateB),
              );
            },
          );

          test(
            'when states are different',
            () {
              final stateA = Initial();
              final stateB = AppSettingsChanged();
              expect(
                stateA,
                isNot(
                  equals(stateB),
                ),
              );
            },
          );
        },
      );
    },
  );
}
