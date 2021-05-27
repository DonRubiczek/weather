import 'package:flutter_test/flutter_test.dart';
import 'package:weather/day_forecast/bloc/day_forecast_bloc.dart';

void main() {
  group(
    'DayForecastEvent',
    () {
      group(
        'GetLocationDayForecast',
        () {
          test(
            'can be instantiated',
            () {
              expect(
                GetLocationDayForecast(
                  locationId: '44418',
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
                GetLocationDayForecast(
                  locationId: '44418',
                  date: '2013/4/27/',
                ),
                equals(
                  GetLocationDayForecast(
                    locationId: '44418',
                    date: '2013/4/27/',
                  ),
                ),
              );
            },
          );

          test(
            'differs when locations ids or dates are different',
            () {
              expect(
                GetLocationDayForecast(
                  locationId: '444',
                  date: '2018/4/27/',
                ),
                isNot(
                  GetLocationDayForecast(
                    locationId: '44418',
                    date: '2013/4/27/',
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
