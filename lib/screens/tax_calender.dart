//  Copyright (c) 2019 Aleksander Woźniak
//  Licensed under Apache License v2.0

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kodi_kiganjani/API_conf/api.dart';
import 'package:kodi_kiganjani/API_conf/api_call.dart';
import 'package:kodi_kiganjani/colors.dart';
import 'package:kodi_kiganjani/helpers/all_helpers.dart';
import 'package:table_calendar/table_calendar.dart';

// Example holidays
final Map<DateTime, List> _holidays = {
  // DateTime(2019, 1, 1): ['New Year\'s Day'],
  // DateTime(2019, 1, 6): ['Epiphany'],
  // DateTime(2019, 2, 14): ['Valentine\'s Day'],
  // DateTime(2019, 4, 21): ['Easter Sunday'],
  // DateTime(2019, 4, 22): ['Easter Monday'],
};

class TaxCalender extends StatefulWidget {
  TaxCalender({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TaxCalender createState() => _TaxCalender();
}

class _TaxCalender extends State<TaxCalender> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  APICall _apiCall;
  AccesTokenG _accesTokenG;
  Future<dynamic> _futureToken;

  @override
  void initState() {
    super.initState();

    _accesTokenG = AccesTokenG();
    _apiCall = APICall();
    _futureToken = _accesTokenG.accessTokenStorageF();
    final _selectedDay = DateTime.now();

    _events = {
      // _selectedDay.subtract(Duration(days: 30)): [
      //   'PayTax',
      //   'Event B0',
      //   'Event C0'
      // ],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      // vsync: this,
      duration: const Duration(milliseconds: 400), vsync: this,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: _futureToken,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder<TaxCalenderHelper>(
                future: _apiCall.fetchTaxCalenderT(snapshot.data),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var dataE = [];
                    Map<DateTime, List> other = {};
                    
                    for (var i = 0; i < snapshot.data.data.length; i++) {
                      // for (var x = 0; x < snapshot.data.data.length; x++) {
                      //   if (snapshot.data.data[i]['tax_date'].toString().contains(snapshot.data.data[x]['tax_date'].toString())
                      //       ) {
                      //         if (!dataE.contains(snapshot.data.data[x]['summary'])) {
                                
                      //         }
                          
                      //     // other.putIfAbsent(
                      //     //   DateTime.parse(snapshot.data.data[i]['tax_date']), () => dataE);
                      //   }
                       
                      // }
                              if (!dataE.contains(snapshot.data.data[i]['summary'])) {
                                dataE.add(snapshot.data.data[i]['summary']);
                              }
                      
                      other.putIfAbsent(
                            DateTime.parse(snapshot.data.data[i]['tax_date']), () => [snapshot.data.data[i]['summary'].toString()]);
                      
                        
                        
                      
                    }
                     _events.addAll(other);

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        // Switch out 2 lines below to play with TableCalendar's settings
                        //-----------------------
                        // _buildTableCalendar(),
                        _buildTableCalendarWithBuilders(),

                        const SizedBox(height: 8.0),
                        Expanded(child: _buildEventList()),
                      ],
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

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'en_US',
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString()),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }
}

// Simple TableCalendar configuration (using Styles)
// Widget _buildTableCalendar() {
//   return TableCalendar(
//     calendarController: _calendarController,
//     events: _events,
//     holidays: _holidays,
//     startingDayOfWeek: StartingDayOfWeek.monday,
//     calendarStyle: CalendarStyle(
//       selectedColor: Colors.deepOrange[400],
//       todayColor: Colors.deepOrange[200],
//       markersColor: Colors.brown[700],
//       outsideDaysVisible: false,
//     ),
//     headerStyle: HeaderStyle(
//       formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
//       formatButtonDecoration: BoxDecoration(
//         color: Colors.deepOrange[400],
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//     ),
//     onDaySelected: _onDaySelected,
//     onVisibleDaysChanged: _onVisibleDaysChanged,
//     onCalendarCreated: _onCalendarCreated,
//   );
// }
