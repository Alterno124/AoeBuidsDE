import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class Build extends StatelessWidget {
  String nombre;
  User detailUser;
  List pasos;

  Build({required this.nombre, required this.detailUser, required this.pasos});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        nombre: nombre,
        detailUser: detailUser,
        pasos: pasos,
      ),
    );
  }
}

List _elements = [
  {'name': 'John', 'group': 'Team A'},
  {'name': 'Will', 'group': 'Team B'},
  {'name': 'Beth', 'group': 'Team A'},
  {'name': 'Miranda', 'group': 'Team B'},
  {'name': 'Mike', 'group': 'Team C'},
  {'name': 'Danny', 'group': 'Team C'},
];

class MyHomePage extends StatefulWidget {
  MyHomePage(
      {required this.nombre, required this.detailUser, required this.pasos});

  final String nombre;
  User detailUser;
  List pasos;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int maxCount = 0;
  final random = math.Random();
  final scrollDirection = Axis.vertical;

  late AutoScrollController controller;
  late List<int> randomList;

  List<String> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);
    randomList = Iterable<int>.generate(widget.pasos.length).toList();
    maxCount = widget.pasos.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            widget.nombre,
            style: GoogleFonts.adamina(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.red),
      body: ListView(
        padding: EdgeInsets.fromLTRB(10, 40, 10, 20),
        scrollDirection: scrollDirection,
        controller: controller,
        children: randomList.map<Widget>((data) {
          return _getRow(
            data,
          );
        }).toList(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepOrange,
        onPressed: _scrollToIndex,
        icon: Icon(Icons.navigate_next_outlined),
        label: Text(
          'Next Step',
          style: GoogleFonts.adamina(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  int counter = -1;

  Future _scrollToIndex() async {
    setState(() {
      counter++;
      if (counter >= maxCount) counter = 0;
    });
    await controller.scrollToIndex(counter,
        preferPosition: AutoScrollPosition.begin);
    controller.highlight(counter);
  }

  Widget _getRow(int index) {
    return _wrapScrollTag(
        index: index,
        child: Container(
          alignment: Alignment.center,
          height: 80,
          child: Column(
            children: [
              Text(
                "Paso ${index + 1}",
                style: GoogleFonts.adamina(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
              ),
              Text(
                widget.pasos[index],
                style: GoogleFonts.adamina(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _wrapScrollTag({required int index, required Widget child}) =>
      AutoScrollTag(
        key: ValueKey(index),
        controller: controller,
        index: index,
        child: child,
        highlightColor: Colors.amber,
      );
}
