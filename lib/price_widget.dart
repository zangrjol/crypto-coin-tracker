import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    Key? key,
    required this.price,
    required this.baseCurrency,
    required this.quoteCurrency,
  }) : super(key: key);

  final price;
  final baseCurrency;
  final quoteCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $baseCurrency = $price $quoteCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
