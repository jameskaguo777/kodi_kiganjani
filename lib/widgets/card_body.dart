import 'package:flutter/material.dart';

import '../colors.dart';

class CardBody extends StatelessWidget {
  CardBody({Key key, @required this.widget, this.marginT, this.paddingT, this.colorT}) : super(key: key);

  final Widget widget;
  final dynamic marginT, paddingT, colorT;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: colorT == null ? Colors.white : colorT,
        elevation: 20,
        shadowColor: blackColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white10, width: 2),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(40.0),
            topRight: const Radius.circular(40.0),
          ),
        ),
        margin: marginT == null ? EdgeInsets.fromLTRB(0, 30, 0, 0) : marginT,
        child: SingleChildScrollView(
          padding: paddingT == null ? EdgeInsets.fromLTRB(0, 50, 0, 0) : paddingT,
          child: widget,
        ));
  }
}
