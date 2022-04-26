import 'package:flutter/material.dart';

class ImageInspect extends StatelessWidget {
  const ImageInspect({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          splashRadius: 20,
          focusColor: Colors.black,
          splashColor: Colors.black,
          highlightColor: Colors.black,
          icon: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(20)),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: InteractiveViewer(
        panEnabled: true, // Set it to false
        boundaryMargin: EdgeInsets.all(0),
        minScale: 1,
        maxScale: 4,
        child: Center(
          child: Image.network(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
