import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:kodi_kiganjani/API_conf/api.dart';
import 'package:kodi_kiganjani/API_conf/api_call.dart';
import 'package:kodi_kiganjani/helpers/all_helpers.dart';
import 'package:kodi_kiganjani/widgets/card_body.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';

import '../colors.dart';

class TaxCalc extends StatefulWidget {
  TaxCalc({Key key}) : super(key: key);

  @override
  _TaxCalc createState() => _TaxCalc();
}

class _TaxCalc extends State<TaxCalc> {
  var _currentSelectedValue;
  String amount;
  final _formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  APICall _apiCall;
  AccesTokenG _accesTokenG;
  Future<dynamic> _futureToken;
  List<Map<String, dynamic>> _referances;
  get state => initState();

  @override
  void initState() {
    super.initState();
    _accesTokenG = AccesTokenG();
    _apiCall = APICall();
    _futureToken = _accesTokenG.accessTokenStorageF();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: TextWidget(
            text: 'Tax Calculator',
            color: Colors.black,
            fontSize: 25,
            font: 'Poppins-Bold'),
        elevation: 0,
      ),
      body: Builder(
          builder: (context) => Container(
            color: Colors.yellow,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  FutureBuilder(
                      future: _futureToken,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return FutureBuilder<TaxCalculatorHelper>(
                              future:
                                  _apiCall.fetchTaxCalc(snapshot.data),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  // print(snapshot.data.taxCal[0]['name']);
                                  _referances = new List(
                                      snapshot.data.taxCal.length);

                                  for (var i = 0;
                                      i < snapshot.data.taxCal.length;
                                      i++) {
                                    _referances[i] =
                                        snapshot.data.taxCal[i];
                                  }
                                  return Expanded(
                                                                      child: CardBody(
                                        widget:
                                            _form(snapshot.data.taxCal)),
                                  );
                                } else if (snapshot.hasError) {
                                  return Wrap(
                                      direction: Axis.vertical,
                                      children: [
                                        Icon(
                                          Icons.error,
                                          size: 30,
                                        ),
                                        Text(
                                            "Something went wrong ${snapshot.error}")
                                      ]);
                                }
                                return Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    backgroundColor: darkBlueColor,
                                  ),
                                ));
                              });
                        } else if (snapshot.hasError) {
                          return Wrap(
                              direction: Axis.vertical,
                              children: [
                                Icon(
                                  Icons.error,
                                  size: 30,
                                ),
                                Text(
                                    "Something went wrong ${snapshot.error}")
                              ]);
                        }
                        return Text(snapshot.error);
                      }),
                ]),
          )),
    ));
  }

  Widget _form(List<dynamic> references) {
    final _currencies = [
      "Food",
      "Transport",
      "Personal",
      "Shopping",
      "Medical",
      "Rent",
      "Movie",
      "Salary"
    ];
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.fromLTRB(50, 5, 50, 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextWidget(
                color: Colors.black,
                text: 'Tax Reference',
                font: 'Poppins-Medium',
                fontSize: 12,
              ),
              SizedBox(height: 10),
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<dynamic>(
                  decoration: InputDecoration(
                      hintText: 'Choose Tax Reference',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  validator: (value) => value == null
                      ? 'Please fill in your Tax Reference'
                      : null,
                  value: _currentSelectedValue,
                  isDense: true,
                  onChanged: (dynamic newValue) {
                    setState(() {
                      _currentSelectedValue = newValue;
                      print(_findRefValue().toString() + ' tried');
                      // state.didChange(newValue);
                    });
                  },
                  items: references.map((dynamic value) {
                    return DropdownMenuItem<dynamic>(
                      value: value['name'],
                      child: TextWidget(
                        color: Colors.black,
                        text: value['name'],
                        font: 'Poppins-Medium',
                        fontSize: 12,
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              TextWidget(
                color: Colors.black,
                text: 'Amount',
                font: 'Poppins-Medium',
                fontSize: 12,
              ),
              SizedBox(height: 10),
              TextFormField(
                autofocus: true,
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Enter amount',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter amount';
                  } else {
                    // amount = value;
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 70,
                height: 50,
                // decoration: RoundedRectangleBorder(),
                child: FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _showDialog();
                      }
                    },
                    color: darkYellowColor,
                    child: TextWidget(
                      color: Colors.black,
                      font: 'Poppins-SemiBold',
                      fontSize: 15,
                      text: 'Calculate',
                    )),
              )
            ],
          ),
        ));
  }

  _findRefValue() {
    for (var i = 0; i < _referances.length; i++) {
      if (_currentSelectedValue == _referances[i]['name']) {
        return _referances[i]['value'];
      }
    }
  }

  void _showDialog() {
    // flutter defined function

    var y = double.parse(amountController.text.trim());

    var ref = _findRefValue();

    // var ref = double.parse(_currentSelectedValue);

    var x = y * ref;
    String soln = x.toString();

    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
      amount: x,
      settings: MoneyFormatterSettings(
        symbol: 'Tsh',
        thousandSeparator: ',',
        decimalSeparator: '.',
        symbolAndNumberSeparator: ' ',
        fractionDigits: 3,
        
    )
      );

    String soln1 = fmf.output.symbolOnLeft;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: TextWidget(
              text: 'Your Tax',
              color: Colors.black,
              font: 'Poppins-Bold',
              fontSize: 14),
          content: Wrap(alignment: WrapAlignment.center, children: [
            TextWidget(
                text: '$soln1',
                color: darkGreenColor,
                font: 'Poppins-Bold',
                fontSize: 49),
          ]),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new TextWidget(
                  text: 'Close',
                  color: darkPuppleColor,
                  font: 'Poppins-Medium',
                  fontSize: 14),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
