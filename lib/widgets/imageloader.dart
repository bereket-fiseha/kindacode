import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ImageLoader extends StatefulWidget {
  @override
  State<ImageLoader> createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader> {
  Widget build(BuildContext context) {
    List<int> li = [5, 6];
    li = li.map((x) => x).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("load image"),
      ),
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.purpleAccent)),
                  child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: "http://via.placeholder.com/250x150",
                      placeholder: (context, url) => Center(
                            child: SpinKitRipple(
                              color: Colors.white,
                              size: 80.0,
                            ),
                          ),
                      errorWidget: (context, url, error) => Icon(Icons.error)),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 50,
                  child: CachedNetworkImage(
                    fadeOutDuration: Duration(milliseconds: 1000),
                    fadeInDuration: Duration(milliseconds: 1000),
                    fit: BoxFit.fill,
                    imageUrl: "http://via.placeholdesr.com/350x150",
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: "http://via.placeholder.com/350x150",
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
