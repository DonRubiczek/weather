import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/backend/backend.dart';
import 'package:weather/day_forecast/bloc/day_forecast_bloc.dart';
import 'package:weather/repository/model/consolidated_weather.dart';
import 'package:weather/repository/model/location.dart';
import 'package:weather/widgets/error_card.dart';
import 'package:weather/widgets/loader.dart';
import 'package:weather/widgets/weather_card.dart';

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
          key: const Key(
            'dayForecastAppBarBackButton',
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
            return _buildPage(state.data, context);
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

  Widget _buildPage(List<ConsolidatedWeather> data, BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: data.isNotEmpty
          ? Container(
              color: Colors.white10,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: data.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return WeatherCard(
                    weatherData: data[index],
                  );
                },
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.pink,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  color: Colors.green,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 0.66,
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'No weather data for this date and location',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        backgroundColor: Colors.black,
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
