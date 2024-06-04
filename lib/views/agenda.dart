import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:calendar_view/calendar_view.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agenda"),
      ),
      body: CalendarControllerProvider(
        controller: EventController(),
        child: Scaffold(
          body: DayView(
            minDay: DateTime(2020),
            maxDay: DateTime(2050),
            initialDay: today,
          ),
        )
      )
    );
  }
}

