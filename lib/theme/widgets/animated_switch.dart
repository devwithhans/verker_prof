import 'package:flutter/material.dart';

class AnimatedSwitch extends StatefulWidget {
  const AnimatedSwitch({
    required this.value,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final Function() onPressed;
  final bool value;

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
                  color: widget.value
                      ? const Color(0xff40C0A7)
                      : const Color(0xffE8E6E9),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
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
                duration: const Duration(milliseconds: 500),
                child: Container(
                  margin: const EdgeInsets.all(2.5),
                  width: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
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
