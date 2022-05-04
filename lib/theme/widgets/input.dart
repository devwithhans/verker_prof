import 'package:flutter/material.dart';

class Compliance extends StatefulWidget {
  final bool initialValue;
  final Function(bool v) onChange;
  final String? Function(bool? v) validator;
  final String text;
  final String errorText;
  final bool showError;

  Compliance({
    required this.validator,
    this.errorText = '',
    this.initialValue = false,
    required this.onChange,
    this.text = '',
    this.showError = false,
  });

  @override
  State<Compliance> createState() => _ComplianceState();
}

class _ComplianceState extends State<Compliance> {
  late bool termsAccept;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    termsAccept = widget.initialValue;
  }

  void _onChange(v) {
    widget.onChange(v);
  }

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      initialValue: termsAccept,
      validator: widget.validator,
      builder: (state) => GestureDetector(
        onTap: () {
          termsAccept = !termsAccept;

          state.setValue(termsAccept);
          _onChange(termsAccept);
          setState(() {});
        },
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Transform.scale(
                    scale: 1.3,
                    child: SizedBox(
                      height: 24.0,
                      width: 24.0,
                      child: Checkbox(
                        activeColor: Colors.black,
                        side: BorderSide(width: 1),
                        value: termsAccept,
                        splashRadius: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        onChanged: (v) {
                          termsAccept = !termsAccept;
                          state.setValue(termsAccept);
                          _onChange(termsAccept);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.text,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Visibility(
                visible: state.hasError,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    state.errorText ?? '',
                    style: TextStyle(color: Colors.red.shade700, fontSize: 13),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
