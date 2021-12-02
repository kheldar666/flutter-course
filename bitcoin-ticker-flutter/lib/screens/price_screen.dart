import 'package:bitcoin_ticker/services/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:flutter/services.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  Map<String, String> rates = {};

  @override
  void initState() {
    super.initState();
    getRates(currency: selectedCurrency);
  }

  void updateCurrency(String currency) {
    setState(() {
      selectedCurrency = currency;
      getRates();
    });
  }

  void getRates({String currency}) async {
    if (currency == null) {
      currency = selectedCurrency;
    }

    Map<String, String> _rates = await CoinData.getCoinDatas(currency);
    setState(() {
      rates = _rates;
    });
  }

  List<DropdownMenuItem<String>> getDropdownItems() {
    List<DropdownMenuItem<String>> dropdownItemList = [];
    for (var currency in currenciesList) {
      dropdownItemList.add(
        DropdownMenuItem(
          value: currency,
          child: Text(currency),
        ),
      );
    }
    return dropdownItemList;
  }

  List<Widget> getPickerItems() {
    List<Widget> pickerItems = [];
    for (var currency in currenciesList) {
      pickerItems.add(
        Text(currency),
      );
    }
    return pickerItems;
  }

  Widget getDropdownButton() {
    if (Platform.isAndroid) {
      return DropdownButton<String>(
        value: selectedCurrency,
        items: getDropdownItems(),
        onChanged: (currency) {
          updateCurrency(currency);
        },
      );
    } else if (Platform.isIOS) {
      return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        children: getPickerItems(),
        itemExtent: 32,
        onSelectedItemChanged: (selectedIndex) {
          updateCurrency(currenciesList[selectedIndex]);
        },
      );
    } else {
      throw PlatformException(code: '500', message: 'Platform not Supported');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: displayCards(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getDropdownButton(),
          ),
        ],
      ),
    );
  }

  List<Widget> displayCards() {
    List<Widget> cards = [];
    for (String crypto in cryptoList) {
      cards.add(
        Padding(
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
                '1 $crypto = ${rates[crypto]} $selectedCurrency',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return cards;
  }
}
