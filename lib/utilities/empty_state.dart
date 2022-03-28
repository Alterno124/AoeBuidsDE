import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyState extends StatelessWidget {
  final String title, message;

  EmptyState({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 16,
      color: Theme.of(context).cardColor.withOpacity(.95),
      shadowColor: Theme.of(context).accentColor.withOpacity(.5),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(title,
                style: GoogleFonts.adamina(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                )),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(message, textAlign: TextAlign.center, style: GoogleFonts.adamina(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
