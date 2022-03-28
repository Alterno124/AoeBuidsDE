import 'package:aoe_builds_definitive_edition/utilities/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef OnDelete();

class UserForm extends StatefulWidget {
  final UserData user;
  final state = _UserFormState();
  final OnDelete onDelete;
  final int lenght;
  final String tipe;

  UserForm(
      {required this.user,
      required this.onDelete,
      required this.lenght,
      required this.tipe});

  @override
  _UserFormState createState() => state;

  String isValid() => state.data();
}

class _UserFormState extends State<UserForm> {
  final form = GlobalKey<FormState>();
  final List<String> categoriesAoe1 = [
    "Categoría",
    "Aldeano",
    "Soldado con Garrote",
    "Soldado con Hacha",
    "Soldado con Espada Corta"
        "Barco de Pesca",
    "Buque de Pesca",
    "Barco Mercante"
        "Arquero",
    "Arquero Experto",
    "Arquero con Arco"
        "Explorador",
    "Caballería",
    "Catafracta"
        "Hóplita",
    "Falange",
    "Centurión"
        "Catapulta Ligera",
    "Catapulta",
    "Sacerdote",
    "Recursos"
  ];
  final List<String> categoriesAoe2 = [
    "Categoría",
    "Aldeano",
    "Milicia",
    "Lancero",
    "Piquero",
    "Hombre de Armas",
    "Explorador Águila",
    "Hostigador",
    "Arquero",
    "Hostigador Élite",
    "Ballestero",
    "Arquero a Caballo",
    "Caballería de Exploración",
    "Caballería Ligera",
    "Jinete",
    "Monje",
    "Mangana",
    "Escorpión",
    "Ariete",
    "Recursos",
    "Comida",
    "Madera",
    "Oro",
    "Piedra",
    "Oveja",
    "Jabalí",
    "Bayas",
    "Graja",
    "Ciervo",
    "Pesca",
    "Edificios",
    "Casa",
    "Molino",
    "Campamento Maderero",
    "Campamento Minero",
    "Cuartel",
    "Galería de Tiro con Arco",
    "Establo",
    "Muelle",
    "Mercado",
    "Herrería",
    "Taller de Asedio",
    "Castillo",
    "Templo",
    "Centro Urbano",
    "Universidad",
    "Torre",
    "Tecnologías",
    "Telar",
    "Hacha de Doble Filo",
    "Collera",
    "Carretilla",
    "Hombre de Armas",
    "Guerrero Águila",
    "Ballestero",
    "Guerrillero de Élite",
    "Piquero",
    "Forja",
    "Armadura de Láminas",
    "Armadura de Láminas Caballería Pesada",
    "Armadura Acolchada Arquero",
    "Emplumado de Flechas",
    "Flecha de Punzón",
    "Balística",
    "Química",
    "Edad Feudal",
    "Edad de los Castillos",
    "Edad Imperial",
    "Corona Plata",
    "Corona Oro"
  ];
  final List<String> numbers = [
    "Número",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10"
  ];
  late String _currentItemSelectedCategories;
  late String _currentItemSelectedCategoriesTwo;
  late String _currentItemSelectedNumbers;
  late String _currentItemSelectedNumbersTwo;

  @override
  void initState() {
    super.initState();
    _currentItemSelectedCategories = categoriesAoe2[0];
    _currentItemSelectedCategoriesTwo = categoriesAoe2[0];
    _currentItemSelectedNumbers = numbers[0];
    _currentItemSelectedNumbersTwo = numbers[0];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                title: Text("Paso " + widget.lenght.toString(),
                    style: GoogleFonts.adamina(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )),
                backgroundColor: Theme.of(context).accentColor,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  )
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 10, top: 30, bottom: 30),
                child: Row(
                  children: [
                    PopupMenuButton<String>(
                      itemBuilder: (context) {
                        return numbers.map((str) {
                          return PopupMenuItem(
                              value: str,
                              child: str == "Número"
                                  ? Text(str,
                                      style: GoogleFonts.adamina(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ))
                                  : Text(str,
                                      style: GoogleFonts.adamina(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      )));
                        }).toList();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(_currentItemSelectedNumbers),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                      onSelected: (v) {
                        setState(() {
                          print('!!!===== $v');
                          _currentItemSelectedNumbers = v;
                        });
                      },
                    ),
                    PopupMenuButton<String>(
                      itemBuilder: (context) {
                        return categoriesAoe2.map((str) {
                          return PopupMenuItem(
                              value: str,
                              child: str == "Categoría"
                                  ? Text("Unidades",
                                      style: GoogleFonts.adamina(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ))
                                  : str == "Recursos"
                                      ? Text(str,
                                          style: GoogleFonts.adamina(
                                            textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 12,
                                            ),
                                          ))
                                      : str == "Edificios"
                                          ? Text(str,
                                              style: GoogleFonts.adamina(
                                                textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                  fontSize: 12,
                                                ),
                                              ))
                                          : str == "Tecnologías"
                                              ? Text(str,
                                                  style: GoogleFonts.adamina(
                                                    textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red,
                                                      fontSize: 12,
                                                    ),
                                                  ))
                                              : Text(str,
                                                  style: GoogleFonts.adamina(
                                                    textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                    ),
                                                  )));
                        }).toList();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(_currentItemSelectedCategories),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                      onSelected: (v) {
                        setState(() {
                          print('!!!===== $v');
                          _currentItemSelectedCategories = v;
                        });
                      },
                    ),
                    Icon(Icons.arrow_forward),
                    PopupMenuButton<String>(
                      itemBuilder: (context) {
                        return numbers.map((str) {
                          return PopupMenuItem(
                              value: str,
                              child: str == "Número"
                                  ? Text(str,
                                      style: GoogleFonts.adamina(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ))
                                  : Text(str,
                                      style: GoogleFonts.adamina(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      )));
                        }).toList();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(_currentItemSelectedNumbersTwo),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                      onSelected: (v) {
                        setState(() {
                          print('!!!===== $v');
                          _currentItemSelectedNumbersTwo = v;
                        });
                      },
                    ),
                    PopupMenuButton<String>(
                      itemBuilder: (context) {
                        return categoriesAoe2.map((str) {
                          return PopupMenuItem(
                              value: str,
                              child: str == "Categoría"
                                  ? Text("Unidades",
                                      style: GoogleFonts.adamina(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ))
                                  : str == "Recursos"
                                      ? Text(str,
                                          style: GoogleFonts.adamina(
                                            textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 12,
                                            ),
                                          ))
                                      : str == "Edificios"
                                          ? Text(str,
                                              style: GoogleFonts.adamina(
                                                textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                  fontSize: 12,
                                                ),
                                              ))
                                          : str == "Tecnologías"
                                              ? Text(str,
                                                  style: GoogleFonts.adamina(
                                                    textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red,
                                                      fontSize: 12,
                                                    ),
                                                  ))
                                              : Text(str,
                                                  style: GoogleFonts.adamina(
                                                    textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                    ),
                                                  )));
                        }).toList();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(_currentItemSelectedCategoriesTwo),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                      onSelected: (v) {
                        setState(() {
                          print('!!!===== $v');
                          _currentItemSelectedCategoriesTwo = v;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///form validator
  String data() {
    String data = _currentItemSelectedNumbers +
        " " +
        _currentItemSelectedCategories +
        " pasan " +
        _currentItemSelectedNumbersTwo +
        " " +
        _currentItemSelectedCategoriesTwo;
    return data;
  }
}
