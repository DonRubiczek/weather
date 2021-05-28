import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/repository/model/consolidated_weather.dart';
import 'package:weather/widgets/weather_card.dart';

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
