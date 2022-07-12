import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_practice/color/pickers/blockpickerexample.dart';
import 'package:flutter_practice/color/pickers/hsvpickerexample.dart';
import 'package:flutter_practice/color/pickers/materialpickerexample.dart';

class ColorPickerDemo extends StatefulWidget {
  const ColorPickerDemo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ColorPickerDemoState();
}

class _ColorPickerDemoState extends State<ColorPickerDemo> {
  bool lightTheme = true;
  Color currentColor = Colors.amber;
  List<Color> currentColors = [Colors.yellow, Colors.green];
  List<Color> colorHistory = [];

  void changeColor(Color color) => setState(() => currentColor = color);
  void changeColors(List<Color> colors) => setState(() => currentColors = colors);

  @override
  Widget build(BuildContext context) {
    final foregroundColor = useWhiteForeground(currentColor) ? Colors.white : Colors.black;
    return AnimatedTheme(
      data: lightTheme ? ThemeData.light() : ThemeData.dark(),
      child: Builder(builder: (context) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => setState(() => lightTheme = !lightTheme),
              icon: Icon(lightTheme ? Icons.dark_mode_rounded : Icons.light_mode_rounded),
              label: Text(lightTheme ? 'Night' : '  Day '),
              backgroundColor: currentColor,
              foregroundColor: foregroundColor,
              elevation: 15,
            ),
            appBar: AppBar(
              title: const Text('FortySeven Page'),
              backgroundColor: currentColor,
              foregroundColor: foregroundColor,
              bottom: TabBar(
                labelColor: foregroundColor,
                tabs: const <Widget>[
                  Tab(text: 'HSV/HSL/RGB'),
                  Tab(text: 'Material'),
                  Tab(text: 'Block'),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                HSVColorPickerExample(
                  pickerColor: currentColor,
                  onColorChanged: changeColor,
                  colorHistory: colorHistory,
                  onHistoryChanged: (List<Color> colors) => colorHistory = colors,
                ),
                MaterialColorPickerExample(pickerColor: currentColor, onColorChanged: changeColor),
                BlockColorPickerExample(
                  pickerColor: currentColor,
                  onColorChanged: changeColor,
                  pickerColors: currentColors,
                  onColorsChanged: changeColors,
                  colorHistory: colorHistory,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}