import 'package:flutter/material.dart';
import 'package:flutter_practice/view/twenty.dart';

class AnimationHero extends StatelessWidget {
  const AnimationHero({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          InkWell(
            child: Hero(
              tag: "ellen", //唯一标记，前后两个路由页Hero的tag必须相同
              child: ClipOval(
                child: Image.asset(
                  "images/ellen.jpeg",
                  width: 80.0,
                ),
              ),
            ),
            onTap: () {
              //打开B路由
              Navigator.push(context, PageRouteBuilder(
                pageBuilder: (BuildContext context, animation, secondaryAnimation,) {
                  return FadeTransition(
                    opacity: animation,
                    child: const Twenty(),
                  );
                },
              ));
            },
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text("點擊頭像"),
          )
        ],
      ),
    );
  }
}