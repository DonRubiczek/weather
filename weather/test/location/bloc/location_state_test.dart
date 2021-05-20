import 'package:flutter_test/flutter_test.dart';
import 'package:weather/location/bloc/location_bloc.dart';

void main() {
  group(
    'HomeState',
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
                equals(stateB),
              );
            },
          );

          test(
            'when states are different',
            () {
              final stateA = Initial();
              final stateB = Error();
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