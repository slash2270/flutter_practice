import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_practice/animation/fadescaletransitiondemo.dart';
import 'package:flutter_practice/animation/fadethroughtransitiondemo.dart';
import 'package:flutter_practice/animation/opencontainertransformdemo.dart';
import 'package:flutter_practice/animation/sharedaxistransitiondemo.dart';
import 'package:flutter_practice/set.dart';

class AnimationsWidget extends StatefulWidget {
  @override
  _AnimationsWidgetState createState() => _AnimationsWidgetState();
}

class _AnimationsWidgetState extends State<AnimationsWidget> {
  bool _slowAnimations = false;
  late Set _set;
  late Square _square;

  @override
  void initState() {
    print('ThirtyTwo initState');
    _set = Set();
    _square = Square();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                _set.initSizedBox(20.0),
                _set.initText2('Animations', Colors.black, Colors.transparent, 24),
                _TransitionListTile(
                  title: '容器變換',
                  subtitle: 'OpenContainer',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return OpenContainerTransformDemo();
                        },
                      ),
                    );
                  },
                ),
                _TransitionListTile(
                  title: '共享軸',
                  subtitle: 'SharedAxisTransition',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return SharedAxisTransitionDemo();
                        },
                      ),
                    );
                  },
                ),
                _TransitionListTile(
                  title: '淡出',
                  subtitle: 'FadeThroughTransition',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return FadeThroughTransitionDemo();
                        },
                      ),
                    );
                  },
                ),
                _TransitionListTile(
                  title: '褪色',
                  subtitle: 'FadeScaleTransition',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return const FadeScaleTransitionDemo();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 2.0),
          SafeArea(
            child: SwitchListTile(
              value: _slowAnimations,
              onChanged: (bool value) async {
                setState(() {
                  _slowAnimations = value;
                });
                // Wait until the Switch is done animating before actually slowing
                // down time.
                if (_slowAnimations) {
                  await Future<void>.delayed(const Duration(milliseconds: 300));
                }
                timeDilation = _slowAnimations ? 10.0 : 1.0;
              },
              title: const Text('Slow animations'),
            ),
          ),
          _set.initSizedBox(20.0),
          _set.initText2('AnimateDo', Colors.black, Colors.transparent, 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FadeInLeft(child: _square ),
              FadeInUp(child: _square ),
              FadeInDown(child: _square ),
              FadeInRight(child: _square ),
            ],
          ),
        ],
    );
  }
}

class _TransitionListTile extends StatelessWidget {
  const _TransitionListTile({
    this.onTap,
    required this.title,
    required this.subtitle,
  });
  final GestureTapCallback? onTap;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      leading: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.black54,
          ),
        ),
        child: const Icon(
          Icons.play_arrow,
          size: 35,
        ),
      ),
      onTap: onTap,
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}

class Square extends StatelessWidget {
  const Square({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.blueAccent,
    );
  }
}