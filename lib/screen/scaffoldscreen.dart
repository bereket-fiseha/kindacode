import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kindacode/widgets/borderedicon.dart';
import 'package:kindacode/widgets/imageloader.dart';

class ScaffoldScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("")),
      body: Center(
        child: ImageLoader(),
      ),
    );
  }
}
