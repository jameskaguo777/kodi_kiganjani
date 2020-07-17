import 'package:flutter/material.dart';
import 'package:kodi_kiganjani/widgets/text_widget.dart';

import '../colors.dart';

class TaxCalc extends StatefulWidget{

  TaxCalc({Key key}) : super(key: key);

  
  @override
  _TaxCalc createState() => _TaxCalc();
}

class _TaxCalc extends State<TaxCalc>{

  String _currentSelectedValue;
  final _formKey = GlobalKey<FormState>();

  get state => initState();

  @override
  void initState() {
    
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextWidget(text: 'Tax Calculator', color: Colors.black, fontSize: 25, font: 'Poppins-Bold'),
          elevation: 0,
        ),
        body: Builder(builder: (context) =>
          SizedBox.expand(
            child: Container(
              color: Colors.yellow,
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _bodyCard(),
                ]
              ),
            ),
          )
        ),
      )
    );
  }

  Widget _bodyCard(){
    final size = MediaQuery.of(context).size;
    final _currencies = [
      "Food",
      "Transport",
      "Personal",
      "Shopping",
      "Medical",
      "Rent",
      "Movie",
      "Salary"
    ];

    return Expanded(
      
    child: Card(
        color: Colors.white,
        elevation: 20,
        shadowColor: blackColor,
        shape:  RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.white10, 
            width: 2
          ),
          borderRadius: BorderRadius.only(
            topLeft: const  Radius.circular(40.0),
            topRight: const  Radius.circular(40.0),
          ),
        ),
        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
        
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: Container(
            width: size.width,
            margin: EdgeInsets.fromLTRB(50, 5, 50, 10),
            
            child: 
                Form(
                  key: _formKey,
                  
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [

                      TextWidget(color: Colors.black, text: 'Tax Reference', font: 'Poppins-Medium', fontSize: 12,),
                      SizedBox(height: 10),
                      InputDecorator(

                        decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.black12, fontFamily: 'Poppins-Medium', fontSize: 12),
                            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12.0),
                            hintText: 'Please select Tax Reference',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                        isEmpty: _currentSelectedValue == null,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _currentSelectedValue,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                _currentSelectedValue = newValue;
                                // state.didChange(newValue);
                              });
                            },
                            items: _currencies.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: TextWidget(color: Colors.black, text: value, font: 'Poppins-Medium', fontSize: 12,),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextWidget(color: Colors.black, text: 'Amount', font: 'Poppins-Medium', fontSize: 12,),
                      SizedBox(height: 10),
                    ],
                  ),
                 
                )
              
          )
        )
      )
    );
  }

}