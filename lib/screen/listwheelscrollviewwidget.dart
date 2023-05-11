import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListWheelScrollViewWidget extends StatefulWidget {
  @override
  State<ListWheelScrollViewWidget> createState() =>
      _ListWheelScrollViewWidgetState();
}

class _ListWheelScrollViewWidgetState extends State<ListWheelScrollViewWidget> {
  int _selectedIndex = 0;
  List<String> items = [
    "cake",
    "fruit",
    "car",
    "alarm",
    "bike",
    "moto",
    "skate board",
    "pool",
    "bus",
    "train",
    "dox",
    "tyx",
    "ffh"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List Wheel SCroll View"),
        ),
        body: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.lightBlue,
              child: Center(
                  child: Text(items[_selectedIndex],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontFamily: 'Bobbers'))),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: ListWheelScrollView(
                    diameterRatio: 1,
                    onSelectedItemChanged: (value) => {
                          setState(() {
                            _selectedIndex = value;
                          })
                        },
                    itemExtent: 100,
                    children: items
                        .map((item) => Container(
                              width: double.infinity,
                              child: Card(
                                  color: _selectedIndex == items.indexOf(item)
                                      ? Colors.green
                                      : Colors.amber,
                                  child: Center(
                                      child: Text(
                                    item,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ))),
                            ))
                        .toList()),
              ),
            ),
          ],
        ));
  }
}
