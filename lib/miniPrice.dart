import 'package:farmers_clubbing/Prices.dart';
import 'package:flutter/material.dart';

class miniPrice extends StatefulWidget {
  @override
  _miniPriceState createState() => _miniPriceState();
}

class _miniPriceState extends State<miniPrice> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Prices(),
          ),
        );
      },
      child: Container(
        child: Text(
          "Price",
          style: TextStyle(fontSize: 40.0),
        ),
      ),
    );
  }
}
