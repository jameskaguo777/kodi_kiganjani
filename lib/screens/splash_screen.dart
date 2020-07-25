import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kodi_kiganjani/colors.dart';
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

  @override
  void initState() {
    super.initState();
    accessToken = AccesTokenG();

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
                    Timer(
                        Duration(seconds: 2),
                        () => Navigator.of(context)
                            .pushReplacementNamed('/home'));
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
