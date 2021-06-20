import 'dart:convert';
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

const baseURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'C9EC9AC5-94D0-4181-B67E-D86F7810C45B';
var coinData;

class CoinData {

  Future getCoinData(String currencyType) async {

    var cryptoCurrencyDetails = Map();
    for (String cryptoType in cryptoList) {
      http.Response response = await http.get(
          '$baseURL/$cryptoType/$currencyType/?apikey=$apiKey');
      if (response.statusCode == 200) {
        String data = response.body;
        coinData = jsonDecode(data);
        cryptoCurrencyDetails['$cryptoType'] = coinData['rate'].toInt();
      } else {
        print(response.statusCode);
      }
    }
    print(cryptoCurrencyDetails);
    return cryptoCurrencyDetails;
  }
}
