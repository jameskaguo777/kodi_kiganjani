import 'package:flutter/material.dart';
import 'package:kodi_kiganjani/widgets/svg_card.dart';

class MainButtons extends StatelessWidget {
  MainButtons({Key key, this.asset, this.routeName, this.title}) : super(key: key);
  final String routeName, asset, title;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: () {
        Navigator.pushNamed(context, routeName);
      },
      child: SVGCard(
      
        isNetwork: false,
        asset: asset,
        title: title,
      ),
    );
  }
}
