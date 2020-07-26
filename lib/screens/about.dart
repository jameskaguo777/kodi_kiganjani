import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:kodi_kiganjani/API_conf/api.dart';
import 'package:kodi_kiganjani/API_conf/api_call.dart';
import 'package:kodi_kiganjani/colors.dart';
import 'package:kodi_kiganjani/helpers/all_helpers.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  _AboutPage createState() => _AboutPage();
}

class _AboutPage extends State<AboutPage> {
  
  APICall _apiCall;
  AccesTokenG _accesTokenG;
  Future<dynamic> _futureToken;

  @override
  void initState() {
    super.initState();

    _accesTokenG = AccesTokenG();
    _apiCall = APICall();
    _futureToken = _accesTokenG.accessTokenStorageF();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
                future: _futureToken,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return FutureBuilder<AboutInfoHelper>(
                        future: _apiCall.fetchAboutInfo(snapshot.data),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return HtmlWidget("""${snapshot.data.post}""",
                                onTapUrl: (url) => _lunchURL(url));
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
                  return Text('Loading . . . . .');
                })),
      ),
    ));
  }

  _lunchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
