import 'package:flutter_test/flutter_test.dart';
import 'package:weather/settings/bloc/settings_bloc.dart';

void main() {
  group(
    'SettingsState',
    () {
      group(
        'does not support value equality',
        () {
          test(
            'when states are the same - initial',
            () {
              final stateA = Initial();
              final stateB = Initial();
              expect(
                stateA,
                isNot(
                  equals(
                    stateB,
                  ),
                ),
              );
            },
          );

          test(
            'when states are the same - appsettingschanged',
            () {
              final stateA = AppSettingsChanged();
              final stateB = AppSettingsChanged();
              expect(
                stateA,
                isNot(
                  equals(
                    stateB,
                  ),
                ),
              );
            },
          );

          test(
            'when states are the same - error',
            () {
              final stateA = Error();
              final stateB = Error();
              expect(
                stateA,
                isNot(
                  equals(
                    stateB,
                  ),
                ),
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
                  equals(
                    stateB,
                  ),
                ),
              );
            },
          );
        },
      );
    },
  );
}
