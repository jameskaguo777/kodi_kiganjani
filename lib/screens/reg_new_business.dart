import 'package:flutter/material.dart';
import 'package:kodi_kiganjani/widgets/card_body.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';

class RegNewBusiness extends StatefulWidget {
  RegNewBusiness({Key key}) : super(key: key);

  _RegNewBusiness createState() => _RegNewBusiness();
}

class _RegNewBusiness extends State<RegNewBusiness> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: TextWidget(
            text: 'Registering New Business',
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
