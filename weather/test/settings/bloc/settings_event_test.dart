import 'package:flutter_test/flutter_test.dart';
import 'package:weather/settings/bloc/settings_bloc.dart';

void main() {
  group(
    'SeetingsEvent',
    () {
      group(
        'ChangeTheme',
        () {
          test(
            'can be instantiated',
            () {
              expect(
                ChangeTheme(
                  themeId: 0,
                ),
                isNotNull,
              );
            },
          );

          test(
            'supports value equality',
            () {
              expect(
                ChangeTheme(
                  themeId: 0,
                ),
                equals(
                  ChangeTheme(
                    themeId: 0,
                  ),
                ),
              );
            },
          );

          test(
            'differs when theme id values are different',
            () {
              expect(
                ChangeTheme(
                  themeId: 0,
                ),
                isNot(
                  ChangeTheme(
                    themeId: 1,
                  ),
                ),
              );
            },
          );
        },
      );

      group(
        'ChangeMetricSystem',
        () {
          test(
            'can be instantiated',
            () {
              expect(
                ChangeMetricSystem(
                  systemId: 0,
                ),
                isNotNull,
              );
            },
          );

          test(
            'supports value equality',
            () {
              expect(
                ChangeMetricSystem(
                  systemId: 0,
                ),
                equals(
                  ChangeMetricSystem(
                    systemId: 0,
                  ),
                ),
              );
            },
          );

          test(
            'differs when id values are different',
            () {
              expect(
                ChangeMetricSystem(
                  systemId: 0,
                ),
                isNot(
                  ChangeMetricSystem(
                    systemId: 1,
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
