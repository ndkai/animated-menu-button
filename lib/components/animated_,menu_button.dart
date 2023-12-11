import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedMenuButton extends StatefulWidget {
  final Widget homeWidget;
  //only accept 3 widgets
  final List<Widget> actionWidgets;
  final double radius;
  final Duration animatedDuration;
  const AnimatedMenuButton({super.key, required this.homeWidget, required this.actionWidgets, this.radius = 100, required this.animatedDuration});

  @override
  State<AnimatedMenuButton> createState() => _AnimatedMenuButtonState();
}

class _AnimatedMenuButtonState extends State<AnimatedMenuButton> with TickerProviderStateMixin{
  late AnimationController _item1Controller;
  late Animation<double> _item1animation;
  late AnimationController _item2Controller;
  late Animation<double> _item2Animation;
  late AnimationController _item3Controller;
  late Animation<double> _item3Animation;

  bool isOpen = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _item1Controller = AnimationController(vsync: this, duration: widget.animatedDuration);
    _item1animation = Tween<double>(begin: -pi, end: -pi * 0.2).animate(_item1Controller);


    _item2Controller = AnimationController(vsync: this, duration: widget.animatedDuration);
    _item2Animation = Tween<double>(begin: -pi, end: -pi/2).animate(_item2Controller);


    _item3Controller = AnimationController(vsync: this, duration: widget.animatedDuration);
    _item3Animation = Tween<double>(begin: -pi, end: -pi * 0.8).animate(_item3Controller);
    _item1Controller.addStatusListener((status) {
      if(status == AnimationStatus.completed){

      }
    });
  }

  @override
  void dispose() {
    _item1Controller.dispose();
    _item2Controller.dispose();
    _item3Controller.dispose();
    super.dispose();
  }

  Widget item(bool visible, Widget child){
    return Visibility(
        visible: visible,
        child: child);
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          InkWell(
            onTap: (){
              if(!isOpen){
                isOpen = !isOpen;
                _item1Controller.forward();
                _item2Controller.forward();
                _item3Controller.forward();
              } else {
                _item1Controller.reverse();
                _item2Controller.reverse();
                _item3Controller.reverse();
                Future.delayed(widget.animatedDuration, (){setState(() {
                  isOpen = !isOpen;
                });},);
              }



            },
            child: item(true, widget.homeWidget),
          ),
          AnimatedBuilder(
              animation: _item3Controller,
              builder: (context, child){
                var offset = getOffset(const Offset(0, 0),  _item3Animation.value);
                return Transform(
                  transform: Matrix4.identity()
                    ..translate(offset.dx, offset.dy
                    ),
                  child: item(isOpen, widget.actionWidgets[0]),
                );
              }
          ),
          AnimatedBuilder(
              animation: _item2Controller,
              builder: (context, child){
                var offset = getOffset(const Offset(0, 0), _item2Animation.value);
                return Transform(
                  transform: Matrix4.identity()
                    ..translate(offset.dx, offset.dy
                    ),
                  child: item(isOpen, widget.actionWidgets[1]),
                );
              }
          ),
          AnimatedBuilder(
              animation: _item1Controller,
              builder: (context, child){
                var offset = getOffset(const Offset(0, 0),_item1animation.value);
                return Transform(
                  transform: Matrix4.identity()
                    ..translate(offset.dx, offset.dy
                    ),
                  child: item(isOpen, widget.actionWidgets[2]),
                );
              }
          )
        ],
      ),
    );
  }

  Offset getOffset(Offset center, double angle){
    double x = center.dx + widget.radius * cos(angle);
    double y = center.dy + widget.radius * sin(angle);

    return Offset(x, y);
  }
}
