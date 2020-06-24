import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kodi_kiganjani/colors.dart';
import 'package:kodi_kiganjani/widgets/svg_card.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  

 

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
        
      //   title: Text(widget.title),
      // ),
        body: Builder(builder: (context) =>
          SizedBox.expand(
            child: Container(
              color: yellowColor,
              // width: MainAxisSize.max,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _title(),
                  _bodyCard(context),

                    
                  
                ]
              ),
            ),
          )
        )
        
      )
    );
     
  }

  Widget _title(){
    return Container(
                  margin: EdgeInsets.fromLTRB(35, 20, 0, 0),
                  
                  width: double.infinity,
                  child: TextWidget(
                          text: 'Kodi Kiganjani', 
                          fontSize: 28, 
                          font: 'Poppins-Bold',
                          color: lightBrown,
                          ),
                        );
  }

  Widget _bodyCard(BuildContext context){
    return Expanded(
                  child: Card(
                      color: lightBrown,
                      shape:  RoundedRectangleBorder(
                        side: BorderSide(
                          color: lightBrown, 
                          width: 1
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: const  Radius.circular(40.0),
                          topRight: const  Radius.circular(40.0),
                        ),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      
                      child: Expanded(
                        
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                          child: SingleChildScrollView(
                            child: Column(
                                  
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(

                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        FlatButton(
                                          padding: EdgeInsets.all(0),
                                          onPressed:() {Scaffold.of(context).showSnackBar(SnackBar(content: Text('Test'))); },
                                          child: SVGCard(
                                            isNetwork: false, 
                                            asset: 'assets/images/invoice.svg', 
                                            title: 'Income Tax\nReturn Filling',
                                          ),
                                        ),
                                        
                                          FlatButton(onPressed: null, 
                                            padding: EdgeInsets.all(0),
                                            child: SVGCard(
                                              isNetwork: false, 
                                              asset: 'assets/images/file.svg', 
                                              title: 'Registration/\nNew Business',
                                            ),
                                          ),

                                        ],
                                      ),
                                      Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        FlatButton(onPressed:() => Navigator.pushNamed(context, '/tax_calc'),
                                          padding: EdgeInsets.all(0),
                                          child: SVGCard(
                                          isNetwork: false, 
                                          asset: 'assets/images/calculator.svg', 
                                          title: 'Tax Calculator',
                                          ),),
                                          FlatButton(onPressed: null, 
                                          padding: EdgeInsets.all(0),
                                          child: SVGCard(
                                          isNetwork: false, 
                                          asset: 'assets/images/newspaper.svg', 
                                          title: 'News',
                                          ),),

                                        ],
                                      ),
                                      Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        FlatButton(onPressed: null, 
                                        padding: EdgeInsets.all(0),
                                        child: SVGCard(
                                          isNetwork: false, 
                                          asset: 'assets/images/news.svg', 
                                          title: 'Tax Article',
                                          ),),
                                          FlatButton(onPressed: null,
                                          padding: EdgeInsets.all(0),
                                           child: SVGCard(
                                          isNetwork: false, 
                                          asset: 'assets/images/calendar.svg', 
                                          title: 'Tax Calendar',
                                          ),),

                                        ],
                                      ),

                                      Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        FlatButton(onPressed: null,
                                          padding: EdgeInsets.all(0),
                                         child: SVGCard(
                                          isNetwork: false, 
                                          asset: 'assets/images/share.svg', 
                                          title: 'Share',
                                          ),),
                                          FlatButton(onPressed: null, 
                                          padding: EdgeInsets.all(0),
                                          child: SVGCard(
                                          isNetwork: false, 
                                          asset: 'assets/images/share.svg', 
                                          title: 'Share',
                                          ),),

                                        ],
                                      ),

                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                        width: MediaQuery.of(context).size.width*0.72,
                                        decoration: BoxDecoration(
                                          color: darkYellowColor,
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        ),
                                        child: FlatButton(
                                          color: yellowColor,
                                          onPressed: null, 
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/images/whatsapp.svg',
                                                // color: Colors.white,
                                                width:  MediaQuery.of(context).size.width*0.35/5,
                                                ),
                                                SizedBox(width: 10),
                                              TextWidget(
                                                text: 'Call/Message',
                                                font: 'VT323-Regular',
                                                fontSize: 25,
                                                color: Colors.black,
                                                )
                                            ]
                                          )
                                        ),
                                      )
                                  ]
                                ) 
                          ),
                        )
                      )
                    )
                  );
  }
}
