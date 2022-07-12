import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styled_widget/styled_widget.dart';

class StyledWidgetLogo extends StatelessWidget {
  final TextStyle _textStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 40,
    color: Colors.white,
  );

  final _widgetStyle = ({required Widget child}) => child
      .padding(vertical: 15, horizontal: 25)
      .decorated(
    borderRadius: BorderRadius.circular(20),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.pink.shade200,
        Colors.amber.shade200,
      ],
    ),
  )
  // .constrained(width: 400)
      .alignment(Alignment.center);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('styled_widget', style: GoogleFonts.satisfy(textStyle: _textStyle))
        // .rotate(angle: -0.1)
            .padding(right: 15),
        Image.asset('assets/logo.png', fit: BoxFit.fill,)
            .constrained(width: 40, height: 40),
      ],
    ).parent(_widgetStyle)
        .scale(all: 2);
  }
}