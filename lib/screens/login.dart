import 'package:flutter/material.dart';
import 'package:kodi_kiganjani/API_conf/api_call.dart';
import 'package:kodi_kiganjani/colors.dart';
import 'package:kodi_kiganjani/helpers/auth/login_helper.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  APICall _apiCall;
  String _email, _password;

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
                  text: 'LOGIN',
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
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter email please';
                          } else {
                            _email = value;
                          }
                        },
                      ),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your password';
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
                            _login();
                          },
                          color: darkYellowColor,
                          child: TextWidget(
                            color: Colors.black,
                            font: 'Poppins-SemiBold',
                            fontSize: 15,
                            text: 'LOGIN',
                          )),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * .7,
                      height: 50,
                      // decoration: RoundedRectangleBorder(),
                      child: FlatButton(
                          onPressed: () {
                            _register();
                          },
                          // color: darkYellowColor,
                          child: TextWidget(
                            color: darkBlueColor,
                            font: 'Poppins-SemiBold',
                            fontSize: 15,
                            text: 'Register if not a member',
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

  @override
  void dispose() {
    
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState.validate()) {
      
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              // title: Text("Alert Dialog"),
              content: FutureBuilder<LoginHelper>(
                future: _apiCall.fetchToken(_email, _password),
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

  void _navigateHome() {
    
  }

  void _register() {
    Navigator.pushNamed(context, '/register');
  }
}
