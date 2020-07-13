import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  int selectedIndex = 0;
  String selectedCurrency = 'USD';

  List<Padding> conversions = [];

  Future<void> addConversions() async {
    for (String crypto in cryptoList) {
      CoinData coinData = CoinData(crypto, selectedCurrency);

      var data = await coinData.getExchangeRate();

      double temp = data['rate'].toDouble();

      String conv = temp.toStringAsFixed(2);

      conversions.add(Padding(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: ConvertCard(
          crypto: crypto,
          global: selectedCurrency,
          conversion: conv,
        ),
      ));
    }
  }

  void updateUI() async {
    await addConversions();
    setState(() {
      conversions = conversions;
    });
  }

  @override
  void initState() {
    updateUI();
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: conversions,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 150.0,
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
                color: Colors.lightBlue,
                child: CupertinoPicker(
                  backgroundColor: Colors.lightBlue,
                  itemExtent: 35.0,
                  onSelectedItemChanged: (selectedIndex1) {
                    selectedIndex = selectedIndex1;
                  },
                  children: currenciesList
                      .map((e) => Text(
                            e,
                            style: TextStyle(color: Colors.white),
                          ))
                      .toList(),
                ),
              ),
              FlatButton(
                child: Text('Convert'),
                onPressed: () {
                  setState(() {
                    selectedCurrency = currenciesList[selectedIndex];
                    conversions = [];
                  });
                  updateUI();
                },
                color: Colors.lightBlue,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ConvertCard extends StatelessWidget {
  ConvertCard({this.crypto, this.global, this.conversion});

  final String crypto;
  final String global;
  final String conversion;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $crypto = $conversion $global',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

//DropdownButton<String>(
//value: selectedCurrency,
//items: currenciesList
//    .map((e) => DropdownMenuItem(
//child: Text(e),
//value: e,
//))
//.toList(),
//onChanged: (value) {
//setState(() {
//selectedCurrency = value;
//});
//},
//)
