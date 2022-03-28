import 'dart:math';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class Header extends StatelessWidget {
  User detailsUser;

  Header({required this.detailsUser});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    String url;
    bool twitter = false;
    UserInfo photo = detailsUser.providerData[0];
    if (photo.photoURL!.contains("_normal")) {
      url = photo.photoURL!.replaceAll("_normal", "");
      twitter = true;
    } else {
      url = photo.photoURL!;
    }
    return SliverList(
        delegate: SliverChildListDelegate(
      [
        Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: size.height / 7,
                  decoration: BoxDecoration(
                      color: HexColor("#a98147"),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(45),
                      ),
                      boxShadow: [BoxShadow(blurRadius: 2)]),
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white70,
                              radius: 35,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(url),
                                radius: 30,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              children: [
                                Text(detailsUser.displayName ?? "",
                                    style: GoogleFonts.adamina(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: queryData.size.width / 22,
                                      ),
                                    )),
                                twitter
                                    ? Container(
                                        padding: EdgeInsets.all(4),
                                        child: Text(""),
                                      )
                                    : Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.black54),
                                        child: Text(detailsUser.email ?? "",
                                            style: GoogleFonts.adamina(
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    queryData.size.width / 30,
                                              ),
                                            )),
                                      ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            /*Positioned(
              bottom: 0,
              child: Container(
                height: 50,
                width: size.width,
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "What does your belly want to eat?",
                      suffixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.only(left: 20)
                    ),
                  ),
                ),
              ),
            )*/
          ],
        ),
      ],
    ));
  }
}
