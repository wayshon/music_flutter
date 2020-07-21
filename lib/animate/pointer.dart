import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class AnimatePointer extends AnimatedWidget {
  AnimatePointer({Key key, Animation animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container(
      color: Colors.red,
      child: Transform(
        alignment: Alignment.topCenter,
        transform: Matrix4.rotationZ(animation.value),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage("assets/images/play_needle.png"),
            ),
          ),
        ),
      ),
    );
  }
}

class Pointer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new PointerState();
}

class PointerState extends State<Pointer> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 10), vsync: this);
    animation = Tween(begin: -pi / 2, end: 0.0).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // return AnimatePointer(
    //   animation: animation,
    // );

    return Container(
      color: Colors.red,
      child: Transform(
        alignment: Alignment.topCenter,
        transform: Matrix4.rotationZ(0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage("assets/images/play_needle.png"),
            ),
          ),
        ),
      ),
    );
  }

  @override
  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}
