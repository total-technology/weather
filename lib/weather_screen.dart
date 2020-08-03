import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/location.dart';
import 'package:weather/weather_data.dart';

import 'weather_search.dart';

const TextStyle textsyle = TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    decoration: TextDecoration.none);

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.weatherData});
  final weatherData;

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var temperature;
  var pressure;
  var humidity;
  String name;
  String description;
  String weatherIcon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //updateUI(widget.weatherData);
    updateUI(widget.weatherData);
  }

  void updateUI(dynamic data) {
    temperature = data['main']['temp'];
    weatherIcon = data['weather'][0]['icon'];
    pressure = data['main']['pressure'];
    humidity = data['main']['humidity'];
    name = data['name'];
    description = data['weather'][0]['description'];
  }

  @override
  Widget build(BuildContext context) {
    var temp = temperature.toInt();
    var pr = pressure.toInt();
    var humid = humidity.toInt();
    var now = new DateTime.now();
    var result;

    var backGroundImage;
    if (now.hour >= 14 && now.hour <= 21) {
      backGroundImage = 'images/3_night_1125_2436_wallpaper.jpg';
    } else if (now.hour >= 22 || now.hour <= 6) {
      backGroundImage = 'images/1_cloudy_1125_2436_wallpaper.jpg';
    } else if (now.hour >= 6 && now.hour <= 13) {
      backGroundImage = 'images/2_sunny_1125_2436_wallpaper.jpg';
    }

    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(backGroundImage),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  onPressed: () async {
                    GeoLocation geolocation = GeoLocation();
                    await geolocation.getLocation();

                    OpenWeather openweather = OpenWeather(
                        long: geolocation.long, lat: geolocation.lat);
                    var weatherData = await openweather.getWeatherData();
                    setState(() {
                      updateUI(weatherData);
                    });
                    print('location update requested');
                  },
                  child: Icon(
                    FontAwesomeIcons.locationArrow,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                FlatButton(
                  onPressed: () async {
                    result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SearchWeather()));
                    print('new search page requested');
                    print(result);
                    GeoLocation geolocation1 = GeoLocation();
                    await geolocation1.getLocation();
                    OpenWeather openWeather2 = OpenWeather(
                      lat: geolocation1.lat,
                      long: geolocation1.long,
                    );
                    var weatherData =
                        await openWeather2.getSearchedWeatherData(result);
                    setState(() {
                      updateUI(weatherData);
                    });
                  },
                  child: Icon(
                    FontAwesomeIcons.searchLocation,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 70,
            ),
            Text(
              name,
              style: textsyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${temp.toString()}°',
                  style: textsyle,
                ),
                Image.network(
                    'http://openweathermap.org/img/wn/$weatherIcon@2x.png'),
              ],
            ),

            /*Text(
              description,
              style: textsyle,
            ),*/
          ],
        ),
      ),
    );
  }
}
