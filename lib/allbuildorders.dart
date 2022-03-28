import 'package:aoe_builds_definitive_edition/build.dart';
import 'package:aoe_builds_definitive_edition/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class AllBuildOrders extends StatefulWidget {
  User detailUser;

  AllBuildOrders({required this.detailUser});

  @override
  _AllBuildOrdersState createState() => _AllBuildOrdersState();
}

class _AllBuildOrdersState extends State<AllBuildOrders> {
  final Stream<QuerySnapshot> UsersStream =
      FirebaseFirestore.instance.collection('Usuarios').snapshots();

  List lista = [];

  List datalist = [];

  int tamano = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#a98147"),
          centerTitle: true,
          title: Text(
            'Mis ordenes de construcción',
            style: GoogleFonts.adamina(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
        body: ExpenseList(
          detailUser: widget.detailUser,
        ),
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => Home(
                        detailsUser: widget.detailUser,
                      )),
            );
          },
          child: Icon(Icons.format_list_numbered_outlined),
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
                    onPressed: () {},
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
                    icon: Icon(Icons.add),
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
      ),
    );
  }

  void viewOrder(String nombre) async {
    List ordenesConstruccion = [];
    final DocumentReference documents = await FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(widget.detailUser.displayName.toString())
        .collection("Ordenes")
        .doc(nombre);
    DocumentSnapshot snapshot = await documents.get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    int counter = 0;
    data.forEach((k, v) => {ordenesConstruccion.add(v)});
    int contador = 1;
    List pasosOrden = [];
    while (contador != 0) {
      if (ordenesConstruccion[0]["paso ${contador}"] != null) {
        pasosOrden.add(ordenesConstruccion[0]["paso ${contador}"]);
        contador++;
      } else {
        contador = 0;
      }
    }
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => Build(
                nombre: nombre,
                detailUser: widget.detailUser,
                pasos: pasosOrden,
              )),
    );
  }
}

class ExpenseList extends StatelessWidget {
  final User detailUser;

  const ExpenseList({Key? key, required this.detailUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Usuarios")
            .doc("Eduardo Camargo")
            .collection("Ordenes")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Text("There is no expense");
          return ListView(
              children: getExpenseItems(snapshot, context, detailUser));
        });
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context,
      User detailUSer) {
    return snapshot.data!.docs
        .map((doc) => Card(
              child: ListTile(
                  onTap: () async {
                    List ordenesConstruccion = [];
                    final DocumentReference documents = await FirebaseFirestore
                        .instance
                        .collection('Usuarios')
                        .doc(detailUSer.displayName.toString())
                        .collection("Ordenes")
                        .doc(doc.id);
                    DocumentSnapshot snapshot = await documents.get();
                    Map<String, dynamic> data =
                        snapshot.data() as Map<String, dynamic>;
                    int counter = 0;
                    data.forEach((k, v) => {ordenesConstruccion.add(v)});
                    int contador = 1;
                    List pasosOrden = [];
                    while (contador != 0) {
                      if (ordenesConstruccion[0]["paso ${contador}"] != null) {
                        pasosOrden
                            .add(ordenesConstruccion[0]["paso ${contador}"]);
                        contador++;
                      } else {
                        contador = 0;
                      }
                    }
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => Build(
                                nombre: doc.id,
                                detailUser: detailUser,
                                pasos: pasosOrden,
                              )),
                    );
                  },
                  trailing: FlatButton(
                    onPressed: () async {
                      DocumentReference actualiza = FirebaseFirestore.instance
                          .collection("Usuarios")
                          .doc(detailUser.displayName);
                      actualiza
                          .update({"Publicaciones": FieldValue.increment(-1)});
                      FirebaseFirestore.instance
                          .collection("OrdenesPublicos")
                          .doc(doc.id)
                          .delete();
                      FirebaseFirestore.instance
                          .collection("Usuarios")
                          .doc("Eduardo Camargo")
                          .collection("Ordenes")
                          .doc(doc.id)
                          .delete();
                    },
                    child: Icon(Icons.delete, color: Colors.red[400]),
                  ),
                  title: Text(doc.id),
                  subtitle: Text(
                      doc["version"] + "\n" + "Publico: " + doc["Publico"])),
            ))
        .toList();
  }
}
