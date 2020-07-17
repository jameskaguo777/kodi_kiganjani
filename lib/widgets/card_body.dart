import 'package:flutter/material.dart';

import '../colors.dart';

class CardBody extends StatelessWidget {
  CardBody({Key key, @required this.widget}) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Card(
            color: Colors.white,
            elevation: 20,
            shadowColor: blackColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white10, width: 2),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(40.0),
                topRight: const Radius.circular(40.0),
              ),
            ),
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: widget,
            )));
  }
}
