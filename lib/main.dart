import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DateLabel(),
    );
  }
}

class DateLabel extends StatelessWidget {
  Widget startDate() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Text(
        "Start Date",
        textScaleFactor: 1.5,
      ),
    );
  }

  Widget endDate() {
    return Container(
      margin: EdgeInsets.only(left: 25),
      child: Text(
        "End Date",
        textScaleFactor: 1.5,
        textAlign: TextAlign.left,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [startDate(), endDate(), ResultsYears()],
      ),
    );
  }
}

class ResultsYears extends StatefulWidget {
  @override
  _ResultsYearsState createState() => _ResultsYearsState();
}

class _ResultsYearsState extends State<ResultsYears> {
  int years = 00;
  int months = 00;
  int days = 00;

  Widget yearLabel() {
    return Expanded(
        child: Container(
            height: 250,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Column(
              children: [
                Text(
                  "Years",
                  textScaleFactor: 1.6,
                ),
              ],
            )));
  }

  Widget monthLabel() {
    return Expanded(
        child: Container(
            height: 250,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Column(
              children: [
                Text(
                  "Months",
                  textScaleFactor: 1.6,
                ),
              ],
            )));
  }

  Widget dayLabel() {
    return Expanded(
        child: Container(
            height: 250,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Column(
              children: [
                Text(
                  "Days",
                  textScaleFactor: 1.6,
                )
              ],
            )));
  }

  DateTime btnDate = DateTime.now();
  String startDate;

  void datePicker() {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1900, 1, 1),
        maxTime: DateTime(2100, 12, 31), onChanged: (date) {
      setState(() {
        startDate = DateFormat.yMMMMd().format(date);
      });
    }, onConfirm: (date) {
      setState(() {
        startDate = DateFormat.yMMMMd().format(date);
      });
    });
  }

  Widget calculate() {
    return FlatButton(
        onPressed: datePicker,
        child: Text(
          '$startDate',
          style: TextStyle(color: Colors.blue),
        ));
  }

  Widget resultContainer() {
    return Container(
      margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Row(
        children: [yearLabel(), monthLabel(), dayLabel()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Column(children: [resultContainer(), calculate()]));
  }
}
