import 'package:flutter/material.dart';

class APIBloc extends ChangeNotifier {
  String _apiUrl;

  set apiUrl(String url) {
    _apiUrl = url;
    notifyListeners();
  }

  get apiUrl => _apiUrl;


  login(String email, String password){
    
  }
}
