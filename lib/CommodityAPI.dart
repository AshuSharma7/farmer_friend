import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Prices.dart' as price;

Future<Map> getPrice() async {
  String url =
      "https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=579b464db66ec23bdd0000017e500705292349b2561aca396eeb67eb&format=json&offset=0&limit=10";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

int limit = 0;
Widget fetchAPI() {
  getPrice();
  return FutureBuilder(
      future: getPrice(),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        Map content = snapshot.data;
        limit = content["total"];
        print(content["total"]);
        return Container();
      });
}
