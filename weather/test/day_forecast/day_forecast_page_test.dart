import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/day_forecast/bloc/day_forecast_bloc.dart';
import 'package:weather/day_forecast/day_forecast_page.dart';
import 'package:weather/repository/model/location.dart';

import '../helpers/pump_app.dart';

class FakeDayForecastEvent extends Fake implements DayForecastEvent {}

class FakeDayForecastState extends Fake implements DayForecastState {}

class MockDayForecastBloc extends MockBloc<DayForecastEvent, DayForecastState>
    implements DayForecastBloc {}

extension on WidgetTester {
  Future<void>? pumpDayForecastView({
    required DayForecastBloc bloc,
    required Location location,
    required String date,
  }) {
    return pumpApp(
      BlocProvider.value(
        value: bloc,
        child: DayForecastView(location: location, date: date),
      ),
    );
  }
}

void main() {
  setUpAll(() {
    registerFallbackValue<DayForecastEvent>(FakeDayForecastEvent());
    registerFallbackValue<DayForecastState>(FakeDayForecastState());
  });

  group(
    'DayForecastView',
    () {
      late DayForecastBloc bloc;
      final location = Location('', '', '', 1, 1);
      final date = '';

      setUp(
        () {
          bloc = MockDayForecastBloc();
          whenListen(
            bloc,
            Stream.fromIterable([Initial()]),
            initialState: Initial(),
          );
        },
      );

      testWidgets(
        'renders page',
        (tester) async {
          await tester.pumpDayForecastView(
            bloc: bloc,
            location: location,
            date: date,
          );
          expect(find.byType(DayForecastView), findsOneWidget);
        },
      );
    },
  );
}
