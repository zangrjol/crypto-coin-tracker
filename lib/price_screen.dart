import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'price_widget.dart';

const MAIN_URL = 'rest.coinapi.io';
const ADD_URL = 'v1/exchangerate/';
const BASE = 'BTC';
const QUOTE = 'USD';
const API_KEY = 'YOUR_API_KEY';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? dropdownValue = currenciesList.first;
  var price;
  var baseCurrency;
  List<Widget>? currencyWidgets = [];

  List<DropdownMenuItem<String>> getDropdownItems() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (String currItem in currenciesList) {
      dropDownItems
          .add(DropdownMenuItem(child: Text(currItem), value: currItem));
    }

    return dropDownItems;
  }

  void getCurrencyWidgets(quoteCurrency) async {
    currencyWidgets = [];
    List<Widget>? widgetsList = [];
    for (String currItem in cryptoList) {
      var currPrice = await getPrice(currItem, quoteCurrency);
      setState(
        () {
          widgetsList.add(
            PriceWidget(
              price: currPrice.toStringAsFixed(0),
              baseCurrency: currItem,
              quoteCurrency: quoteCurrency,
            ),
          );
        },
      );
    }
    currencyWidgets = widgetsList;
  }

  List<Widget> getPicker() {
    List<Widget> dropDownItems = [];

    for (String currItem in currenciesList) {
      dropDownItems.add(Text(currItem));
    }

    return dropDownItems;
  }

  void updatePrice(base, quote) async {
    CoinData coinData =
        await CoinData(url_main: MAIN_URL, url_add: ADD_URL, api_key: API_KEY);
    var data = await coinData.getPrice(base, quote);
    setState(() {
      price = data;
    });
  }

  Future getPrice(base, quote) async {
    CoinData coinData =
        await CoinData(url_main: MAIN_URL, url_add: ADD_URL, api_key: API_KEY);
    var data = await coinData.getPrice(base, quote);
    return data;
  }

  @override
  void initState() {
    updatePrice(BASE, dropdownValue);
    getCurrencyWidgets(dropdownValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: currencyWidgets ?? [],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: CupertinoPicker(
              itemExtent: 32.0,
              backgroundColor: Colors.lightBlue,
              onSelectedItemChanged: (dropdownIndex) {
                setState(
                  () {
                    dropdownValue = currenciesList[dropdownIndex];
                    updatePrice(BASE, dropdownValue);
                    getCurrencyWidgets(dropdownValue);
                  },
                );
              },
              children: Platform.isIOS ? getPicker() : getDropdownItems(),
            ),
          ),
        ],
      ),
    );
  }
}
