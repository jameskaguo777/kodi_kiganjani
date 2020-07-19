import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:kodi_kiganjani/constant.dart';

import 'package:kodi_kiganjani/helpers/new_full_args.dart';
import 'package:kodi_kiganjani/widgets/card_body.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';

class NewsFull extends StatefulWidget {
  NewsFull({
    Key key,
  }) : super(key: key);
  // final String title;
  _NewsFull createState() => _NewsFull();
}

class _NewsFull extends State<NewsFull> {
  @override
  Widget build(BuildContext context) {
    final NewsFullArgs args = ModalRoute.of(context).settings.arguments;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(args.title),
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
                        CardBody(widget: _body(args)),
                      ]),
                ),
              )),
    ));
  }

  Widget _body(NewsFullArgs args) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Wrap(
        direction: Axis.vertical,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: CachedNetworkImage(
              width: size.width,
              height: size.width * 0.6,
              fit: BoxFit.fill,
              imageUrl: args.imageUrl,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            alignment: Alignment.topCenter,
            // child: HtmlWidget(
            //   WEBTEXT,
            //   onTapUrl: (url) => showDialog(
            //     context: context,
            //     builder: (_) => AlertDialog(
            //       title: Text('onTapUrl'),
            //       content: Text(url),
            //     ),
            //   ),
            // ),
        
          ),
        ],
      ),
    );
  }
}
