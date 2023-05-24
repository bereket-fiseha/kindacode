import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ChipScreen extends StatefulWidget {
  @override
  State<ChipScreen> createState() => _ChipScreenState();
}

class ChipData {
  // an id is useful when deleting chip
  final String id;
  final String name;
  ChipData({required this.id, required this.name});
}

class _ChipScreenState extends State<ChipScreen> {
  List<CustomIcon> _allChips = [];
  TextEditingController textEditingController = new TextEditingController();
  void remIcon(String id) {
    setState(() {
      _allChips.removeWhere((element) => element.title == id);
    });
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Enter Text"),
          content: TextField(
            controller: textEditingController,
          ),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _allChips.add(CustomIcon(
                        title: textEditingController.text,
                        id: textEditingController.text,
                        removeIcon: remIcon));
                  });

                  // reset the TextField
                  textEditingController.text = '';

                  // Close the dialog
                  Navigator.of(context).pop();
                },
                child: const Text('Submit'))
          ],
        );
      },
    );
  }

  void _deleteChip(String id) {
    setState(() {
      _allChips.removeWhere((element) => element.id == id);
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chip Simulation"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Wrap(
            spacing: 10,
            children: _allChips
                .map((chip) => CustomIcon(
                    title: chip.title,
                    id: chip.id,
                    removeIcon: chip.removeIcon))
                .toList(),
          ),
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
  String id;
  Function(String title) removeIcon;
  CustomIcon({required this.title, required this.id, required this.removeIcon});
  Widget build(BuildContext context) {
    var widthOfScreen = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.orange, borderRadius: BorderRadius.circular(15)),
        width: widthOfScreen / 4,
        height: 50,
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
