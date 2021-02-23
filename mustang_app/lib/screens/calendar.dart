import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:googleapis/calendar/v3.dart' hide Colors;
import 'package:googleapis_auth/auth_io.dart';

import './header.dart';
import './bottomnavbar.dart';

class Calendar extends StatefulWidget {
  static const String route = '/Calendar';
  static Map<DateTime, List> events;

  //get Service Account Credentials
final accountCredentials = new ServiceAccountCredentials.fromJson({
  "private_key_id": "147555dcfa1a0d59b16ef7e412187333b287e47c",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDMOHB/yabDy9ZA\ncICZ6m3ORoNEmmM3bMJ0eIdlwN2C9Caih6GRGy+F84lU7oNE4Cf2XlOZ7WirGNNX\nAe3COheXwSrzfvczEa+8REeF35l2DkNXrw2lN468AeN7MwXxNu+msEC7Hvecjojg\nwaoJ+hIYFRmoMgfQt+9e5olv4kA4QJbeuq8P9Ns/qynyYqZXMbrvDgbhBX9w68eq\ne0zm46wrCJHRptSg15cwA8EsZSxQ6jvfU61wXREXPJQA1jkWacEt353eJgCK7329\nn0FUFa2xW0l6fh7fqb+8PMZuHeuQz7FkWviqQ4db9gpabV83IVFjqgwahHKRc7Mg\nQivitkpLAgMBAAECggEAJCADvockSdRf9Qwxo4h1nhyZEeShkmdZypKbmONSC902\njF+js/B0KqTW8UAz1lY0m386GKuHbWS51dVQgqAWFlEkUOhvwAfr50jIwiS4l8qU\nHQmpR0WZqSZIYD25Wl8Wa40YFkG3GWmZSvDXLGahFsN8w2T+PuyamlX7j+Ac7hYl\ni9Zs3Dg/dgxbw28LXW6dLc6eVxY+L61fns9b6DC7Hgmx7t2HPJlCE3b1h+LdVEQk\nTmKLxW8fQYqHaXOFUzb96+qAFww2L6zqVARFqEjh+FxFV0SmXeG/bWsqcMehPO27\nR1QvnFitdOzuGZSKeLH+NtGYtH5yXZxmsBjnlqjCaQKBgQD86BpXCfd+FXPoyIqM\n1GdMuuqxRhb294+ma7MXvbTROkCTp4NHl+e1/fqszLSun7tytClibi3O3UUvITUf\n+C74mUtMhjBzRbRc/1qkqg2f9lNB2529g6JW41TPKyxgJ7GhxPWkT7ySmfvFtDhi\nTBbNtutV3Thv373GvbqrZclMXQKBgQDOt+QkpU+gpFAURlWkVO0hXr0+pWhxgp9A\n4pbFi3qzfA7xoa6lH7cMCo0ysjlrI94mlk/Or4hvD5hf/mnaaQPtl6O1fyuxRF4V\nhuT7E2VvG64jrOB6CSbNwnq//aArwod/1/A01Jd6XUYZIsf3b77ReY/5Y8LLVSWW\nQMCdGBzGxwKBgQCrptkh1DjvkZ3vFBW9ifhmwsLB+UFi9BnCqXyPk4mjLHdiACMB\nN5/kDPLTz8iecPmn25HvJbrfmZz4ZQCKp0cyIdFSqg0+X8QQDpy2AFlpBaXyoB2K\n4EoR0Q/h4Hqo9KgClQzoLdpeYjbZM/3E8cHUc998kr5YaDKFLocBB/+9XQKBgEAA\nmYdrE2tWVGDiofN+Q+kYDxnNVrgGTE5nmWzSUYwuteXEPHFtj1wQDEWM/tAYS9jA\nozcIDALu3iuidp2j9A5k68/u7tU0qLibilveVoJ/HHx5Mws1uCjutNiqqyPBV/iS\nIBILXFcLd/+iUC1hEMCElboOVCpmU3vg0oIRDB/TAoGABtBkV6SbwrV5EvQ/MyhP\nurxT3zXIjut1OyEZxD5logzwZnhiaZDwZO89YpftQ1O5M8Q7Uurg/bt8lzF7YNdm\nfTV5Kn40zhWsUx/s07Ffnp21GE4VGOVzKDv1L5sG4VeH8hnizmYAv6JLkft/zTeg\nrOJJxlDPiz8wnBi5guHts8c=\n-----END PRIVATE KEY-----\n",
  "client_email": "test-421@test-1593060333593.iam.gserviceaccount.com",
  "client_id": "109608772537106852856",
  "type": "service_account"
});
var _scopes = [CalendarApi.CalendarScope]; //defines the scopes for the calendar api


  void initEvents() {
    events = new Map<DateTime, List>();

    events = {
      DateTime(2019, 9, 25): ['Calgames Meeting'],
      DateTime(2019, 9, 27): ['Strategy Meeting'],
      DateTime(2019, 10, 5): ['Calgames Day 1'],
      DateTime(2019, 10, 6): ['Calgames Day 2'],
      DateTime(2019, 10, 10): ['Business Meeting'],
      // _selectedDay.subtract(Duration(days: 30)): [
      //   'Event A0',
      //   'Event B0',
      //   'Event C0'
      // ],
    };

    for (int i = 0; i < 9; i++) {
      events.putIfAbsent(DateTime(2019, 10, 9 + 7 * i),
          () => ['Projects', 'R & D', 'Mad Max']);
      events.putIfAbsent(DateTime(2019, 10, 11 + 7 * i),
          () => ['Projects', 'R & D', 'Mad Max']);
    }

    clientViaServiceAccount(accountCredentials, _scopes).then((client) {
      var calendar = new CalendarApi(client);
      var calEvents = calendar.events.list("team670@homesteadrobotics.com");
      calEvents.then((Events e) {
        e.items.forEach((Event event) {
          try{
            // print(event.start.dateTime.year);
            events.putIfAbsent(DateTime(event.start.dateTime.year, event.start.dateTime.month, event.start.dateTime.day), () => [event.summary]);
          } catch (e){
            
          }
          });
      });
    });
  }

  @override
  State<StatefulWidget> createState() {
    this.initEvents();
    return new _CalendarState(events);
  }
}

class _CalendarState extends State<Calendar> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  _CalendarState([this._events]);

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        title: Text('Calendar'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // Switch out 2 lines below to play with TableCalendar's settings
          //-----------------------
          _buildTableCalendar(),
          // _buildTableCalendarWithBuilders(),
          const SizedBox(height: 8.0),
          _buildButtons(),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
      bottomNavigationBar: BottomNavBar(context),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.green, 
        todayColor: Colors.blue,
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'pl_PL',
      calendarController: _calendarController,
      events: _events,
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
              color: Colors.green,
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

  Widget _buildButtons() {
    final dateTime = _events.keys.elementAt(_events.length - 2);

    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('Month'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.month);
                });
              },
            ),
            RaisedButton(
              child: Text('2 weeks'),
              onPressed: () {
                setState(() {
                  _calendarController
                      .setCalendarFormat(CalendarFormat.twoWeeks);
                });
              },
            ),
            RaisedButton(
              child: Text('Week'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.week);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        RaisedButton(
          child: Text(
              'Set day ${dateTime.day}-${dateTime.month}-${dateTime.year}'),
          onPressed: () {
            _calendarController.setSelectedDay(
              DateTime(dateTime.year, dateTime.month, dateTime.day),
              runCallback: true,
            );
          },
        ),
      ],
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
