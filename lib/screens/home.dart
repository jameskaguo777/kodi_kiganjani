import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kodi_kiganjani/API_conf/api.dart';
import 'package:kodi_kiganjani/API_conf/api_call.dart';
import 'package:kodi_kiganjani/colors.dart';
import 'package:kodi_kiganjani/controllers/connectivity_co.dart';
import 'package:kodi_kiganjani/helpers/all_helpers.dart';
import 'package:kodi_kiganjani/widgets/card_body.dart';
import 'package:kodi_kiganjani/widgets/svg_card.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ConnectivityCo connectivityCo;

  APICall _apiCall;
  AccesTokenG _accesTokenG;
  Future<dynamic> _futureToken;

  @override
  void initState() {
    super.initState();
    connectivityCo = ConnectivityCo();
    _accesTokenG = AccesTokenG();
    _apiCall = APICall();
    _futureToken = _accesTokenG.accessTokenStorageF();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Builder(
                builder: (context) => Container(
                      color: yellowColor,
                      width: MediaQuery.of(context).size.width,
                      // width: MainAxisSize.max,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              _title(),
                              _connectivityWidget(),
                              _bodyCard(context),
                            ]),
                      ),
                    ))));
  }

  Widget _title() {
    return Container(
      margin: EdgeInsets.fromLTRB(35, 20, 10, 0),
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        direction: Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        children: [
          TextWidget(
            text: 'Kodi Kiganjani',
            fontSize: 18,
            font: 'Poppins-Bold',
            color: lightBrown,
          ),
          FlatButton.icon(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('access_token', '0');
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushReplacementNamed('/login');
                });
              },
              icon: Icon(Icons.exit_to_app),
              label: Text('Logout')),
        ],
      ),
    );
  }

  Widget _connectivityWidget() {
    return FutureBuilder<dynamic>(
        future: connectivityCo.checkConnectivityCo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
            } else {
              return Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.red,
                child: Center(
                  child: TextWidget(
                      text: 'Your are not connected to the Internet',
                      color: Colors.white,
                      font: 'Poppins-Bold',
                      fontSize: 14),
                ),
              );
            }

            return Center();
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString() + ' error');
          }
          return Text('');
        });
  }

  Widget _bodyCard(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: CardBody(
          marginT: EdgeInsets.fromLTRB(0, 25, 0, 0),
          paddingT: EdgeInsets.all(0),
          widget: _menuItems(),
          colorT: lightBrown,
        ));
  }

  Widget _menuItems() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.horizontal,
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
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.horizontal,
            children: [
              FlatButton(
                onPressed: () => Navigator.pushNamed(context, '/tax_calc'),
                padding: EdgeInsets.all(0),
                child: SVGCard(
                  isNetwork: false,
                  asset: 'assets/images/calculator.svg',
                  title: 'Tax Calculator',
                ),
              ),
              FlatButton(
                onPressed: () => Navigator.pushNamed(context, '/news'),
                padding: EdgeInsets.all(0),
                child: SVGCard(
                  isNetwork: false,
                  asset: 'assets/images/newspaper.svg',
                  title: 'News',
                ),
              ),
            ],
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.horizontal,
            children: [
              FlatButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/notification_center'),
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
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.horizontal,
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
                onPressed: () => Navigator.pushNamed(context, '/about'),
                padding: EdgeInsets.all(0),
                child: SVGCard(
                  isNetwork: false,
                  asset: 'assets/images/whatsapp.svg',
                  title: 'About Us',
                ),
              ),
            ],
          ),
          _buttonBottom(),
        ]);
  }

  Widget _buttonBottom() {
    return Container(
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
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(
              'assets/images/whatsapp.svg',
              // color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.35 / 5,
            ),
            SizedBox(width: 10),
            TextWidget(
              text: 'Call/Message',
              font: 'VT323-Regular',
              fontSize: 25,
              color: Colors.black,
            )
          ])),
    );
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
            content: FutureBuilder(
              future: _futureToken,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FutureBuilder<ContactHelper>(
                      future: _apiCall.fetchContactsT(snapshot.data),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          String whatsapp, call;

                          for (var i = 0; i < snapshot.data.data.length; i++) {
                            if (snapshot.data.data[i]['name']
                                .toString()
                                .contains('Whatsapp')) {
                              whatsapp =
                                  snapshot.data.data[i]['phone'].toString();
                            } else if (snapshot.data.data[i]['name']
                                .toString()
                                .contains('Call')) {
                              call = snapshot.data.data[i]['phone'].toString();
                            }
                          }

                          return Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            direction: Axis.vertical,
                            children: [
                              FlatButton(
                                  onPressed: () {
                                    _lunchURL("tel:" + call);
                                  },
                                  child: Text('Call')),
                              SizedBox(
                                height: 10,
                              ),
                              FlatButton(
                                  onPressed: () {
                                    _lunchURL("https://wa.me/" + whatsapp);
                                  },
                                  child: Text('Whatsapp Message')),
                            ],
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
          );
        });
  }
}
