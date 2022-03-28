import 'dart:async';

import 'package:aoe_builds_definitive_edition/allbuildorders.dart';
import 'package:aoe_builds_definitive_edition/home.dart';
import 'package:aoe_builds_definitive_edition/utilities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'empty_state.dart';
import 'form.dart';

class MultiForm extends StatefulWidget {
  final String tipe;
  User detailsUser;
  String nombrebo;

  MultiForm(
      {required this.tipe, required this.detailsUser, required this.nombrebo});

  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  List<UserForm> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#F9A825"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text('Guardar',
                style: GoogleFonts.adamina(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )),
            textColor: Colors.white,
            onPressed: onSave,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              HexColor("#a98147"),
              HexColor("#a98147"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: users.length <= 0
            ? Center(
                child: EmptyState(
                  title: '¡Evita Confusiones!',
                  message:
                      '1. En la lista de categoría si bajas encontrarás unidades, recursos, tecnologías y edificios \n 2. La flecha indica ir ha o desarrollar alguna tecnología',
                ),
              )
            : ListView.builder(
                addAutomaticKeepAlives: true,
                itemCount: users.length,
                itemBuilder: (_, i) => users[i],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: onAddForm,
        foregroundColor: Colors.white,
      ),
    );
  }

  ///on form user deleted
  void onDelete(UserData _user) {
    setState(() {
      var find = users.firstWhere(
        (it) => it.user == _user,
      );
      if (find != null) users.removeAt(users.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _user = UserData();
      users.add(UserForm(
        tipe: widget.tipe,
        lenght: users.length + 1,
        user: _user,
        onDelete: () => onDelete(_user),
      ));
    });
  }

  int numeroBo = 0;

  void onSave() {
    Map<String, dynamic> ordenesConstruccion = new Map<String, dynamic>();
    for (int i = 0; i < users.length; i++) {
      ordenesConstruccion["paso ${i + 1}"] = users[i].isValid();
    }
    createData(widget.nombrebo, ordenesConstruccion, widget.tipe);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AllBuildOrders(detailUser: widget.detailsUser),
      ),
    );
  }

  createData(String nombre, Map<String, dynamic> orden, String version) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("Usuarios")
        .doc(widget.detailsUser.displayName)
        .collection("Ordenes")
        .doc(nombre);
    Map<String, dynamic> bo = {nombre: orden, "version": version, "Publico" : "No"};
    documentReference.set(bo).whenComplete(() {
      print("Bo creado");
    });
  }
}
