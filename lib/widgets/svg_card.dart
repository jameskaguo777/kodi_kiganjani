
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kodi_kiganjani/colors.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';

class SVGCard extends StatelessWidget{

  SVGCard({@required this.isNetwork, this.url,this.asset, this.title});

  final bool isNetwork;
  final String url;
  final String asset;
  final String title;
  

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.width*0.35,
      width: screenSize.width*0.35,
      margin: const EdgeInsets.fromLTRB(0, 15, 15, 0),
      // padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
      child: Card(
        elevation: 0,
        color: whiteBrown,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenSize.width*0.35/6),
        ),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isNetwork ?
            SvgPicture.network(
              url,
              color: Colors.white,
              placeholderBuilder: (BuildContext context) => Container(
              padding: const EdgeInsets.all(10.0),
              child: const CircularProgressIndicator()),
       
            )  :
            SvgPicture.asset(
              asset == null ? 'assets/images/file.svg' : asset,
              color: Colors.white,
              width: screenSize.width*0.35/3,
              ),
            SizedBox(height: 5.0),
            TextWidget(
              text: title == null ? 'Untitled' : title,
              font: 'Poppins-Medium',
              fontSize: 12,
              color: Colors.white,
            )
          ],
        ),
      ),
    );

  }


}