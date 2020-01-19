import 'dart:convert';

import 'package:farmers_clubbing/Prices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class PricesPage extends StatefulWidget {
  final String item;
  PricesPage(this.item);
  @override
  _PricesPageState createState() => _PricesPageState(item);
}

int limit = 85;

class _PricesPageState extends State<PricesPage> {
  String item;
  _PricesPageState(this.item);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffebab66),
        title: Text(
          item,
          style: TextStyle(fontSize: 35.0),
        ),
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: showRegions(item),
    );
  }
}

Future<Map> getRegions() async {
  String url =
      "https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=579b464db66ec23bdd0000017e500705292349b2561aca396eeb67eb&format=json&offset=0&limit=$limit";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

//List<int> offset = [];
List<String> region = [];

Widget showRegions(String item) {
  String itemName = item;
  // showRegions(item);
  return FutureBuilder(
    future: getRegions(),
    builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
      if (snapshot.hasData) {
        Map content = snapshot.data;
        for (int i = 0; i < limit; i++) {
          if (itemName == content["records"][i]["commodity"] &&
              !region.contains(content["records"][i]["state"])) {
            //offset.add(i);
            region.add(content["records"][i]["state"]);
          }
        }
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffebab66), Color(0xffe7418c)])),
          child: ListView.builder(
            itemCount: region.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (content) =>
                            regionPage(region[index], itemName),
                      ));
                },
                child: Card(
                  margin: EdgeInsets.all(10.0),
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Center(
                      child: Container(
                          height: 50.0,
                          child: Center(
                              child: Text(
                            region[index],
                            style: TextStyle(fontSize: 20.0),
                          )))),
                ),
              );
            },
          ),
        );
      } else {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffebab66), Color(0xffe7418c)])),
          child: SpinKitThreeBounce(
            color: Colors.black,
            size: 40.0,
          ),
        );
      }
    },
  );
}

class regionPage extends StatefulWidget {
  final String region;
  String item;
  regionPage(this.region, this.item);
  @override
  _regionPageState createState() => _regionPageState(region, item);
}

class _regionPageState extends State<regionPage> {
  final String region;
  final String item;
  _regionPageState(this.region, this.item);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffebab66),
        title: Text(
          region,
          style: TextStyle(fontSize: 35.0),
        ),
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ),
      body: showMarket(region, item),
    );
  }
}

Widget showMarket(String region1, String item) {
  String region = region1;
  String itemName = item;
  List<String> market = [];
  List<String> marketPrice = [];
  return FutureBuilder(
    future: getRegions(),
    builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
      if (snapshot.hasData) {
        Map content = snapshot.data;
        for (int i = 0; i < limit; i++) {
          if (region == content["records"][i]["state"] &&
              itemName == content["records"][i]["commodity"]) {
            market.add(content["records"][i]["market"]);
            marketPrice.add(content["records"][i]["min_price"]);
            marketPrice.add(content["records"][i]["max_price"]);
          }
        }
        int j = -2;
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffebab66), Color(0xffe7418c)])),
          child: ListView.builder(
            itemCount: market.length - 0,
            itemBuilder: (BuildContext context, int index) {
              j += 2;
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 5.0,
                margin: EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                market[index],
                                style: TextStyle(fontSize: 30.0),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Min Price" + "  ",
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                      Text("Max Price",
                                          style: TextStyle(fontSize: 18.0))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(marketPrice[j] + "₹  ",
                                          style: TextStyle(fontSize: 18.0)),
                                      Text(marketPrice[j + 1] + "₹",
                                          style: TextStyle(fontSize: 18.0))
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              );
            },
          ),
        );
      } else {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffebab66), Color(0xffe7418c)])),
          child: SpinKitThreeBounce(
            color: Colors.black,
            size: 40.0,
          ),
        );
      }
    },
  );
}
