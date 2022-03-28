import 'package:aoe_builds_definitive_edition/build.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class Lista extends StatelessWidget {
  final User detailsUser;
  final String tipoVersion;

  const Lista({Key? key, required this.detailsUser, required this.tipoVersion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> UsersStream =
        FirebaseFirestore.instance.collection('Usuarios').snapshots();

    List lista = [];

    List datalist = [];

    int tamano = 0;

    return ListaExtensa(
      tipoVersion: tipoVersion,
      detailUser: detailsUser,
    );
  }
}

class ListaExtensa extends StatefulWidget {
  final User detailUser;
  final String tipoVersion;

  ListaExtensa({Key? key, required this.detailUser, required this.tipoVersion})
      : super(key: key);

  @override
  State<ListaExtensa> createState() => _ListaExtensaState();
}

class _ListaExtensaState extends State<ListaExtensa> {
  bool isLiked = false;

  int likeCount = 17;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("OrdenesPublicos")
            .where('version', isEqualTo: widget.tipoVersion)
            .orderBy('Autor', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Text("There is no expense");
          return ListView(
              children: getExpenseItems(snapshot, context, widget.detailUser));
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
                                detailUser: widget.detailUser,
                                pasos: pasosOrden,
                              )),
                    );
                  },
                  /*trailing: Container(
                    height: 50,
                    width: 100,
                    child: Row(
                      children: [
                        LikeButton(
                          size: 30,
                          isLiked: isLiked,
                          onTap: (isLiked) async {
                            onLikeButtonTapped();
                          },
                          likeCount: doc["Likes"],
                          likeBuilder: (bool like) {
                            print('El valor del clock es ' + isLiked.toString());
                            return Icon(
                              Icons.thumb_up,
                              color: like ? Colors.red : Colors.grey,
                            );
                          },
                        ),
                        Container(
                          width: 2,
                        ),
                        LikeButton(
                          size: 30,
                          isLiked: isLiked,
                          likeCount: doc["Dislikes"],
                          likeBuilder: (bool like) {
                            return Icon(
                              Icons.thumb_down,
                              color: like ? Colors.red : Colors.grey,
                            );
                          },
                          countBuilder: (count, isLiked, text) {},
                        )
                      ],
                    ),
                  ),*/
                  leading: Icon(
                    Icons.arrow_forward,
                    color: Colors.yellow[800],
                  ),
                  title: Text(doc.id),
                  subtitle: Text("Versión: " +
                      doc["version"] +
                      "\n" +
                      "Autor: " +
                      doc["Autor"])),
            ))
        .toList();
  }

  Future<bool?> onLikeButtonTapped() async {
    final DocumentReference documents = await FirebaseFirestore.instance
        .collection('OrdenesPublicos')
        .doc("Ruben");
    documents.update({"Likes": FieldValue.increment(1)});
    setState(() {
      isLiked = true;
    });
  }
}
