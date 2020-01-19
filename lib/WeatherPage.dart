import 'dart:convert';
import 'package:farmers_clubbing/Weather.dart';
import 'package:farmers_clubbing/Weather.dart' as weath;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

String precaution;

class _WeatherPageState extends State<WeatherPage> {
  String city = "bhiwadi";
  DateTime now = new DateTime.now();
  String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          MaterialButton(
              onPressed: () {
                return showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Select Location'),
                        content: TextField(
                          onChanged: (value) {
                            city = value;
                          },
                          decoration:
                              InputDecoration(hintText: "Type City Name"),
                        ),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop(city);
                                setState(() {
                                  city = city;
                                  weath.city = city;
                                });
                              },
                              child: Text("OK"))
                        ],
                      );
                    });
              },
              child: Icon(Icons.search)),
        ],
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffebab66),
      ),
      body: showWeather(),
    );
  }

  Future<Map> getWeather() async {
    String apiUrl =
        "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=87329b63a807fe7d3e4a0acf5e84811e&units=metric";
    http.Response response = await http.get(apiUrl);
    return jsonDecode(response.body);
  }

  Widget showWeather() {
    return FutureBuilder(
        future: getWeather(),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map content = snapshot.data;
            String image =
                content['list'][0]['weather'][0]['id'].toString() + ".png";
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xffebab66), Color(0xffe7418c)])),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Weather(),
                    ],
                  ),
                  // Text(
                  //   content['list'][0]['weather'][0]['description'] +
                  //       " in " +
                  //       content['city']['name'],
                  //   style: TextStyle(fontSize: 25.0),
                  // ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: ListView.builder(
                        itemCount: content['cnt'] - 0,
                        itemBuilder: (BuildContext context, int index) {
                          String forecastId = content['list'][index]['weather']
                                  [0]['icon']
                              .toString();
                          int precautionId =
                              content['list'][index]['weather'][0]['id'];
                          switch (precautionId) {
                            case 800:
                              precaution = "No Need to Worry";
                              break;
                            case 801:
                              precaution =
                                  "No Need to Worry There Will be few Cloud in Sky";
                              break;
                            case 802:
                              precaution = "No Need to Worry";
                              break;
                            case 803:
                              precaution = "No Need to Worry";
                              break;
                            case 804:
                              precaution = "No Need to Worry";
                              break;
                            case 805:
                              precaution = "No Need to Worry";
                              break;
                            case 500:
                              precaution =
                                  "There Could be Light Rain in Your Area";
                              break;
                            case 501:
                              precaution =
                                  "There Could be Moderate Rain in your Area";
                              break;
                            case 502:
                              precaution = "There Could be Heavy Rain";
                              break;
                            case 503:
                              precaution = "There Could be Very Heavy Rain";
                              break;
                            case 504:
                              precaution =
                                  "There Could be Extreme Heavy Rain, It Can Damage Much of the Crops";
                              break;
                            case 200:
                              precaution =
                                  "There Could be Thunderstorm with Light Rain";
                              break;
                            case 201:
                              precaution =
                                  "There Could be Thunderstorm with Rain";
                              break;
                            case 202:
                              precaution =
                                  "There Could be Thunderstorm with Heavy rain";
                              break;
                            case 210:
                              precaution =
                                  "There Could be Some Light Thunderstorm";
                              break;
                            case 211:
                              precaution = "There Could be Some Thunderstorm";
                              break;
                            case 212:
                              precaution = "There Could be Heavy Thunderstorm";
                              break;
                            case 600:
                              precaution =
                                  "There Could be Light Snowfall in Your Area";
                              break;
                            case 601:
                              precaution =
                                  "There Could be Some Snowfall in your Area";
                              break;
                            case 602:
                              precaution =
                                  "There Could be Heavy Snowfall in Your Area";
                              break;
                            case 615:
                              precaution =
                                  "There Could be Snowfall with Light Rain";
                              break;
                            case 616:
                              precaution =
                                  "There Could be Snowfall with Heavy rain";
                              break;
                            default:
                              precaution = "No Need to Worry";
                          }
                          int i = index;
                          return AnimationConfiguration.staggeredList(
                            position: 1,
                            child: SlideAnimation(
                              verticalOffset: 60,
                              duration: const Duration(milliseconds: 505),
                              child: Container(
                                height: 200,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  margin: EdgeInsets.all(20.0),
                                  elevation: 10.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          content['list'][i]['dt_txt'],
                                          style: TextStyle(fontSize: 15.0),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Row(
                                              children: <Widget>[
                                                Image(
                                                  width: 50,
                                                  image: NetworkImage(
                                                      "http://openweathermap.org/img/wn/$forecastId@2x.png"),
                                                ),
                                                Text(
                                                  content['list'][i]['main']
                                                              ['temp']
                                                          .toString() +
                                                      "℃",
                                                  style:
                                                      TextStyle(fontSize: 15.0),
                                                ),
                                                SizedBox(
                                                  width: 13,
                                                ),
                                                Text(
                                                  content['list'][i]['wind']
                                                              ['speed']
                                                          .toString() +
                                                      " km/h",
                                                  style:
                                                      TextStyle(fontSize: 15.0),
                                                ),
                                                // ListView.builder(
                                                //   itemCount: 8,
                                                //   itemBuilder: (BuildContext context, int ind) {
                                                //     ind += 8;
                                                //     return Text(content['list'][])
                                                //   },
                                                // )
                                                SizedBox(
                                                  width: 20.0,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    precaution,
                                                    style: TextStyle(
                                                        fontSize: 17.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          child: Text(
                                              "You should be aware of Locusts in this Season"),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PestPage()));
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xffebab66), Color(0xffe7418c)])),
              child: Center(
                child: SpinKitThreeBounce(
                  color: Colors.white,
                  size: 60.0,
                ),
              ),
            );
          }
        });
  }
}

class PestPage extends StatefulWidget {
  @override
  _PestPageState createState() => _PestPageState();
}

class _PestPageState extends State<PestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pest Alert"),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffebab66),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFfbab66), Color(0xFFf7418c)])),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                "Pest Attacks in Following Areas",
                style: TextStyle(fontSize: 25.0),
              ),
              Card(
                margin: EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Mehsana, Kutch, Patan and Sabarkantha  Farmers have a new headache: Pest attacks on cotton, maize",
                    style: TextStyle(fontSize: 23.0),
                  ),
                ),
              ),
              Text(
                "Precautions",
                style: TextStyle(fontSize: 23.0),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                child: Card(
                  margin: EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "1. Pour 1 oz. of neem oil into a pressurized lawn sprayer.  2. Pour in 1 gallon of tap water.  3. Place 7 to 10 drops of mild dish soap into the solution. The dish soap helps the oil stick to vegetation surfaces.  4. Mix the solution together with a mixing spoon. If your sprayer holds more than 1 gallon, you can increase the recipe; just maintain a ratio of 1 oz. of neem oil to 1 gallon of water.  5. Pressurize the pressure sprayer by pumping the handle several times.  6. Spray your entire yard with the solution during the morning, when locusts are still in the ground.  7. Repeat the process daily until you see a reduction in locust population.",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
