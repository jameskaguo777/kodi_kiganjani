import 'package:flutter/material.dart';
import 'package:kodi_kiganjani/screens/about.dart';

import 'package:kodi_kiganjani/screens/home.dart';
import 'package:kodi_kiganjani/screens/income_tax_return.dart';
import 'package:kodi_kiganjani/screens/login.dart';
import 'package:kodi_kiganjani/screens/news.dart';
import 'package:kodi_kiganjani/screens/news_full.dart';
import 'package:kodi_kiganjani/screens/notification_center.dart';
import 'package:kodi_kiganjani/screens/reg_new_business.dart';
import 'package:kodi_kiganjani/screens/register.dart';
import 'package:kodi_kiganjani/screens/splash_screen.dart';
import 'package:kodi_kiganjani/screens/tax_calc.dart';
import 'package:kodi_kiganjani/screens/tax_calender.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes:{ 
        '/' : (context)=> SplashScreen(),
        '/login' : (context) => Login(),
        '/register' : (context) => Register(),
        '/home' : (context)=> Home(title: 'Kodi Kiganjani'),
        '/tax_calc' : (context) => TaxCalc(),
        '/income_tax' : (context) => IncomeTax(),
        '/reg_new_business' : (context) => RegNewBusiness(),
        '/news' : (context) => News(),
        '/news_full' : (context) => NewsFull(),
        '/tax_calender' : (context) => TaxCalender(title: 'Tax Calender',),
        '/notification_center' : (context) => NotificationCenter(),
        '/about' : (context) => AboutPage(),
        },
      title: 'Kodi Kiganjani',
      theme: ThemeData(
        
        primarySwatch: Colors.yellow,
       
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: Home(title: 'Kodi Kiganjani'),
    );
  }
}

