import 'dart:async';
import 'package:aoe_builds_definitive_edition/home.dart';
import 'package:aoe_builds_definitive_edition/tipegame.dart';
import 'package:aoe_builds_definitive_edition/utilities/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_twitter/flutter_twitter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class View_login extends StatefulWidget {
  @override
  _View_loginState createState() => _View_loginState();
}

class _View_loginState extends State<View_login> {
  final Color secondaryColor = Colors.white;

  final Color logoGreen = Color(0xff25bcbb);
  bool _loading = false;

  void _onLoading() {
    setState(() {
      _loading = true;
      new Future.delayed(new Duration(seconds: 10), _login);
    });
  }

  Future _login() async {
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Scaffold(
            body: Container(
              child: new Stack(
                children: <Widget>[
                  new Container(
                    alignment: AlignmentDirectional.center,
                    decoration: new BoxDecoration(
                      color: Colors.white70,
                    ),
                    child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.circular(10.0)),
                      width: 300.0,
                      height: 200.0,
                      alignment: AlignmentDirectional.center,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Center(
                            child: new SizedBox(
                              height: 50.0,
                              width: 50.0,
                              child: new CircularProgressIndicator(
                                color: HexColor("#a98147"),
                                value: null,
                                strokeWidth: 7.0,
                              ),
                            ),
                          ),
                          new Container(
                            margin: const EdgeInsets.only(top: 25.0),
                            child: new Center(
                              child: new Text(
                                "Cargando... por favor espera",
                                style: GoogleFonts.adamina(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            backgroundColor: HexColor("#a98147"),
            body: Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    /*Image(
                    height: 150.0,
                    width: 150.0,
                    image: AssetImage('Images/logo_1.png')),*/
                    SizedBox(height: 40),
                    Text(
                      '¡Bienvenido!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.adamina(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Esta es una herramienta para que puedas crear y compartir ordenes de construcción para toda la saga Age Of Empires',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.adamina(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    //_buildTextField(nameController, Icons.account_circle, 'Username'),
                    //SizedBox(height: 20),
                    //_buildTextField(passwordController, Icons.lock, 'Password'),
                    //SizedBox(height: 30),
                    /*MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: () {},
                  color: logoGreen,
                  child: Text('Login',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  textColor: Colors.white,
                ),*/
                    Text(
                      '¿Cómo quieres continuar?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.adamina(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    MaterialButton(
                      elevation: 0,
                      minWidth: double.maxFinite,
                      height: 50,
                      onPressed: () async {
                        _onLoading();
                        User? user = await Authentication.signInWithGoogle(
                            context: context);
                        if (user != null) {
                          FirebaseFirestore.instance
                              .collection("Usuarios")
                              .get()
                              .then((value) {
                            for (int i = 0; i < value.size; i++) {
                              if (value.docs[i].id == user.displayName) {
                                return Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Home(detailsUser: user),
                                  ),
                                );
                              } else {
                                return Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => CreateBuild(
                                      detailsUser: user,
                                      tipo: "alias",
                                    ),
                                  ),
                                );
                              }
                            }
                          });
                          /*FirebaseFirestore.instance
                          .collection("UsersBikes")
                          .doc(user.displayName)
                          .get()
                          .then((value) {
                        if (value.data() != null) {
                          /*Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => Home(
                                detailsUser: user,
                              ),
                            ),
                          );*/
                        } else {
                          /*Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => Success(
                                detailsUser: user,
                              ),
                            ),
                          );*/
                        }
                      });*/
                        }
                      },
                      color: HexColor("#4c8bf5"),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.google),
                          SizedBox(width: 10),
                          Text('Continua con Google',
                              style: GoogleFonts.adamina(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              )),
                        ],
                      ),
                      textColor: Colors.white,
                    ),
                    SizedBox(height: 20),
                    MaterialButton(
                      elevation: 0,
                      minWidth: double.maxFinite,
                      height: 50,
                      onPressed: () async {
                        _onLoading();
                        FacebookLogin facebookSignIn = new FacebookLogin();
                        final FacebookLoginResult result =
                            await facebookSignIn.logIn(['email']);
                        FirebaseApp firebaseApp =
                            await Firebase.initializeApp();
                        final FacebookAccessToken accessToken =
                            result.accessToken;
                        final FacebookAccessToken fbToken = accessToken;
                        final AuthCredential credential =
                            FacebookAuthProvider.credential(fbToken.token);
                        final UserCredential authResult = await FirebaseAuth
                            .instance
                            .signInWithCredential(credential);
                        User? fbUser = authResult.user;
                        if (fbUser != null) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => Home(detailsUser: fbUser),
                            ),
                          );
                          /*FirebaseFirestore.instance
                          .collection("UsersBikes")
                          .doc(fbUser.displayName)
                          .get()3
                          .then((value) {
                        if (value.data() != null) {
                          /*Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => Home(
                                detailsUser: fbUser,
                              ),
                            ),
                          );*/
                        } else {
                          /*Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => Success(
                                detailsUser: fbUser,
                              ),
                            ),
                          );*/
                        }
                      });*/
                        }
                      },
                      color: HexColor("#3b5998"),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.facebook),
                          SizedBox(width: 10),
                          Text('Continua con Facebook',
                              style: GoogleFonts.adamina(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              )),
                        ],
                      ),
                      textColor: Colors.white,
                    ),
                    SizedBox(height: 20),
                    MaterialButton(
                      elevation: 0,
                      minWidth: double.maxFinite,
                      height: 50,
                      onPressed: () async {
                        _onLoading();
                        try {
                          FirebaseApp firebaseApp =
                              await Firebase.initializeApp();
                          TwitterLogin twitterLogin = new TwitterLogin(
                            consumerKey: 'stnrJhcK4vu3G1FrgJ9ezLXiS',
                            consumerSecret:
                                'wOr6lU5w6DNomI5ZYmTBfUNgnPT8vAbBnkmDdOFL1RSSO7wFJM',
                          );
                          TwitterLoginResult result =
                              await twitterLogin.authorize();
                          var session = result.session;
                          AuthCredential credential =
                              TwitterAuthProvider.credential(
                                  accessToken: session.token,
                                  secret: session.secret);
                          final UserCredential authResult = await FirebaseAuth
                              .instance
                              .signInWithCredential(credential);
                          User? twUser = authResult.user;
                          if (twUser != null) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => Home(detailsUser: twUser),
                              ),
                            );
                            /*FirebaseFirestore.instance
                            .collection("UsersBikes")
                            .doc(twUser.displayName)
                            .get()
                            .then((value) {
                          if (value.data() != null) {
                            /*Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => Home(
                                  detailsUser: twUser,
                                ),
                              ),
                            );*/
                          } else {
                            /*Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => Success(
                                  detailsUser: twUser,
                                ),
                              ),
                            );*/
                          }
                        });*/
                          }
                        } catch (NoSuchMethodError) {
                          _showDialog(context);
                        }
                      },
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.twitter),
                          SizedBox(width: 10),
                          Text('Continua con Twitter',
                              style: GoogleFonts.adamina(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              )),
                        ],
                      ),
                      textColor: Colors.white,
                    ),
                    SizedBox(height: 100),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _buildFooterLogo(),
                    )
                  ],
                ),
              ),
            ));
  }

  void _showDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Advertencia"),
          content: new Text(
              "Descargar la aplicación de Twitter para poder continuar."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _buildFooterLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        /*Image.asset(
          'assets/tgd_white.png',
          height: 40,
        ),¨*/
        /*Text('Seku 2021',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),*/
      ],
    );
  }

  _buildTextField(
      TextEditingController controller, IconData icon, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: secondaryColor, border: Border.all(color: Colors.red)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.blue[900]),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.blue[900]),
            icon: Icon(
              icon,
              color: Colors.blue[900],
            ),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }
}
