import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';

class NotificationCard extends StatefulWidget {
  NotificationCard({Key key}) : super(key: key);
  _NotificationCard createState() => _NotificationCard();
}

class _NotificationCard extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        width: size.width,

        child: FlatButton(
                  onPressed: () {  },
                  child: Wrap(
            spacing: 10,
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://miro.medium.com/max/3150/1*J_BOSSzUz4qBvAjFb-YgZA@2x.jpeg',
                  width: size.width * 0.1,
                  height: size.width * 0.1,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),

              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 3,
                direction: Axis.vertical,
                children: [
                  SizedBox(width: size.width*0.7, child: TextWidget(text: 'Title', color: Colors.black, font: 'Poppins-SemiBold', fontSize: 15)),
                  SizedBox(width: size.width*0.7, child: TextWidget(text: 'Something hot is coming on your way get ready to cool it down', color: Colors.black87, font: 'Poppins-Regular', fontSize: 14)),
                  TextWidget(text: 'Tue 09 2020', color: Colors.black54, font: 'Poppins-Regular', fontSize: 12),
                ],
              )
            ],
          ),
        ));
  }
}
