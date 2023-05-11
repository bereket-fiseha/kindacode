import 'package:flutter/material.dart';

class DateRangePicker extends StatefulWidget {
  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  var date = "";
  void datePicker(BuildContext context) async {
    var datePicked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022, 1, 1),
        lastDate: DateTime(2040, 1, 1));
    setState(() {
      date = datePicked.toString();
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Date Range Picker")),
        body: Center(
            child: Container(
          width: 100,
          height: 100,
          child: Text("selected date- $date"),
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(10)),
        )),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.date_range),
          onPressed: () {
            datePicker(context);
          },
        ),
      ),
    );
  }
}
