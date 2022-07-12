import 'package:flutter/material.dart';

import 'accuratesizedbox.dart';

class AccurateSizedBoxWidget extends StatefulWidget {
  const AccurateSizedBoxWidget({Key? key}) : super(key: key);

  @override
  State<AccurateSizedBoxWidget> createState() => AccurateSizedBoxWidgetState();
}

class AccurateSizedBoxWidgetState extends State<AccurateSizedBoxWidget> {

  late Widget child;
  double _width = 50, _height = 50;
  final size = const Size(100, 100);

  @override
  Widget build(BuildContext context) {
    child = GestureDetector(
      onTap: () {
        setState(() {
          if(_width == 50 && _height == 50){
            _width = 25;
            _height = 25;
          }else{
            _width = 50;
            _height = 50;
          }
        });
      },
      child: Container(width: 300, height: 300, color: Colors.green),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints.tight(size),
          child: SizedBox(
            width: _width,
            height: _height,
            child: child,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(size),
            child: AccurateSizedBox(
              width: _width,
              height: _height,
              child: child,
            ),
          ),
        ),
      ],
    );
  }

}