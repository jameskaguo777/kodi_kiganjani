import 'package:flutter/material.dart';

import 'package:kodi_kiganjani/screens/home.dart';
import 'package:kodi_kiganjani/screens/income_tax_return.dart';
import 'package:kodi_kiganjani/screens/tax_calc.dart';

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
        '/' : (context)=> Home(title: 'Kodi Kiganjani'),
        '/tax_calc' : (context) => TaxCalc(),
        '/income_tax' : (context) => IncomeTax(),
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

