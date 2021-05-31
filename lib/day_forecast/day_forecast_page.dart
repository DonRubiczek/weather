import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/backend/backend.dart';
import 'package:weather/day_forecast/bloc/day_forecast_bloc.dart';
import 'package:weather/day_forecast/widgets/weather_cards_list.dart';
import 'package:weather/repository/model/location.dart';
import 'package:weather/widgets/error_card.dart';
import 'package:weather/widgets/loader.dart';

import 'package:weather/l10n/l10n.dart';

class DayForecastPage extends StatelessWidget {
  DayForecastPage._({
    Key? key,
    required this.location,
    required this.date,
  }) : super(key: key);

  final Location location;
  final String date;

  static MaterialPageRoute route({
    required Location location,
    required String date,
  }) =>
      MaterialPageRoute(
        builder: (_) => DayForecastPage._(
          location: location,
          date: date,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DayForecastBloc(
        context.read<Backend>().weatherRepository,
      )..add(
          GetLocationDayForecast(
            locationId: location.woeid.toString(),
            date: date,
          ),
        ),
      child: DayForecastView(
        location: location,
        date: date,
      ),
    );
  }
}

@visibleForTesting
class DayForecastView extends StatelessWidget {
  const DayForecastView({
    Key? key,
    required this.location,
    required this.date,
  }) : super(key: key);

  final Location location;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          '${location.title} $date',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          key: Key(
            context.l10n.day_forecast_page_back_button_key,
          ),
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(
            context,
          ),
        ),
      ),
      backgroundColor: Colors.lightGreen,
      body: BlocBuilder<DayForecastBloc, DayForecastState>(
        builder: (context, state) {
          if (state is DayForecastCollected)
            return WeatherCardsList(
              data: state.data,
            );
          else if (state is Loading) {
            return Loader();
          } else if (state is Error) {
            return ErrorCard(
              errorMessage: '',
            );
          } else
            return Container();
        },
      ),
    );
  }
}
