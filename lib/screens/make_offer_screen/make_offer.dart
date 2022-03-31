import 'package:flutter/material.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';

class MakeOffer extends StatelessWidget {
  const MakeOffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        actions: [],
        titleSpacing: 5,
        title: Text(
          'Lav tilbud',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(
              'Lav et udførligt tilbud til kunden',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Beskrivelse',
                  style: kTextSmallBold,
                ),
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: null,
                  onChanged: (v) {},
                  validator: (v) {},
                  cursorColor: Colors.black,
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintMaxLines: 20,
                    hintText: 'Beskriv hvad dit tilbud indbefatter',
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: outreachFormField(
                      title: 'Timer',
                      onChanged: (v) {},
                      validator: (v) {},
                      hintText: 'Antal timer',
                      number: true),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: outreachFormField(
                      title: 'Timepris',
                      onChanged: (v) {},
                      validator: (v) {},
                      hintText: 'Timepris',
                      price: true,
                      number: true),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Materialer',
                  style: kTextSmallBold,
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       flex: 4,
                //       child: outreachFormField(
                //         onChanged: (v) {},
                //         validator: (v) {},
                //         hintText: 'Materiale',
                //       ),
                //     ),
                //     SizedBox(width: 10),
                //     Expanded(
                //       flex: 3,
                //       child: outreachFormField(
                //         price: true,
                //         number: true,
                //         onChanged: (v) {},
                //         validator: (v) {},
                //         hintText: 'Pris',
                //       ),
                //     ),
                //     SizedBox(width: 10),
                //     Expanded(
                //       flex: 2,
                //       child: outreachFormField(
                //         number: true,
                //         onChanged: (v) {},
                //         validator: (v) {},
                //         hintText: 'Stk',
                //       ),
                //     ),
                //   ],
                // ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context, builder: (context) => Container());
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Row(
                      children: [
                        Icon(Icons.add_circle_outline_rounded),
                        Text('Tilføj materiale')
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Column outreachFormField({
    required Function(String value) onChanged,
    required String? Function(String? value) validator,
    Widget? customFormfield,
    String hintText = '',
    String title = '',
    bool price = false,
    bool number = false,
    bool multiline = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.isEmpty ? SizedBox() : SizedBox(height: 20),
        title.isEmpty
            ? SizedBox()
            : Text(
                title,
                style: kTextSmallBold,
              ),
        TextFormField(
          autofocus: true,
          keyboardType: price || number
              ? TextInputType.numberWithOptions(decimal: true)
              : multiline
                  ? TextInputType.multiline
                  : null,
          textCapitalization: TextCapitalization.sentences,
          maxLines: null,
          onChanged: onChanged,
          validator: validator,
          cursorColor: Colors.black,
          style: const TextStyle(fontSize: 18),
          decoration: InputDecoration(
            suffix: price ? const Text('DKK') : null,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            hintMaxLines: 20,
            hintText: hintText,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
