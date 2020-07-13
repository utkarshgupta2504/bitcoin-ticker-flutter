import 'package:http/http.dart' as http;
import 'dart:convert';

const String coinApiURL = 'https://rest.coinapi.io/v1/exchangerate';
const String apiKey = '0571F79A-3BBA-4E39-A1EE-B64E12970A0B';

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
  CoinData(this.crypto, this.global);

  final String crypto;
  final String global;

  Future<dynamic> getExchangeRate() async {
    String url = '$coinApiURL/$crypto/$global?apikey=$apiKey';
    http.Response response =
        await http.get('$coinApiURL/$crypto/$global?apikey=$apiKey');
    String data = response.body;
    var exchangeData = jsonDecode(data);
    print(exchangeData);
    return exchangeData;
  }
}
