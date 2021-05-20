import 'package:flutter_test/flutter_test.dart';
import 'package:weather/home/bloc/home_bloc.dart';

void main() {
  group(
    'HomeEvent',
    () {
      group(
        'FindLocationByName',
        () {
          test(
            'can be instantiated',
            () {
              expect(
                FindLocationByNameEvent(
                  locationName: 'San',
                ),
                isNotNull,
              );
            },
          );

          test(
            'supports value equality',
            () {
              expect(
                FindLocationByNameEvent(
                  locationName: 'San',
                ),
                equals(
                  FindLocationByNameEvent(
                    locationName: 'San',
                  ),
                ),
              );
            },
          );

          test(
            'differs when locations names are different',
            () {
              expect(
                FindLocationByNameEvent(
                  locationName: 'San',
                ),
                isNot(
                  FindLocationByNameEvent(
                    locationName: 'London',
                  ),
                ),
              );
            },
          );
        },
      );

      group(
        'FindLocationByCoordinates',
        () {
          test(
            'can be instantiated',
            () {
              expect(
                FindLocationByCoordinatesEvent(
                  lattitude: '22',
                  longitude: '11',
                ),
                isNotNull,
              );
            },
          );

          test(
            'supports value equality',
            () {
              expect(
                FindLocationByCoordinatesEvent(
                  lattitude: '22',
                  longitude: '11',
                ),
                equals(
                  FindLocationByCoordinatesEvent(
                    lattitude: '22',
                    longitude: '11',
                  ),
                ),
              );
            },
          );

          test(
            'differs when search coordinates are different',
            () {
              expect(
                FindLocationByCoordinatesEvent(
                  lattitude: '22',
                  longitude: '11',
                ),
                isNot(
                  FindLocationByCoordinatesEvent(
                    lattitude: '24',
                    longitude: '8',
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
