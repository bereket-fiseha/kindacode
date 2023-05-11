// main.dart
import 'package:flutter/material.dart';

class ListWheelSample extends StatefulWidget {
  const ListWheelSample({Key? key}) : super(key: key);

  @override
  State<ListWheelSample> createState() => _ListWheelSampleState();
}

class _ListWheelSampleState extends State<ListWheelSample> {
  // list of photos to display (including urls and captions)
  final List<Map<String, dynamic>> _photos = [
    {
      "url":
          "https://www.kindacode.com/wp-content/uploads/2022/06/big-boss.jpeg",
      "caption": "Big Boss",
    },
    {
      "url":
          "https://www.kindacode.com/wp-content/uploads/2022/07/flower-1.jpeg",
      "caption": "Flower One"
    },
    {
      "url":
          "https://www.kindacode.com/wp-content/uploads/2022/07/flower-2.jpeg",
      "caption": "Flower Two"
    },
    {
      "url":
          "https://www.kindacode.com/wp-content/uploads/2022/07/flower-3.jpeg",
      "caption": "Flower Three"
    },
    {
      "url":
          "https://www.kindacode.com/wp-content/uploads/2022/07/flower-4.jpeg",
      "caption": "Flower Four"
    }
  ];

  Map<String, dynamic>? _selectedPhoto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KindaCode.com')),
      body: Column(
        children: [
          Container(
            height: 400,
            color: Colors.amber,
            alignment: Alignment.center,
            child: RotatedBox(
              quarterTurns: -45,
              // implement the ListWheelScrollView
              child: ListWheelScrollView(
                itemExtent: MediaQuery.of(context).size.width * 0.9,
                onSelectedItemChanged: (index) {
                  setState(() {
                    _selectedPhoto = _photos[index];
                  });
                },
                // use the _photos list as children
                children: _photos
                    .map((photo) => RotatedBox(
                          key: ValueKey(photo["url"]),
                          quarterTurns: 45,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              photo["url"],
                              width: double.infinity,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          // display the caption of the selected photo
          SizedBox(
            height: 120,
            child: Center(
              child: Text(
                _selectedPhoto == null
                    ? _photos[0]['caption']
                    : _selectedPhoto!['caption'],
                style: const TextStyle(fontSize: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
