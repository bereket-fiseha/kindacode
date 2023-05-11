import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconPicker extends StatefulWidget {
  @override
  State<IconPicker> createState() => _IconPickerState();
}

class _IconPickerState extends State<IconPicker> {
  late IconData _selectedIcon;
  late Color _selectedColor;
  int _selectedSize = 50;
  @override
  void initState() {
    // TODO: implement initState

    _selectedIcon = listOfIcons[0];
    _selectedColor = listOfColors[0];
  }

  dynamic showIconsModal(BuildContext context) async {
    debugPrint(listOfIcons.indexOf(_selectedIcon).toString());
    int iconIndex = 0;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Container(
                height: 500,
                width: 500,
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 3,
                        children: List.generate(
                            listOfIcons.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () => {
                                      setState(() {
                                        _selectedIcon = listOfIcons[index];
                                        iconIndex = index;
                                      })
                                    },
                                    child: Card(
                                      color: Color.fromARGB(255, 239, 237, 216),
                                      child: CircleAvatar(
                                        backgroundColor: index ==
                                                listOfIcons
                                                    .indexOf(_selectedIcon)
                                            ? Colors.yellow
                                            : Color.fromARGB(
                                                255, 211, 237, 181),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            listOfIcons[index],
                                            size: 25,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, iconIndex);
                        },
                        child: Text("choose"))
                  ],
                ))));
    return iconIndex;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Icon Picker"),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Select Icon"),
                      IconButton(
                        onPressed: () async {
                          var index = await showIconsModal(context);
                          debugPrint(index.toString());
                          setState(() {
                            _selectedIcon = listOfIcons[index];
                          });
                        },
                        icon: Icon(FontAwesomeIcons.icons),
                      ),
                      Icon(_selectedIcon),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Select Color"),
                    SizedBox(
                      width: 10,
                    ),
                    DropdownButton(
                        items: List.generate(
                            listOfColors.length,
                            (index) => DropdownMenuItem(
                                value: index,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    color: listOfColors[index],
                                    height: 20,
                                    width: 80,
                                  ),
                                ))),
                        onChanged: (val) {
                          setState(() {
                            _selectedColor = listOfColors[val!];
                          });
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    Container(width: 20, height: 20, color: _selectedColor),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Select Size"),
                    SizedBox(
                      width: 10,
                    ),
                    DropdownButton(
                        items: List.generate(
                            listOfSizes.length,
                            (index) => DropdownMenuItem(
                                value: index,
                                child: SizedBox(
                                  width: 100,
                                  child: Text(listOfSizes[index].toString()),
                                ))),
                        onChanged: (val) {
                          setState(() {
                            _selectedSize = listOfSizes[val!];
                          });
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    Text("$_selectedSize"),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Card(
                    shape: RoundedRectangleBorder(),
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: Icon(
                        _selectedIcon,
                        color: _selectedColor,
                        size: _selectedSize.toDouble(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<int> listOfSizes = [80, 85, 95, 100, 105, 110, 125, 130, 145];
List<Color> listOfColors = [
  Colors.blue,
  Color.fromARGB(255, 67, 132, 185),
  Color.fromARGB(255, 128, 185, 232),
  Colors.green,
  Color.fromARGB(255, 144, 214, 146),
  Color.fromARGB(255, 167, 236, 169),
  Colors.red,
  Colors.black,
  Colors.white
];
List<IconData> listOfIcons = [
  Icons.favorite,
  Icons.umbrella,
  Icons.headphones,
  Icons.home,
  Icons.settings,
  Icons.piano,
  Icons.skateboarding,
  Icons.alarm,
  Icons.airplanemode_active,
  Icons.phone,
  Icons.music_note,
  Icons.sunny,
  Icons.shop,
  Icons.ice_skating,
  Icons.icecream,
  Icons.apartment,
  Icons.woo_commerce,
  Icons.waves,
  Icons.waterfall_chart,
  Icons.videogame_asset,
  Icons.architecture,
  Icons.accessible_sharp
];
