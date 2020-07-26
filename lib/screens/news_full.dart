import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:kodi_kiganjani/colors.dart';
import 'package:kodi_kiganjani/constant.dart';

import 'package:kodi_kiganjani/helpers/new_full_args.dart';
import 'package:kodi_kiganjani/widgets/card_body.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

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
                child: Stack(
                  alignment: Alignment.center,
                  
                    children: [
                      
                      Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CardBody(widget: _body(args), marginT: EdgeInsets.all(0), paddingT: EdgeInsets.all(0), colorT: Colors.white),
                            ]),
                    ]
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
          Container(
            color: yellowColor,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(40.0),
                  topRight: const Radius.circular(40.0),

                ),
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
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
                      child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              alignment: Alignment.topCenter,
              child: HtmlWidget(
                
                            """${args.postData}""",
                            onTapUrl: (url) => _lunchURL(url),
                          ),
        
            ),
          ),
        ],
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
