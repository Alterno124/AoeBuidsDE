import 'package:aoe_builds_definitive_edition/home.dart';
import 'package:aoe_builds_definitive_edition/utilities/multi_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CreateBuild extends StatelessWidget {
  User detailsUser;
  String tipo;

  CreateBuild({required this.detailsUser, required this.tipo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreateBuilds(
        detailsUser: detailsUser,
        tipo: tipo,
      ),
    );
  }
}

class CreateBuilds extends StatelessWidget {
  User detailsUser;
  String tipo;

  CreateBuilds({required this.detailsUser, required this.tipo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Creación de Orden de Construcción',
            style: GoogleFonts.adamina(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            )),
        centerTitle: true,
        backgroundColor: HexColor("#a98147"),
      ),
      body: DropDown(
        detailsUser: detailsUser,
        tipo: tipo,
      ),
    );
  }
}

class DropDown extends StatefulWidget {
  User detailsUser;
  String tipo;

  DropDown({required this.detailsUser, required this.tipo});

  @override
  DropDownWidget createState() =>
      DropDownWidget(detailsUser: detailsUser, tipo: tipo);
}

class DropDownWidget extends State {
  User detailsUser;
  String tipo;

  final _formKey = GlobalKey<FormState>();

  DropDownWidget({required this.detailsUser, required this.tipo});

  // Default Drop Down Item.
  String dropdownValue = 'Age Of Empires 1 D.E';

  // To show Selected Item in Text.
  String holder = '';

  List<String> actorsName = [
    'Age Of Empires 1 D.E',
    'Age Of Empires 2 D.E',
    'Age Of Empires 3 D.E',
    'Age Of Empires 4',
    'Age Of Mythology'
  ];

  final nombreOrden = TextEditingController();

  void continuar() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Home(detailsUser: detailsUser),
        ),
      );
    }
  }

  createData(String nombre, String alias) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Usuarios").doc(nombre);
    Map<String, dynamic> usuario = {
      "Nombre": nombre,
      "Alias": alias,
      "Publicaciones": 0
    };
    documentReference.set(usuario).whenComplete(() {
      print("$alias created");
    });
  }

  void getDropDownItem() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a Snackbar.
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Validation Success!')));
      setState(() {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MaterialApp(
              title: 'Multi Form',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                accentColor: Color(0xFF1DCC8C),
                platform: TargetPlatform.iOS,
              ),
              debugShowCheckedModeBanner: false,
              home: MultiForm(
                nombrebo: nombreOrden.text,
                detailsUser: detailsUser,
                tipe: dropdownValue,
              ),
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return tipo == "crear"
        ? Scaffold(
            extendBody: true,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
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
                        icon: Icon(Icons.home),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => Home(
                                detailsUser: detailsUser,
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
            body: Center(
              child: Column(children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(16.0),
                    child:
                        //Printing Item on Text Widget
                        Text(
                            "Selecciona la version del juego para realizar el orden de construcción",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.adamina(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ))),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: GoogleFonts.adamina(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  underline: Container(
                    height: 2,
                    color: HexColor("#a98147"),
                  ),
                  onChanged: (String? data) {
                    setState(() {
                      dropdownValue = data!;
                    });
                  },
                  items:
                      actorsName.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Nombre de Orden de Construcción",
                              labelStyle: GoogleFonts.adamina(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              )),
                          controller: nombreOrden,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Nombre de orden requerido';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text('¡ Crear !',
                      style: GoogleFonts.adamina(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      )),
                  onPressed: getDropDownItem,
                  color: Colors.yellow[800],
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                ),
              ]),
            ),
          )
        : Scaffold(
            body: Center(
              child: Column(children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(20.0),
                    child:
                        //Printing Item on Text Widget
                        Text("Tu alias de Age of Empires",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.adamina(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ))),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "¿Cual es tu alias de jugador?",
                              labelStyle: GoogleFonts.adamina(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Campo requerido";
                            } else {
                              FirebaseFirestore.instance
                                  .collection("Usuarios")
                                  .get()
                                  .then((dato) {
                                for (int i = 0; i < dato.size; i++) {
                                  if (value
                                          .toString()
                                          .toLowerCase()
                                          .split(" ")
                                          .join() ==
                                      dato.docs[i]["Alias"]
                                          .toString()
                                          .toLowerCase()
                                          .split(" ")
                                          .join()) {
                                    return "Alias existente";
                                  } else {
                                    createData(
                                        detailsUser.displayName.toString(),
                                        value.toString());
                                    return Navigator.of(context)
                                        .pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Home(detailsUser: detailsUser),
                                      ),
                                    );
                                  }
                                }
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text('¡ Continuar !',
                      style: GoogleFonts.adamina(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      )),
                  onPressed: continuar,
                  color: Colors.yellow[800],
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                ),
              ]),
            ),
          );
  }
}
