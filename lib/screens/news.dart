import 'package:flutter/material.dart';
import 'package:kodi_kiganjani/API_conf/api.dart';
import 'package:kodi_kiganjani/API_conf/api_call.dart';
import 'package:kodi_kiganjani/colors.dart';
import 'package:kodi_kiganjani/helpers/all_helpers.dart';
import 'package:kodi_kiganjani/widgets/blog_card.dart';
import 'package:kodi_kiganjani/widgets/card_body.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';

class News extends StatefulWidget {
  News({Key key}) : super(key: key);

  _News createState() => _News();
}

class _News extends State<News> {
  APICall _apiCall;
  AccesTokenG _accesTokenG;
  Future<dynamic> _futureToken;

  @override
  void initState() {
    super.initState();
    _accesTokenG = AccesTokenG();
    _apiCall = APICall();
    _futureToken = _accesTokenG.accessTokenStorageF();
  }

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
            builder: (context) => Container(
          color: Colors.yellow,
          width: MediaQuery.of(context).size.width,
          // margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Column(
              
              children: [
                Expanded(child: CardBody(widget: _body())),
              ]),
        )),
    ));
  }

  Widget _body() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 10, 10),
      
      color: Colors.white,
      child: FutureBuilder(
        future: _futureToken,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder<NewsPostHelper>(
                future: _apiCall.fetchNewsPosts(snapshot.data),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(), 
                      padding: const EdgeInsets.all(0),
                      
                      itemCount: snapshot.data.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BlogCard(
                          title: snapshot.data.data[index]['title'],
                          summary: snapshot.data.data[index]['summary'],
                          imageUrl: API_STORAGE +
                              snapshot.data.data[index]['featured_image_url'],
                          dataPost: snapshot.data.data[index],
                        );
                      },
                    );
                  }
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      backgroundColor: darkBlueColor,
                    ),
                  ));
                });
          }
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              backgroundColor: darkBlueColor,
            ),
          ));
        },
      ),
    );
  }
// BlogCard(title: 'Tax Payers aurgent call', summary: 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.', imageUrl: 'https://static01.nyt.com/images/2020/03/24/business/24VIRUS-EVENINGNEWS/24VIRUS-EVENINGNEWS-mobileMasterAt3x.png')
}
