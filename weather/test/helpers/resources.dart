import 'package:weather/repository/model/consolidated_weather.dart';
import 'package:weather/repository/model/location.dart';
import 'package:weather/repository/model/location_data.dart';
import 'package:weather/repository/model/parent.dart';
import 'package:weather/repository/model/sources.dart';

LocationData getLocationData() {
  var sources = <Sources>[
    Sources(
      'BBC',
      'http,//www.bbc.co.uk/weather/',
    ),
    Sources(
      'Weather Underground',
      'https,//www.wunderground.com/?apiref=fc30dc3cd224e19b',
    ),
    Sources(
      'OpenWeatherMap',
      'http,//openweathermap.org/',
    ),
    Sources(
      'HAMweather',
      'http,//www.hamweather.com',
    ),
    Sources(
      'Met Office',
      'http,//www.metoffice.gov.uk/',
    ),
  ];
  var parent = Parent(
    'England',
    'Region / State / Province',
    '52.883560,-1.974060',
    24554868,
  );

  var consolidatedWeatherList = getConsolidatedWeatherList();

  return LocationData(
    consolidatedWeatherList,
    '2021-05-13T19,12,24.118975+01,00',
    '2021-05-13T05,11,30.918760+01,00',
    '2021-05-13T20,43,11.255541+01,00',
    'LMT',
    parent,
    sources,
    'London',
    'City',
    44418,
    '51.506321,-0.12714',
    'Europe/London',
  );
}

List<ConsolidatedWeather> getConsolidatedWeatherList() {
  return [
    ConsolidatedWeather(
      6458195808616448,
      'Light Rain',
      'lr',
      'ESE',
      '2021-05-13T15,32,02.331662Z',
      '2021-05-13',
      8.215,
      13.395,
      11.71,
      4.724408115034863,
      106.1685937400188,
      1006.0,
      84,
      8.81694653225165,
      75,
    ),
    ConsolidatedWeather(
      6128491704614912,
      'Light Rain',
      'lr',
      'NNE',
      '2021-05-13T15,32,02.746506Z',
      '2021-05-14',
      7.130000000000001,
      15.455,
      13.28,
      4.313319697598028,
      30.29213361107689,
      1009.5,
      69,
      11.40154000636284,
      75,
    ),
    ConsolidatedWeather(
      5590954569367552,
      'Light Rain',
      'lr',
      'SSW',
      '2021-05-13T15,32,03.152174Z',
      '2021-05-15',
      8.265,
      13.6,
      12.3,
      5.34320908801665,
      210.91901171401153,
      1001.0,
      79,
      11.046115684403086,
      75,
    ),
  ];
}

List<Location> getLocationList() {
  return [
    Location(
      'san1',
      'locationType',
      'lattLong',
      2233,
      123,
    ),
    Location(
      'san2',
      'locationType',
      'lattLong',
      2233,
      123,
    ),
    Location(
      'san3',
      'locationType',
      'lattLong',
      2233,
      123,
    ),
    Location(
      'san4',
      'locationType',
      'lattLong',
      2233,
      123,
    ),
    Location(
      'san5',
      'locationType',
      'lattLong',
      2233,
      123,
    ),
    Location(
      'san6',
      'locationType',
      'lattLong',
      2233,
      123,
    ),
    Location(
      'san7',
      'locationType',
      'lattLong',
      2233,
      123,
    ),
    Location(
      'san8',
      'locationType',
      'lattLong',
      2233,
      123,
    ),
    Location(
      'san9',
      'locationType',
      'lattLong',
      2233,
      123,
    ),
    Location(
      'san10',
      'locationType',
      'lattLong',
      2233,
      123,
    )
  ];
}
