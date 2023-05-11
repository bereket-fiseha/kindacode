import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        //  elevation: 1,
        // title: Text("Test"),

        flexibleSpace: FlexibleSpaceBar(
          title: Text("aaa"),
          background: Container(
              decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.green.withOpacity(0.5),
                  Colors.yellow.withOpacity(0.7),
                  Colors.blue.withOpacity(0.7)
                ]),
          )),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
        backgroundColor: Colors.green.withOpacity(.6),
      ),
      body: Image.network(
        'https://www.kindacode.com/wp-content/uploads/2022/05/green.jpeg',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    ));
  }
}
