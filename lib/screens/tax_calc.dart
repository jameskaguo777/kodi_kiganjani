import 'package:flutter/material.dart';
import 'package:kodi_kiganjani/widgets/card_body.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';

import '../colors.dart';

class TaxCalc extends StatefulWidget {
  TaxCalc({Key key}) : super(key: key);

  @override
  _TaxCalc createState() => _TaxCalc();
}

class _TaxCalc extends State<TaxCalc> {
  String _currentSelectedValue;
  String amount;
  final _formKey = GlobalKey<FormState>();

  get state => initState();

  @override
  void initState() {
    super.initState();
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
          builder: (context) => SizedBox.expand(
                child: Container(
                  color: Colors.yellow,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CardBody(widget: _form()),
                      ]),
                ),
              )),
    ));
  }

  Widget _form() {
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
              InputDecorator(
                decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: Colors.black12,
                        fontFamily: 'Poppins-Medium',
                        fontSize: 12),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 12.0),
                    hintText: 'Please select Tax Reference',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                isEmpty: _currentSelectedValue == null,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _currentSelectedValue,
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        _currentSelectedValue = newValue;
                        // state.didChange(newValue);
                      });
                    },
                    items: _currencies.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: TextWidget(
                          color: Colors.black,
                          text: value,
                          font: 'Poppins-Medium',
                          fontSize: 12,
                        ),
                      );
                    }).toList(),
                  ),
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Enter amount',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter amount';
                  } else {
                    amount = value;
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

  void _showDialog() {
    // flutter defined function

    var y = double.parse('5343534');
    double i = y * 0.4;
    String soln = i as String;

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
                text: '$amount',
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
