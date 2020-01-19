import 'package:farmers_clubbing/WeatherPage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:translator/translator.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

String city = "bhiwadi";

class _WeatherState extends State<Weather> {
  List<String> weatherItems = [];
  final translare = new GoogleTranslator();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10.0), child: updateWeather());
  }

  Future<Map> getWeather() async {
    String apiUrl =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=87329b63a807fe7d3e4a0acf5e84811e&units=metric";
    http.Response response = await http.get(apiUrl);

    return jsonDecode(response.body);
  }

  Widget updateWeather() {
    return FutureBuilder(
        future: getWeather(),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map content = snapshot.data;
            String forecastId = content['weather'][0]['icon'];
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Image(
                        width: 120,
                        image: NetworkImage(
                            "http://openweathermap.org/img/wn/$forecastId@2x.png"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        child: Text(
                          content['main']['temp'].toString() + "℃",
                          style: TextStyle(fontSize: 40.0),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Text(
                      content['weather'][0]['description'] +
                          " in " +
                          content['name'],
                      style: TextStyle(fontSize: 25.0),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: SpinKitThreeBounce(
                color: Colors.white,
                size: 60.0,
              ),
            );
          }
        });
  }
}
