import 'package:flutter/material.dart';
import 'package:kodi_kiganjani/widgets/card_body.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';

class IncomeTax extends StatefulWidget {
  IncomeTax({Key key}) : super(key: key);

  _IncomeTax createState() => _IncomeTax();
}

class _IncomeTax extends State<IncomeTax> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: TextWidget(
            text: 'Income Tax Return Filling',
            color: Colors.black,
            fontSize: 25,
            font: 'Poppins-Bold'),
        elevation: 0,
      ),
      body: Builder(
          builder: (context) => SizedBox.expand(
                child: Container(
                  color: Colors.yellow,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CardBody(widget: _body()),
                      ]),
                ),
              )),
    ));
  }

  Widget _body() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
    );
  }


}
