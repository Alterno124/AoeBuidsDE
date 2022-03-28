import 'package:aoe_builds_definitive_edition/categories.dart';
import 'package:aoe_builds_definitive_edition/header.dart';
import 'package:aoe_builds_definitive_edition/login.dart';
import 'package:aoe_builds_definitive_edition/tipegame.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'list.dart';

class Home extends StatelessWidget {
  final User detailsUser;

  Home({required this.detailsUser});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.grey,
        cardColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: HexColor("#a98147"),
          centerTitle: true,
        ),
        bottomAppBarColor: HexColor("#a98147"),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.yellow[800]),
      ),
      home: HomeP(
        detailsUser: detailsUser,
      ),
    );
  }
}

class HomeP extends StatefulWidget {
  final User detailsUser;

  HomeP({required this.detailsUser});

  @override
  _HomePState createState() => _HomePState();
}

class _HomePState extends State<HomeP> {
  @override
  void initState() {
    super.initState();
  }

  String dropdownValue = 'Selecciona';
  String tipoOrden = "";

  List<String> spinnerItems = [
    'Selecciona',
    'Age Of Empires 1 D.E',
    'Age Of Empires 2 D.E',
    'Age Of Empires 3 D.E',
    'Age Of Empires 4',
    'Age Of Mythology'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text(
              "Aoe Builds Definitive Edition",
              style: GoogleFonts.adamina(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            //leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => View_login(),
                    ),
                  );
                },
              )
            ],
          ),
          Header(
            detailsUser: widget.detailsUser,
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 25,
              margin: EdgeInsets.only(
                left: 20,
                right: 0,
              ),
              child: Container(
                width: 90,
                height: 90,
                child: Text(
                  "¿Qué quieres hacer hoy?",
                  style: GoogleFonts.adamina(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
          /*SliverToBoxAdapter(
            child: Container(
              height: 500,
              margin: EdgeInsets.only(
                left: 20,
                right: 0,
              ),
              child: Container(
                width: 90,
                height: 90,
                child: Flexible(
                  child: new FirebaseAnimatedList(
                      query: _ref,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        return new ListTile(
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _ref.child(snapshot.key).remove(),
                          ),
                          title:
                              new Text(ubicacion = snapshot.value['latitude']),
                        );
                      }),
                ),
              ),
            ),
          ),*/
          Categories(
            detailsUser: widget.detailsUser,
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 30,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 25,
              margin: EdgeInsets.only(
                left: 20,
                right: 0,
              ),
              child: Container(
                width: 90,
                height: 90,
                child: Text(
                  "¡Ordenes Subidos por la comunidad!",
                  style: GoogleFonts.adamina(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 350,
              child: Scaffold(
                body: Center(
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(70, 10, 20, 10),
                      child: Row(
                        children: [
                          Text("Versión: ",
                              style: GoogleFonts.adamina(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              )),
                          DropdownButton<String>(
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: GoogleFonts.adamina(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            underline: Container(
                              height: 2,
                              color: Colors.yellow[800],
                            ),
                            onChanged: (String? data) {
                              tipoOrden = data!;
                              setState(() {
                                dropdownValue = data;
                              });
                            },
                            items: spinnerItems
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 250,
                      child: dropdownValue != "Selecciona"
                          ? Lista(
                              detailsUser: widget.detailsUser,
                              tipoVersion: dropdownValue,
                            )
                          : Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Text(
                                  "Selecciona una versión para ver los ordenes de construccion",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.adamina(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  )),
                            ),
                    )
                  ]),
                ),
              ),
              //child: Lista(detailsUser: widget.detailsUser,),
            ),
          ),
          /*widget.id_robo != null
              ? SliverToBoxAdapter(
                  child: Container(
                    height: 25,
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 0,
                    ),
                    child: Container(
                      width: 90,
                      height: 90,
                      child: Text(
                        "¡Alertas de robo!",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              : SliverToBoxAdapter(
                  child: Container(
                    height: 25,
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 0,
                    ),
                    child: Container(
                      width: 90,
                      height: 90,
                      child: Text(
                        "",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),*/
          /*Portfolio(
            id_robo: widget.id_robo,
            imagen: widget.imagen,
            descripcion: widget.descripcion,
          )*/
        ],
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.home),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
        child: Container(
          color: Colors.black38,
          child: BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => CreateBuilds(
                          detailsUser: widget.detailsUser,
                          tipo: "crear",
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                /*IconButton(
                  icon: Icon(Icons.contact_phone_outlined),
                  color: Colors.white,
                  onPressed: () {},
                ),*/
                Spacer(),
                /*IconButton(
                  icon: Icon(Icons.textsms_outlined),
                  color: Colors.white,
                  onPressed: () {},
                ),*/
                SizedBox(
                  width: 20,
                ),
                IconButton(
                  icon: Icon(Icons.format_list_numbered_outlined),
                  color: Colors.white,
                  onPressed: () {
                    /*
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new View_map(
                          detailsUser: widget.detailsUser,
                        ),
                      ),
                    );*/
                  },
                ),
                SizedBox(
                  width: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
