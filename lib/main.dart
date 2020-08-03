import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'location.dart';
import 'weather_data.dart';
import 'weather_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(body: MyBody()),
    ),
  );
}

class MyBody extends StatefulWidget {
  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlocationData();
  }

  Future<String> data;
  Future getlocationData() async {
    GeoLocation cb1 = GeoLocation();
    await cb1.getLocation();

    OpenWeather op1 = OpenWeather(lat: cb1.lat, long: cb1.long);
    var data = await op1.getWeatherData();
    //print(data);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => WeatherScreen(
                  weatherData: data,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown,
      child: SpinKitFadingCircle(
        color: Colors.white,
        size: 50.0,
      ),
    );
  }
}
