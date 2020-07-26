import 'package:flutter/material.dart';
import 'package:kodi_kiganjani/colors.dart';
import 'package:kodi_kiganjani/helpers/new_full_args.dart';
import 'package:kodi_kiganjani/screens/news_full.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BlogCard extends StatelessWidget {
  BlogCard(
      {Key key,
      @required this.title,
      @required this.summary,
      @required this.imageUrl,
      @required this.dataPost})
      : super(key: key);

  final String title, summary, imageUrl;

  final dynamic dataPost;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Wrap(
        
        direction: Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.start,
        alignment: WrapAlignment.spaceBetween,
        children: [
          
          Container(
            width: size.width * 0.4,
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                TextWidget(
              text: title,
              color: Colors.black,
              font: 'Poppins-Bold',
              fontSize: 17),
                Container(
                  width: size.width * 0.5,
                  child: TextWidget(
                      text: summary,
                      color: Colors.black87,
                      font: 'Poppins-Regular',
                      fontSize: 14),
                ),
                FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, '/news_full',
                    arguments: NewsFullArgs(dataPost['title'], imageUrl, dataPost['post']));
              },
              padding: EdgeInsets.all(0),
              child: TextWidget(
                  text: 'Learn More',
                  color: darkYellowColor,
                  font: 'Poppins-SemiBold',
                  fontSize: 14)),
              ],
            ),
          ),
          
          ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: CachedNetworkImage(
                    width: size.width * 0.35,
                    height: size.width * 0.2,
                    fit: BoxFit.fill,
                    imageUrl: imageUrl,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
          
        ],
      ),
    );
  }
}
