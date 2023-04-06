import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routine1/routine.dart';
import 'routine.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: RoutineApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class RoutineApp extends StatefulWidget {
  const RoutineApp({super.key});

  @override
  State<RoutineApp> createState() => _RoutineAppState();
}

class _RoutineAppState extends State<RoutineApp> {
  @override
  void initState() {
    super.initState();
    readJson();
  }

  List _items = [];
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/day.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["days"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(199, 110, 22, 168),
            leading: const Icon(Icons.menu),
            actions: [
              IconButton(onPressed: (() {}), icon: Icon(Icons.search)),
            ],
            title: const Text(
              "Routine App",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Routine()));
              },
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: _items.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(212, 47, 114, 30),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      _items[index]["day"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          )),
    );
  }
}
