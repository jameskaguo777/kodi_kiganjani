import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kodi_kiganjani/colors.dart';
import 'package:kodi_kiganjani/widgets/svg_card.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            // appBar: AppBar(
            //   elevation: 0,

            //   title: Text(widget.title),
            // ),
            body: Builder(
                builder: (context) => SizedBox.expand(
                      child: Container(
                        color: yellowColor,
                        // width: MainAxisSize.max,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              _title(),
                              _bodyCard(context),
                            ]),
                      ),
                    ))));
  }

  Widget _title() {
    return Container(
      margin: EdgeInsets.fromLTRB(35, 20, 0, 0),
      width: double.infinity,
      child: TextWidget(
        text: 'Kodi Kiganjani',
        fontSize: 28,
        font: 'Poppins-Bold',
        color: lightBrown,
      ),
    );
  }

  Widget _bodyCard(BuildContext context) {
    return Expanded(
        child: Card(
            color: lightBrown,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: lightBrown, width: 1),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(40.0),
                topRight: const Radius.circular(40.0),
              ),
            ),
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Expanded(
                child: Container(
              margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            Navigator.pushNamed(context, '/income_tax');
                          },
                          child: SVGCard(
                            isNetwork: false,
                            asset: 'assets/images/invoice.svg',
                            title: 'Income Tax\nReturn Filling',
                          ),
                        ),
                        FlatButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/reg_new_business'),
                          padding: EdgeInsets.all(0),
                          child: SVGCard(
                            isNetwork: false,
                            asset: 'assets/images/file.svg',
                            title: 'Registration/\nNew Business',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/tax_calc'),
                          padding: EdgeInsets.all(0),
                          child: SVGCard(
                            isNetwork: false,
                            asset: 'assets/images/calculator.svg',
                            title: 'Tax Calculator',
                          ),
                        ),
                        FlatButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/news'),
                          padding: EdgeInsets.all(0),
                          child: SVGCard(
                            isNetwork: false,
                            asset: 'assets/images/newspaper.svg',
                            title: 'News',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: () => Navigator.pushNamed(
                              context, '/notification_center'),
                          padding: EdgeInsets.all(0),
                          child: SVGCard(
                            isNetwork: false,
                            asset: 'assets/images/bell.svg',
                            title: 'Notification',
                          ),
                        ),
                        FlatButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/tax_calender'),
                          padding: EdgeInsets.all(0),
                          child: SVGCard(
                            isNetwork: false,
                            asset: 'assets/images/calendar.svg',
                            title: 'Tax Calendar',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: () {
                            final RenderBox box = context.findRenderObject();
                            Share.share('Test',
                                subject: 'subject',
                                sharePositionOrigin:
                                    box.localToGlobal(Offset.zero) & box.size);
                          },
                          padding: EdgeInsets.all(0),
                          child: SVGCard(
                            isNetwork: false,
                            asset: 'assets/images/share.svg',
                            title: 'Share',
                          ),
                        ),
                        FlatButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/about'),
                          padding: EdgeInsets.all(0),
                          child: SVGCard(
                            isNetwork: false,
                            asset: 'assets/images/whatsapp.svg',
                            title: 'About Us',
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      width: MediaQuery.of(context).size.width * 0.72,
                      decoration: BoxDecoration(
                        color: darkYellowColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: FlatButton(
                          color: darkYellowColor,
                          onPressed: () => _callWhatsapp(),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/whatsapp.svg',
                                  // color: Colors.white,
                                  width: MediaQuery.of(context).size.width *
                                      0.35 /
                                      5,
                                ),
                                SizedBox(width: 10),
                                TextWidget(
                                  text: 'Call/Message',
                                  font: 'VT323-Regular',
                                  fontSize: 25,
                                  color: Colors.black,
                                )
                              ])),
                    )
                  ])),
            ))));
  }

  _lunchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _callWhatsapp() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              title: Text('Call or Message'),
              content: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                children: [
                  FlatButton(
                      onPressed: () {
                        _lunchURL('http://tel:+255757028753');
                      },
                      child: Text('Call')),
                  SizedBox(height: 10,),
                  FlatButton(
                      onPressed: () {
                        _lunchURL('http://tel:+255757028753');
                      },
                      child: Text('Whatsapp Message')),
                ],
              )
            );
        });
  }
}
