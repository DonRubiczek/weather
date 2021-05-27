import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather/backend/backend.dart';
import 'package:weather/day_forecast/day_forecast_page.dart';
import 'package:weather/repository/model/location.dart';
import 'package:weather/repository/model/location_data.dart';
import 'package:weather/repository/model/sources.dart';
import 'package:weather/theme/app_theme.dart';
import 'package:weather/widgets/error_card.dart';
import 'package:weather/widgets/loader.dart';
import 'package:weather/widgets/weather_card.dart';
import 'package:weather/theme/app_specific_theme.dart';

import 'bloc/location_bloc.dart';

class LocationPage extends StatelessWidget {
  LocationPage._({
    Key? key,
    required this.location,
  }) : super(key: key);

  final Location location;

  static MaterialPageRoute route({
    required Location location,
  }) =>
      MaterialPageRoute(
        builder: (_) => LocationPage._(location: location),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationBloc(
        context.read<Backend>().weatherRepository,
      )..add(
          GetLocationData(
            locationId: location.woeid.toString(),
          ),
        ),
      child: LocationView(
        location: location,
      ),
    );
  }
}

// ignore: must_be_immutable
class LocationView extends StatelessWidget {
  LocationView({
    Key? key,
    required this.location,
  }) : super(key: key);
  DateTime selectedDate = DateTime.now();
  final Location location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          '${location.title}',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          key: const Key(
            'locationAppBarBackButton',
          ),
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(
            context,
          ),
        ),
      ),
      backgroundColor: context.theme.backgroundColor,
      body: BlocConsumer<LocationBloc, LocationState>(
        buildWhen: (previousState, state) {
          return state is! Navigate;
        },
        listener: (BuildContext context, state) {
          if (state is Navigate) {
            Navigator.push(
              context,
              DayForecastPage.route(
                location: location,
                date: state.data,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LocationDataCollected)
            return _buildPage(
              state.data,
              context.theme,
              context,
            );
          else if (state is Initial) {
            return Loader();
          } else if (state is Loading) {
            return Loader();
          } else
            return ErrorCard(
              errorMessage: '',
            );
        },
      ),
    );
  }

  Widget _buildPage(LocationData data, AppTheme theme, BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: <Widget>[
          _weatherPageHeaderData(
            data,
            theme,
          ),
          _buildDatePickerContainer(
            context,
            theme,
          ),
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: data.consolidatedWeatherData.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return WeatherCard(
                  weatherData: data.consolidatedWeatherData[index],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 3, 0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Sources',
                style: TextStyle(
                  color: theme.bodyTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.black,
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: data.sources.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _buildSourcesTile(
                  data.sources[index],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDatePickerContainer(BuildContext context, AppTheme theme) {
    var redColor = theme.errorColor;
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(
          right: BorderSide(
            width: 3.0,
            color: redColor,
          ),
          top: BorderSide(
            width: 3.0,
            color: redColor,
          ),
          left: BorderSide(
            width: 3.0,
            color: redColor,
          ),
          bottom: BorderSide(
            width: 3.0,
            color: redColor,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Choose date from the past and display location weather:',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  key: const Key(
                    'locationSelectDateButtonKey',
                  ),
                  onPressed: () => _selectDate(context),
                  child: const Text(
                    'Select date',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      redColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${selectedDate.toLocal()}'.split(' ')[0],
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) selectedDate = picked;
    var correctDateFormat =
        '${selectedDate.toLocal()}'.split(' ')[0].replaceAll(
              RegExp(r'-'),
              '/',
            );
    BlocProvider.of<LocationBloc>(context).add(
      NavigateToLocationForecast(date: correctDateFormat),
    );
  }

  Container _buildSourcesTile(Sources data) {
    return Container(
      key: const Key('locationSourceTileKey'),
      padding: const EdgeInsets.all(4),
      child: Center(
        child: InkWell(
          child: Text(
            data.title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          onTap: () => launch(data.url),
        ),
      ),
    );
  }

  Container _weatherPageHeaderData(
    LocationData data,
    AppTheme theme,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          _headerAlignedText(
            theme,
            'location type: ${data.locationType}',
          ),
          _headerAlignedText(
            theme,
            'lattitude: ${data.lattlong.split(',').first}',
          ),
          _headerAlignedText(
            theme,
            'longitude: ${data.lattlong.split(',').last}',
          ),
          _headerAlignedText(
            theme,
            'timezone: ${data.timezone}-${data.timezoneName}',
          ),
          _headerAlignedText(
            theme,
            'time: ${data.time}',
          ),
          _headerAlignedText(
            theme,
            'sun rise: ${data.sunRise}',
          ),
          _headerAlignedText(
            theme,
            'sun set: ${data.sunSet}',
          ),
        ],
      ),
    );
  }

  Align _headerAlignedText(AppTheme theme, String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: theme.headline2,
        textAlign: TextAlign.left,
        key: const Key(
          'locationHeaderKey',
        ),
      ),
    );
  }
}
