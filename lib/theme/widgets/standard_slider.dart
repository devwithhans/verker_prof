import 'package:flutter/material.dart';

class StandardSlider extends StatefulWidget {
  const StandardSlider({
    required this.initialValue,
    required this.max,
    required this.min,
    required this.onChanged,
    required this.title,
    Key? key,
  }) : super(key: key);

  final double min;
  final double max;
  final double initialValue;
  final void Function(double value) onChanged;
  final String title;

  @override
  State<StandardSlider> createState() => _StandardSliderState();
}

class _StandardSliderState extends State<StandardSlider> {
  late double _value;
  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              '${_value.toInt()} Km',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Slider(
          thumbColor: Colors.black,
          activeColor: Colors.black,
          inactiveColor: Colors.grey,
          label: 'Km',
          value: _value,
          min: 10,
          max: 500,
          onChanged: (v) {
            _value = v;
            setState(() {
              widget.onChanged(v);
            });
          },
        ),
      ],
    );
  }
}
