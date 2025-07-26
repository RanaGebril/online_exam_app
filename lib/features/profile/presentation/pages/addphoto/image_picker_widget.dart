import 'package:flutter/material.dart';

class ImagePickerWidget extends StatefulWidget {
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHigh = MediaQuery.of(context).size.width;
    final double circleHigh = screenHigh * 0.3;
    final double circleWidth = screenWidth * 1;
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.red,
        ),
        Positioned(
          bottom: 1,
          right: 1,
          child: Container(
            height:40,
            width:40,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 0.1),
              color:  Colors.blueGrey
            ),
            child: IconButton(
              icon: Icon(Icons.add_a_photo, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
