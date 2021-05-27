import 'package:flutter_test/flutter_test.dart';
import 'package:weather/location/bloc/location_bloc.dart';
import 'package:weather/repository/model/location_data.dart';
import 'package:weather/repository/model/parent.dart';

void main() {
  group(
    'HomeState',
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
                equals(
                  stateB,
                ),
              );
            },
          );

          test(
            'when states are the same - locationsDataCollected',
            () {
              final data = LocationData(
                [],
                'time',
                'sunRise',
                'sunSet',
                'timezoneName',
                Parent(
                  'title',
                  'locationType',
                  'lattLong',
                  123,
                ),
                [],
                'title',
                'locationType',
                123,
                'lattlong',
                'timezone',
              );
              final stateA = LocationDataCollected(
                data,
              );
              final stateB = LocationDataCollected(
                data,
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
            'when states are the same - navigate',
            () {
              final stateA = Navigate(
                'data',
              );
              final stateB = Navigate(
                'data',
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
            'when states are different - initial, error',
            () {
              final stateA = Initial();
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
            'when states are different - navigate, loading',
            () {
              final stateA = Navigate(
                'data',
              );
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
