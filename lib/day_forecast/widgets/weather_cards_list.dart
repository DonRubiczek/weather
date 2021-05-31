import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/repository/model/consolidated_weather.dart';
import 'package:weather/widgets/weather_card.dart';

import 'package:weather/l10n/l10n.dart';

class WeatherCardsList extends StatelessWidget {
  const WeatherCardsList({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<ConsolidatedWeather> data;

  @override
  Widget build(BuildContext context) {
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
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      context.l10n.weather_cards_list_empty,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
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
