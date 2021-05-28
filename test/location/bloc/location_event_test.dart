import 'package:flutter_test/flutter_test.dart';
import 'package:weather/location/bloc/location_bloc.dart';

void main() {
  group(
    'LocationEvent',
    () {
      group(
        'GetLocationData',
        () {
          test(
            'can be instantiated',
            () {
              expect(
                GetLocationData(
                  locationId: '44418',
                ),
                isNotNull,
              );
            },
          );

          test(
            'supports value equality',
            () {
              expect(
                GetLocationData(
                  locationId: '44418',
                ),
                equals(
                  GetLocationData(
                    locationId: '44418',
                  ),
                ),
              );
            },
          );

          test(
            'differs when locations ids are different',
            () {
              expect(
                GetLocationData(
                  locationId: '44418',
                ),
                isNot(
                  GetLocationData(
                    locationId: '44419',
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
