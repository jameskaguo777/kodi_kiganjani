import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:kodi_kiganjani/API_conf/api.dart';
import 'package:kodi_kiganjani/helpers/auth/login_helper.dart';
import 'package:kodi_kiganjani/helpers/income_tax_helper.dart';
import 'package:kodi_kiganjani/helpers/new_business_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APICall {
  AccesTokenG accessToken = AccesTokenG();
  Future<LoginHelper> fetchToken(String email, String password) async {
    String jsonData = json.encode({
      'email': email,
      'password': password,
      'device_name': 'LG V30',
    });

    // print(response.body);
    final response = await http.post(
      API + '/sanctum/token',
      body: jsonData,
      headers: _setHeaders(),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      dynamic token =
          LoginHelper.fromJson(json.decode(response.body)).accessToken;
      print(LoginHelper.fromJson(json.decode(response.body)).accessToken);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', token);
      return LoginHelper.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('${response.body} ');
    }
  }

  Future<IncomeTaxHelper> fetchIncomeTax(String token) async {
    final response = await http.get(
     INCOME_TAX_INDEX,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        'Content-Type' : 'application/json',
        
        }
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      debugPrint('APICallddf ' +
          response.body.toString(), wrapWidth: 1024);

      return IncomeTaxHelper.fromJson(json.decode(response.body));
      // return response.body.toString();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('${response.body} Error');
    }
  }

  _setHeaders() => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  Future<NewBusinessHelper> fetchNewBusiness(String token) async {
    final response = await http.get(
     REG_NEW_BUSINESS_INDEX,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        'Content-Type' : 'application/json',
        
        }
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      debugPrint('APICallddf ' +
          response.body.toString(), wrapWidth: 1024);

      return NewBusinessHelper.fromJson(json.decode(response.body));
      // return response.body.toString();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('${response.body} Error');
    }
  }
}
