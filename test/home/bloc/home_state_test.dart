import 'package:flutter_test/flutter_test.dart';
import 'package:weather/home/bloc/home_bloc.dart';
import 'package:weather/repository/model/location.dart';

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
            'when states are the same - locationscollected',
            () {
              final location = Location(
                'San',
                'City',
                '22,33',
                2233,
                123,
              );
              final stateA = LocationsCollected(
                [
                  location,
                ],
              );
              final stateB = LocationsCollected(
                [
                  location,
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
            'when states are different - initial, locationscollected',
            () {
              final stateA = Initial();
              final stateB = LocationsCollected(
                [],
              );
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
            'when states are different - error,loading',
            () {
              final stateA = Error();
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
