import 'package:bitcoin_ticker/crypto_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String cryptoCurrencyType;
  double rate;
  int rateInInt;
  var cryptoCurrencyDetails = Map();

  DropdownButton<String> androidDropDownButton() {
    List<DropdownMenuItem<String>> dropDownMenuItems = [];
    for (String currency in currenciesList) {
      var dropDownItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownMenuItems.add(dropDownItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownMenuItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          print(selectedCurrency);
          updateUI();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      var pickerItem = Text(currency);
      pickerItems.add(pickerItem);
    }

    return CupertinoPicker(
      children: pickerItems,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      itemExtent: 32.0,
    );
  }

  Widget getPicker() {
    if(Platform.isIOS){
      return iOSPicker();
    } else if(Platform.isAndroid) {
      return androidDropDownButton();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI();
  }

  void updateUI() async {
    cryptoCurrencyDetails = await CoinData().getCoinData(selectedCurrency);
    print(cryptoCurrencyDetails);
    setState(() {
      print(cryptoCurrencyDetails['BTC']);
    });
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CryptoCard(cryptoCurrencyType: 'BTC', rateInInt: cryptoCurrencyDetails['BTC'], selectedCurrency: selectedCurrency),
              CryptoCard(cryptoCurrencyType: 'ETH', rateInInt: cryptoCurrencyDetails['ETH'], selectedCurrency: selectedCurrency),
              CryptoCard(cryptoCurrencyType: 'LTC', rateInInt: cryptoCurrencyDetails['LTC'], selectedCurrency: selectedCurrency),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}

