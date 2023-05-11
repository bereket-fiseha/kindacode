import 'package:flutter/material.dart';

class Sliders extends StatefulWidget {
  @override
  State<Sliders> createState() => _SlidersState();
}

class _SlidersState extends State<Sliders> {
  late PageController _pageController;
  int _currentPage = 0;
  initState() {
    _pageController = PageController();
  }

  List<Widget> listOfPages = [
    Container(
      width: double.infinity,
      color: Colors.amber,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Hello"),
        ],
      ),
    ),
    Container(
      width: double.infinity,
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Hi"),
        ],
      ),
    ),
    Container(
      width: double.infinity,
      color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Hello"),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
            controller: _pageController,
            children: listOfPages,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            }),
        Positioned(
          bottom: 20,
          left: 30,
          child: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            onPressed: () {
              _pageController.previousPage(
                  duration: Duration(milliseconds: 500), curve: Curves.easeIn);

              setState(() {
                _currentPage--;
              });
            },
            child: Icon(Icons.arrow_left),
          ),
        ),
        Positioned(
            bottom: 30,
            left: MediaQuery.of(context).size.width / 2.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: _currentPage == 0 ? Colors.black45 : Colors.white,
                      shape: BoxShape.circle),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: _currentPage == 1 ? Colors.black45 : Colors.white,
                      shape: BoxShape.circle),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: _currentPage == 2 ? Colors.black45 : Colors.white,
                      shape: BoxShape.circle),
                )
              ],
            )),
        Positioned(
            bottom: 20,
            right: 30,
            child: Row(
              children: [
                FloatingActionButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () {
                      _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn);

                      setState(() {
                        _currentPage++;
                      });
                    },
                    child: _currentPage == listOfPages.length - 1
                        ? Icon(Icons.done)
                        : Icon(Icons.arrow_right)),
              ],
            )),
      ],
    ));
  }
}
