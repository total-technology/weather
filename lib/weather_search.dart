import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchWeather extends StatefulWidget {
  @override
  _SearchWeatherState createState() => _SearchWeatherState();
}

class _SearchWeatherState extends State<SearchWeather> {
  @override
  Widget build(BuildContext context) {
    String searchedCity;
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/1_cloudy_1125_2436_wallpaper.jpg')),
        ),
        child: SafeArea(
            child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (change) {
                        searchedCity = change;
                      },
                      onSubmitted: (searchedCity) {
                        Navigator.pop(context, searchedCity);
                        print(searchedCity);
                      },
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          icon: Icon(
                            FontAwesomeIcons.locationArrow,
                            color: Colors.white,
                            size: 40,
                          ),
                          hintText: 'TYPE CITY NAME',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide.none,
                          )

/*                  labelStyle: TextStyle(
                        color: Colors.white,
                      ),*/
                          ),
                    ),
                  ),
                ],
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context, searchedCity);
                print(searchedCity);
              },
              child: Text(
                'Search Weather',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
