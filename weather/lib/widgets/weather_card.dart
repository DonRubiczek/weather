import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/repository/model/consolidated_weather.dart';
import 'package:weather/theme/theme_provider.dart';
import 'package:weather/utils/converters.dart';

class WeatherCard extends StatelessWidget {
  WeatherCard({Key? key, required this.weatherData}) : super(key: key);

  final ConsolidatedWeather weatherData;
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context, listen: false).theme;
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: theme.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 0.5,
            spreadRadius: 0.5,
          )
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${weatherData.applicableDate}',
                style: TextStyle(
                  color: theme.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(Icons.wb_cloudy, color: theme.secondaryColor),
                  Text(
                    'sky: ${weatherData.weatherStateName.toLowerCase()}',
                    style: theme.headline2,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                convertWindDirToIcon(weatherData.windDirectionCompass, context),
                Text(
                  'wind: ${weatherData.windDirectionCompass} '
                  '${weatherData.windDirection?.round().toString()}°'
                  ', speed ${weatherData.windSpeed?.round().toString()}',
                  style: theme.headline2,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.thermostat_outlined,
                  color: theme.errorColor,
                ),
                Text(
                  'temperature:',
                  style: theme.headline2,
                ),
                const SizedBox(
                  width: 5,
                ),
                weatherData.minTemp != null
                    ? Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${weatherData.minTemp?.round().toString()}',
                              style: theme.headline1,
                            ),
                            Text(
                              'min',
                              style: theme.headline2,
                            )
                          ],
                        ),
                      )
                    : Container(),
                const SizedBox(
                  width: 5,
                ),
                weatherData.theTemp != null
                    ? Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              weatherData.theTemp!.round().toString(),
                              style: theme.headline1,
                            ),
                            Text(
                              'temp',
                              style: theme.headline2,
                            )
                          ],
                        ),
                      )
                    : Container(),
                const SizedBox(
                  width: 5,
                ),
                weatherData.maxTemp != null
                    ? Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${weatherData.maxTemp?.round().toString()}',
                              style: theme.headline1,
                            ),
                            Text(
                              'max',
                              style: theme.headline2,
                            )
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.opacity,
                  color: theme.secondaryColor,
                ),
                Text('humidity: ${weatherData.humidity?.round().toString()}',
                    style: theme.headline2),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.visibility,
                  color: theme.secondaryColor,
                ),
                Text(
                    'visibility: ${weatherData.visibility?.round().toString()}',
                    style: theme.headline2),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.compare_arrows,
                  color: theme.secondaryColor,
                ),
                Text(
                    'air pressure: ${weatherData.airPressure?.round().toString()}',
                    style: theme.headline2),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.online_prediction,
                  color: theme.secondaryColor,
                ),
                Text(
                  'predictability: ${weatherData.predictability?.round().toString()}',
                  style: TextStyle(
                    color: theme.bodyTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
