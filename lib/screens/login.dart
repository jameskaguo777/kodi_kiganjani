import 'package:flutter/material.dart';
import 'package:kodi_kiganjani/colors.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final _formKey = GlobalKey<FormState>();

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
                        validator: (value) =>
                            value.isEmpty ? 'Please enter your email' : null,
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
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        validator: (value) =>
                            value.isEmpty ? 'Please enter your password' : null,
                      ),
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

  void _login() {
    if (_formKey.currentState.validate()) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void _register() {
    Navigator.pushNamed(context, '/register');
  }
}
