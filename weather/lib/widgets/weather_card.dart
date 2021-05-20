import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/repository/model/consolidated_weather.dart';
import 'package:weather/utils/converters.dart';
import 'package:weather/theme/app_specific_theme.dart';

class WeatherCard extends StatelessWidget {
  WeatherCard({Key? key, required this.weatherData}) : super(key: key);

  final ConsolidatedWeather weatherData;
  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key(
        'locationWeatherCardKey',
      ),
      width: 300,
      decoration: BoxDecoration(
        color: context.theme.backgroundSecondaryColor,
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${weatherData.applicableDate}',
                  style: TextStyle(
                    color: context.theme.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.wb_cloudy,
                        color: context.theme.secondaryColor,
                      ),
                      Flexible(
                        child: Text(
                          'sky: ${weatherData.weatherStateName.toLowerCase()}',
                          style: context.theme.headline2,
                          key: const Key(
                            'locationWeatherSkyHeaderKey',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    convertWindDirToIcon(
                      weatherData.windDirectionCompass,
                      context,
                    ),
                    Flexible(
                      child: Text(
                        'wind: ${weatherData.windDirectionCompass} '
                        '${weatherData.windDirection?.round().toString()}°'
                        ', speed ${weatherData.windSpeed?.round().toString()}',
                        style: context.theme.headline2,
                        key: const Key(
                          'locationWeatherWindHeaderKey',
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.thermostat_outlined,
                    color: context.theme.errorColor,
                  ),
                  Text(
                    'temperature:',
                    style: context.theme.headline2,
                    key: const Key(
                      'locationWeatherTempHeaderKey',
                    ),
                  ),
                  // const SizedBox(
                  //   width: 5,
                  // ),
                  // weatherData.minTemp != null
                  //     ? Container(
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: <Widget>[
                  //             Text(
                  //               '${weatherData.minTemp?.round().toString()}',
                  //               style: context.theme.headline1,
                  //             ),
                  //             Text(
                  //               'min',
                  //               style: context.theme.headline2,
                  //             )
                  //           ],
                  //         ),
                  //       )
                  //     : Container(),
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
                                style: context.theme.headline1,
                              ),
                              Text(
                                'temp',
                                style: context.theme.headline2,
                              )
                            ],
                          ),
                        )
                      : Container(),
                  // const SizedBox(
                  //   width: 5,
                  // ),
                  // weatherData.maxTemp != null
                  //     ? Container(
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: <Widget>[
                  //             Text(
                  //               '${weatherData.maxTemp?.round().toString()}',
                  //               style: context.theme.headline1,
                  //             ),
                  //             Text(
                  //               'max',
                  //               style: context.theme.headline2,
                  //             )
                  //           ],
                  //         ),
                  //       )
                  //     : Container()
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.opacity,
                    color: context.theme.secondaryColor,
                  ),
                  Flexible(
                    child: Text(
                      'humidity: ${weatherData.humidity?.round().toString()}',
                      style: context.theme.headline2,
                    ),
                    key: const Key(
                      'locationWeatherHumidityHeaderKey',
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.visibility,
                    color: context.theme.secondaryColor,
                  ),
                  Flexible(
                    child: Text(
                      'visibility: ${weatherData.visibility?.round().toString()}',
                      style: context.theme.headline2,
                    ),
                    key: const Key(
                      'locationWeatherVisibilityHeaderKey',
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.compare_arrows,
                    color: context.theme.secondaryColor,
                  ),
                  Flexible(
                    child: Text(
                      'air pressure: ${weatherData.airPressure?.round().toString()}',
                      style: context.theme.headline2,
                    ),
                    key: const Key(
                      'locationWeatherAirPressureHeaderKey',
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.online_prediction,
                    color: context.theme.secondaryColor,
                  ),
                  Flexible(
                    child: Text(
                      'predictability: ${weatherData.predictability?.round().toString()}',
                      key: const Key(
                        'locationWeatherPredictHeaderKey',
                      ),
                      style: TextStyle(
                        color: context.theme.bodyTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
