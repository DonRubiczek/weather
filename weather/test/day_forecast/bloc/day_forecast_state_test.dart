import 'package:flutter_test/flutter_test.dart';
import 'package:weather/day_forecast/bloc/day_forecast_bloc.dart';
import 'package:weather/repository/model/consolidated_weather.dart';

import '../../helpers/resources.dart';

void main() {
  group(
    'DayForecastState',
    () {
      group(
        'supports value equality',
        () {
          test(
            'when states are the same - inital',
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
            'when states are the same - loading',
            () {
              final stateA = Loading();
              final stateB = Loading();
              expect(
                stateA,
                equals(
                  stateB,
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
                equals(
                  stateB,
                ),
              );
            },
          );

          test(
            'when states are the same - dayForecastCollected',
            () {
              final data = getConsolidatedWeatherList().first;
              final stateA = DayForecastCollected(
                [
                  data,
                ],
              );
              final stateB = DayForecastCollected(
                [
                  data,
                ],
              );
              expect(
                stateA,
                equals(
                  stateB,
                ),
              );
            },
          );

          test(
            'when states are different - inital, loading',
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

          test(
            'when states are different - ',
            () {
              final stateA = Error();
              final stateB = DayForecastCollected([]);
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
