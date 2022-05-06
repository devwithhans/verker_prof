import 'package:flutter/material.dart';

class SwipeToConfirm extends StatefulWidget {
  const SwipeToConfirm({
    required this.onConfirmed,
    this.icon,
    this.title,
    this.height = 70,
    this.width = 300,
    Key? key,
  }) : super(key: key);

  final double height;
  final double width;
  final Widget? title;
  final Widget? icon;
  final void Function() onConfirmed;

  @override
  State<SwipeToConfirm> createState() => _SwipeToConfirmState();
}

class _SwipeToConfirmState extends State<SwipeToConfirm> {
  double _position = 0;
  int _duration = 0;

  void updatePosition(details) {
    if (details is DragEndDetails) {
      setState(() {
        _duration = 200;
        _position = 0;
      });
    } else if (details is DragUpdateDetails) {
      setState(() {
        _duration = 0;
        _position = details.localPosition.dx - (widget.height / 2);
      });
    }
  }

  double getOpasity() {
    double opacity = ((widget.width - _position) / widget.width);
    if (opacity >= 0.0 && opacity <= 1.0) {
      return opacity;
    } else if (opacity <= 0.0) {
      return 0;
    } else {
      return 1;
    }
  }

  double getPosition() {
    if (_position < 0) {
      return 0;
    } else if (_position > widget.width - (widget.height / 2)) {
      return widget.width - (widget.height / 2);
    } else {
      return _position;
    }
  }

  void sliderReleased(details) {
    if (_position > widget.width - (widget.height / 2)) {
      widget.onConfirmed();
    }
    updatePosition(details);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeOut,
      duration: Duration(milliseconds: _duration),
      margin: EdgeInsets.only(left: getPosition()),
      height: widget.height,
      child: Stack(
        children: [
          Container(
            height: widget.height,
            decoration: BoxDecoration(
              color: const Color(0xff40C0A7),
              borderRadius: BorderRadius.circular(100),
            ),
            child: AnimatedOpacity(
              opacity: getOpasity() < 0.6 ? 0 : 1,
              duration: const Duration(milliseconds: 80),
              child: Center(
                child: widget.title,
              ),
            ),
          ),
          GestureDetector(
            onPanStart: (details) {
              // updatePosition(details);
            },
            onPanUpdate: (details) {
              updatePosition(details);
            },
            onPanEnd: (details) {
              sliderReleased(details);
            },
            child: Container(
              margin: const EdgeInsets.all(2.5),
              width: widget.height - 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                // borderRadius: BorderRadius.circular(100),
                color: Colors.white,
              ),
              child: Center(child: widget.icon),
            ),
          ),
        ],
      ),
    );
  }
}
