import 'package:flutter/material.dart';
import 'package:verker_prof/theme/fonts/icons.dart';

class AnimatedSwitch extends StatefulWidget {
  AnimatedSwitch({
    required this.value,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  Function() onPressed;
  bool value;

  @override
  State<AnimatedSwitch> createState() => _AnimatedSwitchState();
}

class _AnimatedSwitchState extends State<AnimatedSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      GestureDetector(
        onTap: widget.onPressed,
        child: SizedBox(
          width: 75,
          height: 35,
          child: Stack(
            children: [
              Container(
                width: 75,
                height: 35,
                decoration: BoxDecoration(
                  color: widget.value ? Color(0xff40C0A7) : Color(0xffE8E6E9),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Ja',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text('Nej', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              AnimatedAlign(
                curve: Curves.bounceOut,
                alignment:
                    widget.value ? Alignment.centerRight : Alignment.centerLeft,
                duration: Duration(milliseconds: 500),
                child: Container(
                  margin: EdgeInsets.all(2.5),
                  width: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    // borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
