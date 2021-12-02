import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

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
  static Future<String> getCoinData({String crypto, String currency}) async {
    Uri url = Uri.https(
      'rest.coinapi.io',
      '/v1/exchangerate/$crypto/$currency',
      {
        'apikey': dotenv.env['COIN_API_KEY'],
      },
    );

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      double rate = decodedData['rate'];
      return decodedData['rate'].toStringAsFixed(0);
    }

    return '?';
  }

  static Future<Map<String, String>> getCoinDatas(currency) async {
    Map<String, String> _rates = {};
    for (String crypto in cryptoList) {
      String rate = await getCoinData(crypto: crypto, currency: currency);
      _rates[crypto] = rate;
    }
    print(_rates);
    return _rates;
  }
}
