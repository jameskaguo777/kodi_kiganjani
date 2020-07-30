import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kodi_kiganjani/API_conf/api_call.dart';
import 'package:kodi_kiganjani/colors.dart';
import 'package:kodi_kiganjani/helpers/all_helpers.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kodi_kiganjani/API_conf/api.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  AccesTokenG accessToken;
  GetValueFromStorage getValueFromStorage;
  StoreToStorage storeToStorage;
  APICall _apiCall;
  dynamic subscriber;
  @override
  void initState() {
    super.initState();
    accessToken = AccesTokenG();
    getValueFromStorage = GetValueFromStorage();
    storeToStorage = StoreToStorage();
    _apiCall = APICall();
    // Timer(Duration(seconds: 3),
    //     () => Navigator.of(context).pushReplacementNamed('/login'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellowColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(
                text: 'Kodi Kiganjani',
                color: Colors.black,
                font: 'Poppins-Bold',
                fontSize: 30),
                Container(
                  width: MediaQuery.of(context).size.width*.5,
                  height: MediaQuery.of(context).size.width*.5,
                  child: Image.asset('assets/images/kodi.png')),
            FutureBuilder<dynamic>(
              future: accessToken.accessTokenStorageF(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == '0') {
                    Timer(
                        Duration(seconds: 2),
                        () => Navigator.of(context)
                            .pushReplacementNamed('/login'));
                  } else {
                    return FutureBuilder<SubscriberHelper>(
                        future:
                            _apiCall.fetchSubscriber(snapshot.data.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print(snapshot.data.remainingDays.toString());
                            if (snapshot.data.active == 0 ||
                                snapshot.data.remainingDays == 0) {
                              storeToStorage.storeData('paid', '0');
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Navigator.of(context)
                                    .pushReplacementNamed('/payment');
                              });
                            } else {
                              storeToStorage.storeData('paid', '1');
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Navigator.of(context)
                                    .pushReplacementNamed('/home');
                              });
                            }
                          } else if (snapshot.hasError) {
                            print('here' + snapshot.error.toString());
                            return FutureBuilder<dynamic>(
                                future:
                                    getValueFromStorage.getData('paid', '0'),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data == '0') {
                                      Timer(
                                          Duration(seconds: 2),
                                          () => Navigator.of(context)
                                              .pushReplacementNamed(
                                                  '/payment'));
                                    } else if (snapshot.data == '1') {
                                      Timer(
                                          Duration(seconds: 2),
                                          () => Navigator.of(context)
                                              .pushReplacementNamed('/home'));
                                    }
                                  }
                                  return CircularProgressIndicator();
                                });
                          }
                          return CircularProgressIndicator();
                        });

                    // print(snapshot.data);
                  }
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
