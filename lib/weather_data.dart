import 'dart:convert';

import 'package:http/http.dart' as http;

const String openWeatherAPI = '0bc315013a259df8f1550f38e05e242b';

class OpenWeather {
  double lat;
  double long;

  OpenWeather({
    this.lat,
    this.long,
  });

  Future getSearchedWeatherData(String cityName) async {
    var openWeatherURL =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$openWeatherAPI';
    http.Response response = await http.get(openWeatherURL);
    if (response.statusCode == 200) {
      //print(response.body);
      var data = response.body;
      return jsonDecode(data);
    } else {
      print('Error occurred');
    }
  }

  Future getWeatherData() async {
    var openWeatherURL =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&units=metric&appid=$openWeatherAPI';
    http.Response response = await http.get(openWeatherURL);
    if (response.statusCode == 200) {
      //print(response.body);
      var data = response.body;
      return jsonDecode(data);
    } else {
      print('Error occurred');
    }
  }
}

/*
void test() async {
  var openWeatherURL =
      'https://api.openweathermap.org/data/2.5/weather?lat=37.4219983&lon=-122.084&appid=0bc315013a259df8f1550f38e05e242b';
  var response = await http.get(openWeatherURL);
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print(response.statusCode);
  }
}
*/
