import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  initState() {
    _controller = TabController(length: 3, vsync: this);
  }

  List<Widget> listOfWidgets = [
    Container(
      color: Colors.red,
      child: Center(
          child: Icon(
        Icons.home,
        size: 25,
      )),
    ),
    Container(
        color: Colors.green,
        child: Center(
            child: Icon(
          Icons.shop,
          size: 25,
        ))),
    Container(
      color: Colors.yellow,
      child: Center(child: Icon(Icons.alarm)),
    )
  ];

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(""),
          bottom: TabBar(controller: _controller, tabs: const [
            Tab(
              icon: Icon(Icons.home),
            ),
            Tab(icon: Icon(Icons.shop)),
            Tab(icon: Icon(Icons.alarm))
          ]),
        ),
        body: SizedBox(
            child: Stack(children: [
          TabBarView(
            controller: _controller,
            children: listOfWidgets,
          ),
          Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Container(
                height: 30,
                alignment: Alignment.center,
                child: TabPageSelector(
                    controller: _controller,
                    indicatorSize: 25,
                    selectedColor: Colors.white,
                    color: Colors.grey),
              ))
        ])));
  }
}

class BorderedListView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ListTile(
              shape: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.amber),
                  borderRadius: BorderRadius.circular(10)),
              leading: Icon(Icons.alarm),
              title: Text("alarm"),
              trailing: Icon(Icons.airplanemode_active),
            ),
            ListTile(
              shape: StadiumBorder(
                  side: BorderSide(width: 2, color: Colors.amber)),
              leading: Icon(Icons.alarm),
              title: Text("alarm"),
              trailing: Icon(Icons.airplanemode_active),
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2, color: Colors.amber),
                  borderRadius: BorderRadius.circular(20)),
              leading: Icon(Icons.alarm),
              title: Text("alarm"),
              trailing: Icon(Icons.airplanemode_active),
            ),
          ],
        ));
  }
}
