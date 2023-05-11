import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BorderedIcon extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 5),
          shape: BoxShape.circle,
          color: Colors.amber),
      child: IconButton(
        iconSize: 200,
        icon: Icon(Icons.play_arrow),
        onPressed: () {},
      ),
    );
  }
}
