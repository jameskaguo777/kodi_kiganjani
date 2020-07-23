import 'package:flutter/material.dart';
import 'package:kodi_kiganjani/widgets/card_body.dart';
import 'package:kodi_kiganjani/widgets/notification_card.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';

class NotificationCenter extends StatefulWidget {
  NotificationCenter({Key key}) : super(key: key);

  _NotificationCenter createState() => _NotificationCenter();
}

class _NotificationCenter extends State<NotificationCenter> {
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
      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: NotificationCard(),
    );
  }
}
