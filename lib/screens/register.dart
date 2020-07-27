import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:kodi_kiganjani/API_conf/api_call.dart';
import 'package:kodi_kiganjani/colors.dart';
import 'package:kodi_kiganjani/helpers/auth/login_helper.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  _Register createState() => _Register();
}

class _Register extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String _confirmPassword;
  APICall _apiCall;
  String _email, _password, _fullname, _deviceName = 'Failed';

  @override
  void initState() {
    super.initState();
    _apiCall = APICall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Wrap(
            // crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.vertical,
            children: [
              TextWidget(
                  text: 'REGISTER',
                  color: Colors.black,
                  font: 'Poppins-Bold',
                  fontSize: 20),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.center,
                  direction: Axis.vertical,
                  children: [
                    TextWidget(
                        text: 'Names',
                        color: Colors.black,
                        font: 'Poppins-Bold',
                        fontSize: 14),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .7,
                      child: TextFormField(
                          autofocus: true,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: 'Enter your Full name',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your full name';
                            } else {
                              _fullname = value;
                            }
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                        text: 'Email',
                        color: Colors.black,
                        font: 'Poppins-Bold',
                        fontSize: 14),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .7,
                      child: TextFormField(
                          autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Enter your email',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your email';
                            } else {
                              _email = value;
                            }
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                        text: 'Password',
                        color: Colors.black,
                        font: 'Poppins-Bold',
                        fontSize: 14),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .7,
                      child: TextFormField(
                        autofocus: true,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your password';
                          } else {
                            if (value.length < 5) {
                              return 'Your password has to have more than 4 characters';
                            } else {
                              _confirmPassword = value;
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                        text: 'Confirm Password',
                        color: Colors.black,
                        font: 'Poppins-Bold',
                        fontSize: 14),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .7,
                      child: TextFormField(
                          autofocus: true,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Enter password to confirm password',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          validator: (value) {
                            if (_confirmPassword != value) {
                              return 'password don\'t match';
                            } else {
                              _password = value;
                            }
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .7,
                      height: 50,
                      // decoration: RoundedRectangleBorder(),
                      child: FlatButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _register();
                            }
                          },
                          color: darkYellowColor,
                          child: TextWidget(
                            color: Colors.black,
                            font: 'Poppins-SemiBold',
                            fontSize: 15,
                            text: 'REGISTER',
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register() {
    if (_formKey.currentState.validate()) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              // title: Text("Alert Dialog"),
              content: FutureBuilder<LoginHelper>(
                future: _apiCall.fetchRegister(_fullname,_email, _password, _deviceName),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pushReplacementNamed('/home');
                    });

                    Navigator.pop(context);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return TextWidget(
                      text: 'Loading.....',
                      color: Colors.black87,
                      font: 'Poppins-SemiBold',
                      fontSize: 14);
                },
              ),
            );
          });
    }
  }

  void _getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    _deviceName = androidInfo.model;

  }
}
