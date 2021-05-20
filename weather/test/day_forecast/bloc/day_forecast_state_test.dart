import 'package:flutter_test/flutter_test.dart';
import 'package:weather/day_forecast/bloc/day_forecast_bloc.dart';

void main() {
  group(
    'DayForecastState',
    () {
      group(
        'supports value equality',
        () {
          test(
            'when states are the same',
            () {
              final stateA = Initial();
              final stateB = Initial();
              expect(
                stateA,
                equals(
                  stateB,
                ),
              );
            },
          );

          test(
            'when states are different',
            () {
              final stateA = Initial();
              final stateB = Loading();
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
