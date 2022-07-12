import 'package:flutter/material.dart';
import 'package:flutter_practice/animation/animateddecoratedbox.dart';
import 'package:flutter_practice/animation/animatedimagewidget.dart';
import 'package:flutter_practice/value/colorvalue.dart';

class AnimatedImplicitlyAnimatedWidget extends StatefulWidget {
  const AnimatedImplicitlyAnimatedWidget({Key? key, }) : super(key: key);

  @override
  _AnimatedImplicitlyAnimatedWidgetState createState() => _AnimatedImplicitlyAnimatedWidgetState();
}

class _AnimatedImplicitlyAnimatedWidgetState extends State<AnimatedImplicitlyAnimatedWidget> {

  double _left = 0.0;
  double _opacity = 1.0;
  double _padding = 10.0;
  double _height = 100.0;
  final Color _colorBlue = Colors.blue;
  final Color _colorPurpleAccent = Colors.purpleAccent;
  Color _decorationColor = Colors.green;
  Alignment _align = Alignment.topRight;
  TextStyle _style = const TextStyle(color: Colors.white, backgroundColor: Colors.purpleAccent, fontSize: 20);
  final Duration _duration1000 = const Duration(milliseconds: 1000);
  final EdgeInsetsGeometry _paddingTop = const EdgeInsets.only(top: 20);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Padding(
          padding: set.initEdgeInsets(15.0, 0.0, 15.0, 0.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    AnimatedDecoratedBox(
                      duration: _duration1000,
                      decoration: BoxDecoration(color: _decorationColor),
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              if(_decorationColor == Colors.purpleAccent){
                                _decorationColor = _colorBlue;
                              }else{
                                _decorationColor = Colors.purpleAccent;
                              }
                            });
                          },
                          child: set.initText2('AnimatedDecoratedBox', Colors.white, ColorValue.transParent, 20),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: _paddingTop,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if(_padding == 20){
                            _padding = 0;
                          }else {
                            _padding = 20;
                          }
                        });
                      },
                      child: AnimatedPadding(
                        duration: _duration1000,
                        padding: EdgeInsets.all(_padding),
                        child: set.initText2('AnimatedPadding', Colors.white, ColorValue.transParent, 20),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: _paddingTop,
                child: Container(
                  height: 100,
                  width: 200,
                  color: Colors.grey,
                  child: AnimatedAlign(
                    duration: _duration1000,
                    alignment: _align,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_align == Alignment.topCenter) {
                            _align = Alignment.center;
                          } else {
                            _align = Alignment.topCenter;
                          }
                        });
                      },
                      child: set.initText2('AnimatedAlign', Colors.white,
                          ColorValue.transParent, 20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: _paddingTop,
                child: AnimatedContainer(
                  duration: _duration1000,
                  height: _height,
                  color: _decorationColor,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        if(_height == 100){
                          _height = 150;
                          _decorationColor = _colorPurpleAccent;
                        }else{
                          _height = 100;
                          _decorationColor = _colorBlue;
                        }
                      });
                    },
                    child: set.initText2('AnimatedContainer', Colors.white, ColorValue.transParent, 20),
                  ),
                ),
              ),
              Padding(
                padding: _paddingTop,
                child: AnimatedDefaultTextStyle(
                  child: FlatButton(
                    height: 30,
                    child: Text('AnimatedDefaultTextStyle', style: _style,),
                    onPressed: () {
                      setState(() {
                        if(_style.backgroundColor == _colorPurpleAccent){
                          _style = const TextStyle(color: Colors.white, backgroundColor: Colors.blue, fontSize: 20);
                        }else{
                          _style = const TextStyle(color: Colors.white, backgroundColor: Colors.purpleAccent, fontSize: 20);
                        }
                      });
                    },
                  ),
                  style: _style,
                  duration: _duration1000,
                ),
              ),
              Padding(
                padding: _paddingTop,
                child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: _duration1000,
                  child: RaisedButton(
                    child: Text('AnimatedOpacity', style: _style,),
                    onPressed: () {
                      setState(() {
                        if(_opacity == 1.0){
                          _opacity = 0.5;
                        }else{
                          _opacity = 1.0;
                        }
                      });
                    },
                  ),
                ),
              ),
              Padding(
               padding: _paddingTop,
                child: SizedBox(
                  height: 50,
                  width: 300,
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        duration: _duration1000,
                        left: _left,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if(_left == 0){
                                _left = 100;
                              }else{
                                _left = 0;
                              }
                            });
                          },
                          child: set.initText2('AnimatedPositioned', Colors.white, ColorValue.transParent, 20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ].map((e) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: e,
        );
      }).toList(),
    );
  }
}