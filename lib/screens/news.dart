import 'package:flutter/material.dart';
import 'package:kodi_kiganjani/widgets/blog_card.dart';
import 'package:kodi_kiganjani/widgets/card_body.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';

class News extends StatefulWidget {
  News({Key key}) : super(key: key);

  _News createState() => _News();
}

class _News extends State<News> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: TextWidget(
            text: 'News',
            color: Colors.black,
            fontSize: 25,
            font: 'Poppins-Bold'),
        elevation: 0,
      ),
      body: Builder(
          builder: (context) => SizedBox.expand(
                child: Container(
                  color: Colors.yellow,
                  // margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
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
      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: SingleChildScrollView(scrollDirection: Axis.vertical ,child: BlogCard(title: 'Tax Payers aurgent call', summary: 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.', imageUrl: 'https://static01.nyt.com/images/2020/03/24/business/24VIRUS-EVENINGNEWS/24VIRUS-EVENINGNEWS-mobileMasterAt3x.png')),
    );
  }

}
