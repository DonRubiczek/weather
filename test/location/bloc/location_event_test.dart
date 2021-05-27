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

      group(
        'NavigateToLocationForecast',
        () {
          test(
            'can be instantiated',
            () {
              expect(
                NavigateToLocationForecast(
                  date: '2013/4/27/',
                ),
                isNotNull,
              );
            },
          );

          test(
            'supports value equality',
            () {
              expect(
                NavigateToLocationForecast(
                  date: '2013/4/27/',
                ),
                equals(
                  NavigateToLocationForecast(
                    date: '2013/4/27/',
                  ),
                ),
              );
            },
          );

          test(
            'differs when dates are different',
            () {
              expect(
                NavigateToLocationForecast(
                  date: '2013/4/27/',
                ),
                isNot(
                  NavigateToLocationForecast(
                    date: '2013/4/11/',
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
