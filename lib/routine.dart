import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Routine extends StatefulWidget {
  const Routine({super.key});

  @override
  State<Routine> createState() => _RoutineState();
}

class _RoutineState extends State<Routine> {
  @override
  void initState() {
    super.initState();
    readJson();
  }

  List _items = [];
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/routine.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["Monday"];
      _items = data["Tuesday"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        _items.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      key: ValueKey(_items[index][0]),
                      margin: const EdgeInsets.all(15.5),
                      color: Color.fromARGB(255, 205, 207, 209),
                      child: ListTile(
                        trailing: Text(_items[index]["Period"]),
                        leading: Text(_items[index]["id"]),
                        title: Text(_items[index]["StartTime"]),
                        subtitle: Text(_items[index]["EndTime"]),
                      ),
                    );
                  },
                ),
              )
            : Container(),
      ]),
    );
  }
}

class ScheduleItem {
  final String id;
  final String startTime;
  final String endTime;
  final String period;

  ScheduleItem(
      {required this.id,
      required this.startTime,
      required this.endTime,
      required this.period});
}
