import 'package:flutter/material.dart';
import 'package:kodi_kiganjani/colors.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  _Register createState() => _Register();
}

class _Register extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String _confirmPassword;

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
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        validator: (value) => value.isEmpty
                            ? 'Please enter your full name'
                            : null,
                      ),
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
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your password';
                          } else {
                            if (value.length < 5){
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
                          hintText: 'Enter your confirm password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        validator: (value) => _confirmPassword != value
                            ? 'password don\'t match'
                            : null,
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

  void _register() {}
}
