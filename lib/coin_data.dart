import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  final String url_main;
  final String url_add;
  final String api_key;

  CoinData({
    required this.url_main,
    required this.url_add,
    required this.api_key,
  });

  Future getPrice(base, quote) async {
    var url =
        Uri.https(url_main, url_add + base + '/' + quote, {'apikey': api_key});
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var price = jsonDecode(response.body)['rate'];
      print('price $price for currency $base / $quote');
      print(response.body);

      return price;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
