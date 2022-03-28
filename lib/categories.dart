import 'package:aoe_builds_definitive_edition/allbuildorders.dart';
import 'package:aoe_builds_definitive_edition/publicbuildorder.dart';
import 'package:aoe_builds_definitive_edition/tipegame.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Categories extends StatefulWidget {
  final User detailsUser;
  Categories({required this.detailsUser});
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int currentSelectedItem = 0;
  @override
  Widget build(BuildContext context) {
    int items = 3;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return SliverToBoxAdapter(
      child: Container(
        height: 100,
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items,
          itemBuilder: (context, index) => Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    margin: const EdgeInsets.only(
                      left: 30,
                      //left: queryData.size.width / 5.5,
                      right: 0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentSelectedItem = index;
                          if (index == 0) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => CreateBuild(
                                        detailsUser: widget.detailsUser,
                                        tipo: "crear",
                                      )),
                            );
                          }
                          if (index == 1) {
                            int numeroBo = 0;
                            FirebaseFirestore.instance
                                .collection("Usuarios")
                                .get()
                                .then((dato) {
                              for (int i = 0; i < dato.size; i++) {
                                if (dato.docs[i]["Nombre"] ==
                                    widget.detailsUser.displayName.toString()) {
                                  numeroBo = int.parse(
                                      dato.docs[i]["NumeroBO"].toString());
                                  break;
                                }
                              }
                            });
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => AllBuildOrders(
                                        detailUser: widget.detailsUser,
                                      )),
                            );
                          }
                          if (index == 2) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => PublicBuidOrder(
                                    detailUser: widget.detailsUser,
                                  )),
                            );
                          }
                          if (index == 3) {}
                        });
                      },
                      child: Card(
                        color: index == currentSelectedItem
                            ? Colors.yellow[800]
                            : Colors.white,
                        child: Icon(
                          index == 0
                              ? Icons.add
                              : index == 1
                                  ? Icons.format_list_numbered_outlined
                                  : index == 2
                                      ? Icons.public
                                      : index == 3
                                          ? Icons.connect_without_contact
                                          : Icons.cancel,
                          color: index == currentSelectedItem
                              ? Colors.white
                              : Colors.black.withOpacity(0.7),
                        ),
                        //elevation: 3,
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  margin: const EdgeInsets.only(
                    //left: index == 0 ? 20 : 0,
                    left: 30,
                    //left: queryData.size.width / 5.5,
                    right: 0,
                  ),
                  width: 90,
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                          index == 0
                              ? "Crear B.O"
                              : index == 1
                                  ? "Mis B.O"
                                  : index == 2
                                      ? "Publicar B.O"
                                      : index == 3
                                          ? "Reportar"
                                          : "",
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          )),
                      Spacer(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
