import 'package:flutter/material.dart';
import 'package:kodi_kiganjani/API_conf/api.dart';
import 'package:kodi_kiganjani/API_conf/api_call.dart';
import 'package:kodi_kiganjani/colors.dart';
import 'package:kodi_kiganjani/helpers/all_helpers.dart';
import 'package:kodi_kiganjani/widgets/card_body.dart';
import 'package:kodi_kiganjani/widgets/notification_card.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';

class NotificationCenter extends StatefulWidget {
  NotificationCenter({Key key}) : super(key: key);

  _NotificationCenter createState() => _NotificationCenter();
}

class _NotificationCenter extends State<NotificationCenter> {
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
        title: TextWidget(
            text: 'Notification Center',
            color: Colors.black,
            fontSize: 25,
            font: 'Poppins-Bold'),
        elevation: 0,
      ),
      body: Builder(
          builder: (context) => SizedBox.expand(
                child: Container(
                  color: Colors.yellow,
                  // margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CardBody(widget: _body()),
                      ]),
                ),
              )),
    ));
  }

  Widget _body() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 20, 10),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder(
          future: _futureToken,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return FutureBuilder<NotificationCenterHelper>(
                  future: _apiCall.fetchNotificationT(snapshot.data),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return NotificationCard(
                            imageUrl: API_STORAGE + snapshot.data.data[index]['featured_image_url'],
                            summary: snapshot.data.data[index]['summary'],
                            time: snapshot.data.data[index]['published'],
                            title: snapshot.data.data[index]['title'],
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
      ),
    );
  }

  // NotificationCard(imageUrl: null, summary: null, time: null, title: null,),
}
