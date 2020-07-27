import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:kodi_kiganjani/API_conf/api.dart';
import 'package:kodi_kiganjani/API_conf/api_call.dart';
import 'package:kodi_kiganjani/helpers/income_tax_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class IncomeTax extends StatefulWidget {
  IncomeTax({Key key}) : super(key: key);

  _IncomeTax createState() => _IncomeTax();
}

class _IncomeTax extends State<IncomeTax> {
  

  String token;

  APICall incomeTaxCall;
  AccesTokenG accessToken;
  @override
  void initState() {
    super.initState();
    incomeTaxCall = APICall();
    accessToken = AccesTokenG();
    // token = accessTokenStorageF();

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // token = prefs.getString('access_token') ?? '0';
  }

  @override
  Widget build(BuildContext context) {
    // token = accessTokenStorageF();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Income Tax Return Filling'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<dynamic>(
              future: accessToken.accessTokenStorageF(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FutureBuilder<IncomeTaxHelper>(
                    future: incomeTaxCall.fetchIncomeTax(snapshot.data),
                    builder: (context, snapshot) {
                      print('im tired of you ');
                      if (snapshot.hasData) {
                        return HtmlWidget(
                          """${snapshot.data.post}""",
                          onTapUrl: (url) => _lunchURL(url),
                        );
                      } else if (snapshot.hasError) {
                        return Wrap(
                          direction: Axis.vertical,
                          children: [ 
                            Icon(Icons.error, size: 30,),
                            Text("Something went wrong ${snapshot.error}")
                        ]);
                      }
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Center(child: CircularProgressIndicator())
                        );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Wrap(
                    direction: Axis.vertical,
                    children: [ 
                      Icon(Icons.error, size: 30,),
                      Text("Something went wrong ${snapshot.error}"),
                  ]);
                }
                return null;
              },
            ),
          ),
        ),
      ),
    );
  }

  _lunchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  
}
