import 'package:flutter/material.dart';
import 'package:kodi_kiganjani/API_conf/api.dart';
import 'package:kodi_kiganjani/API_conf/api_call.dart';
import 'package:kodi_kiganjani/colors.dart';
import 'package:kodi_kiganjani/helpers/all_helpers.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PayScreen extends StatefulWidget {
  PayScreen({Key key}) : super(key: key);

  _PayScreen createState() => _PayScreen();
}

class _PayScreen extends State<PayScreen> {
  APICall _apiCall;
  AccesTokenG _accesTokenG;
  Future<dynamic> _futureToken;
  String amount, phone, subTime, packageId, _email;
  Future<dynamic> email;
  GetValueFromStorage getValueFromStorage;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _accesTokenG = AccesTokenG();
    _apiCall = APICall();
    _futureToken = _accesTokenG.accessTokenStorageF();
    getValueFromStorage = GetValueFromStorage();
    email = getValueFromStorage.getData('email', 'defaultValue');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.yellowAccent,
            centerTitle: true,
            title: TextWidget(
                text: 'Payment Catalog',
                color: Colors.black,
                font: 'Poppins-Bold',
                fontSize: 15),
          ),
          body: Builder(
              builder: (context) => Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.yellowAccent,
                    alignment: Alignment.center,
                    // width: MainAxisSize.max,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            _body(),
                          ]),
                    ),
                  ))),
    );
  }

  Widget _body() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      color: Colors.white,
      child: FutureBuilder(
        future: _futureToken,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder<PackagesHelper>(
                future: _apiCall.fetchPackages(snapshot.data),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      itemCount: snapshot.data.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            amount =
                                snapshot.data.data[index]['amount'].toString();
                            packageId =
                                snapshot.data.data[index]['id'].toString();

                            subTime = snapshot.data.data[index]['duration']
                                .toString();
                            _payAction();
                          },
                          child: Container(
                            color: Colors.red,
                            margin: EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              direction: Axis.vertical,
                              children: [
                                TextWidget(
                                    text: snapshot.data.data[index]['name'],
                                    color: Colors.white,
                                    font: 'Poppins-SemiBold',
                                    fontSize: 15),
                                TextWidget(
                                    text: snapshot.data.data[index]['desc'],
                                    color: Colors.white,
                                    font: 'Poppins-Regular',
                                    fontSize: 17),
                                TextWidget(
                                    text: 'Tsh ' +
                                        snapshot.data.data[index]['amount']
                                            .toString(),
                                    color: Colors.white,
                                    font: 'Poppins-Bold',
                                    fontSize: 20),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      backgroundColor: darkBlueColor,
                    ),
                  ));
                });
          }
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              backgroundColor: darkBlueColor,
            ),
          ));
        },
      ),
    );
  }

  _payAction() {
    showMaterialModalBottomSheet(
      context: context,
      expand: false,
      backgroundColor: darkGreenColor,
      builder: (context, scrollController) => Container(
        alignment: Alignment.topCenter,
        height: MediaQuery.of(context).size.height * .7,
        // width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            direction: Axis.vertical,
            children: [
              SizedBox(
                height: 20,
              ),
              TextWidget(
                  text: 'Phone number',
                  color: Colors.white,
                  font: 'Poppins-Bold',
                  fontSize: 14),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .7,
                child: TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'ex: 255000000000',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter your phone number';
                    } else {
                      phone = value;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .7,
                height: 50,
                color: yellowColor,
                // decoration: RoundedRectangleBorder(),
                child: FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        email
                            .then((value) => _email = value)
                            .whenComplete(() => _payNow(_email));
                      }
                    },
                    // color: darkYellowColor,
                    child: TextWidget(
                      color: darkBlueColor,
                      font: 'Poppins-SemiBold',
                      fontSize: 15,
                      text: 'Pay Now',
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _payNow(String email) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: FutureBuilder<dynamic>(
                future: _futureToken,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return FutureBuilder<dynamic>(
                        future: _apiCall.payService(amount, email, subTime,
                            packageId, phone, snapshot.data.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if(snapshot.data['data']['responseCode'].toString() == '0'){
                              return Text('Procced with the USSD popup and restart App');
                            } else {
                              return Text('Something is not right');
                            }
                            
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error);
                          }
                          return Container(
                            width: MediaQuery.of(context).size.width * .5,
                            height: MediaQuery.of(context).size.height * .5,
                            child: CircularProgressIndicator(),
                          );
                        });
                  }
                  return CircularProgressIndicator();
                }),
          );
        });
  }
}
