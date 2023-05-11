import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BorderedElevatedButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 4, color: Colors.deepPurple),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              child: Text("btn"),
              onPressed: () {},
            ),
          ),
        )));
  }
}
