import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChipScreen extends StatefulWidget {
  @override
  State<ChipScreen> createState() => _ChipScreenState();
}

class _ChipScreenState extends State<ChipScreen> {
  List<CustomIcon> listOfCustomIcons = [];
  TextEditingController textEditingController = new TextEditingController();
  void remIcon(String title) {
    debugPrint(title);
    debugPrint(listOfCustomIcons
        .where((element) => element.title == title)
        .first
        .title);
    listOfCustomIcons.remove(
        listOfCustomIcons.where((element) => element.title == title).first);
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Enter Text"),
          actions: <Widget>[
            TextField(
              controller: textEditingController,
              maxLines: 1,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter some text here...'),
              onChanged: (String newText) {
                // setState(() {
                //   text = newText;
                // });
              },
            ),
            new OutlinedButton(
              child: new Text("OK"),
              onPressed: () {
                listOfCustomIcons.add(CustomIcon(
                  title: textEditingController.text,
                  removeIcon: remIcon,
                ));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chip Simulation"),
        ),
        body: GridView.count(
          crossAxisCount: 3,
          children: listOfCustomIcons,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {_showDialog(context)},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  String title;
  Function(String title) removeIcon;
  CustomIcon({required this.title, required this.removeIcon});
  Widget build(BuildContext context) {
    var widthOfScreen = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: widthOfScreen / 3,
        child: Row(
          children: [
            Text(title),
            IconButton(
                onPressed: () => removeIcon(title), icon: Icon(Icons.cancel))
          ],
        ),
      ),
    );
  }
}
