import 'package:farmers_clubbing/pricePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'CommodityAPI.dart' as api;

class Prices extends StatefulWidget {
  @override
  _PricesState createState() => _PricesState();
}

class _PricesState extends State<Prices> {
  @override
  void initState() {
    getPrice();
    //api.fetchAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffebab66),
        title: Text(
          "Price",
          style: TextStyle(fontSize: 35.0),
        ),
      ),
      body: showItems(),
    );
  }
}

int limit = 85;
List<String> items = [];
Future<Map> getPrice() async {
  String url =
      "https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=579b464db66ec23bdd0000017e500705292349b2561aca396eeb67eb&format=json&offset=0&limit=$limit";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

Widget showItems() {
  return FutureBuilder(
    future: getPrice(),
    builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
      if (snapshot.hasData) {
        Map content = snapshot.data;
        for (int i = 0; i < limit; i++) {
          if (!items.contains(content["records"][i]["commodity"])) {
            items.add(content["records"][i]["commodity"]);
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
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: items.length - 1,
                  itemBuilder: (BuildContext context, int index) {
                    String image = items[index];
                    return AnimationConfiguration.staggeredList(
                      position: 0,
                      child: SlideAnimation(
                        duration: const Duration(milliseconds: 1500),
                        verticalOffset: 40,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PricesPage(items[index])));
                          },
                          child: Card(
                            elevation: 5.0,
                            margin: EdgeInsets.all(10.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Row(
                              children: <Widget>[
                                Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "assets/images/priceItems/$image.jpg",
                                          ),
                                          fit: BoxFit.fill,
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.only(left: 35.0),
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                      items[index],
                                      style: TextStyle(fontSize: 20.0),
                                      maxLines: 2,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
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
          child: SpinKitDualRing(
            color: Colors.black,
            size: 50.0,
          ),
        );
      }
    },
  );
}
