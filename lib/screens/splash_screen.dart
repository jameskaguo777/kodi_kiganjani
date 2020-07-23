import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kodi_kiganjani/colors.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
        () => Navigator.of(context).pushReplacementNamed('/login'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellowColor,
      body: Center(
        child: TextWidget(text: 'Kodi Kiganjani', color: Colors.black, font: 'Poppins-Bold', fontSize: 30),
      ),
    );
  }
}
