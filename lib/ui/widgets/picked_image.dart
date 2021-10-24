import 'dart:io';

import 'package:flutter/material.dart';

class PickedImage extends StatelessWidget {
  final File file;
  final Function() onPressed;
  PickedImage({@required this.file,@required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(50.0),
      child: Stack(
        children: [
          // ignore: sized_box_for_whitespace
          Container(
            height: 100.0,
            width: 100.0,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(70.0),
                child: Image.file(
                  file,
                  fit: BoxFit.cover,
                )),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            bottom: 0.0,
            right: 0.0,
            child: IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 40.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}