import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/repository/model/consolidated_weather.dart';
import 'package:weather/utils/converters.dart';
import 'package:weather/theme/app_specific_theme.dart';

import 'package:weather/l10n/l10n.dart';

class WeatherCard extends StatelessWidget {
  WeatherCard({Key? key, required this.weatherData}) : super(key: key);

  final ConsolidatedWeather weatherData;
  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(
        '${context.l10n.weather_card_key}'
        '${weatherData.id}',
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
                          '${context.l10n.weather_card_sky_header_name}'
                          '${weatherData.weatherStateName.toLowerCase()}',
                          style: context.theme.headline2,
                          key: Key(
                            context.l10n.weather_card_sky_header_key,
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
                        '${context.l10n.weather_card_wind_header_name}'
                        '${weatherData.windDirectionCompass} '
                        '${weatherData.windDirection?.round().toString()}°'
                        ', ${context.l10n.weather_card_speed_header_name}'
                        '${weatherData.windSpeed?.round().toString()}',
                        style: context.theme.headline2,
                        key: Key(
                          context.l10n.weather_card_wind_header_key,
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
                    context.l10n.weather_card_temperature_header_name,
                    style: context.theme.headline2,
                    key: Key(
                      context.l10n.weather_card_temp_header_key,
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
                                context.l10n.weather_card_temp_header_name,
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
                      '${context.l10n.weather_card_humidity_header_name}'
                      '${weatherData.humidity?.round().toString()}',
                      style: context.theme.headline2,
                    ),
                    key: Key(
                      context.l10n.weather_card_humidity_header_key,
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
                      '${context.l10n.weather_card_vis_header_name}'
                      '${weatherData.visibility?.round()}',
                      style: context.theme.headline2,
                    ),
                    key: Key(
                      context.l10n.weather_card_visibility_header_key,
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
                      '${context.l10n.weather_card_air_pressure_header_name}'
                      '${weatherData.airPressure?.round()}',
                      style: context.theme.headline2,
                    ),
                    key: Key(
                      context.l10n.weather_card_air_pressure_header_key,
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
                      '${context.l10n.weather_card_predict_header_name}'
                      '${weatherData.predictability?.round()}',
                      key: Key(
                        context.l10n.weather_card_predict_header_key,
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
