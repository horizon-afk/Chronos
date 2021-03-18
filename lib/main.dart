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
      body: ResultsYears(),
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

  int total_days = 0;
  int total_hours = 0;

  Widget startDateInput() {
    return Container(
        margin: EdgeInsets.fromLTRB(25, 60, 10, 0),
        child: Row(children: [
          Container(
              margin: EdgeInsets.only(right: 50),
              child: Text(
                "Start Date",
                textScaleFactor: 1.5,
              )),
          startPicker(),
        ]));
  }

  Widget endDateInput() {
    return Container(
        margin: EdgeInsets.fromLTRB(25, 5, 10, 0),
        child: Row(children: [
          Container(
              margin: EdgeInsets.only(right: 60),
              child: Text(
                "End Date",
                textScaleFactor: 1.5,
              )),
          endPicker(),
        ]));
  }

  Widget inputField() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [startDateInput(), endDateInput()],
      ),
    );
  }

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
                Container(
                    margin: EdgeInsets.only(top: 75),
                    child: Text(
                      "$years",
                      textScaleFactor: 3,
                    ))
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
                Container(
                    margin: EdgeInsets.only(top: 75),
                    child: Text(
                      "$months",
                      textScaleFactor: 3,
                    ))
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
                ),
                Container(
                    margin: EdgeInsets.only(top: 75),
                    child: Text(
                      "$days",
                      textScaleFactor: 3,
                    ))
              ],
            )));
  }

  Widget totalDays() {
    return Container(
        child: Column(
      children: [
        Container(
            child: Text(
          "Total Days",
          textScaleFactor: 1.5,
          textAlign: TextAlign.left,
        )),
        Container(
          child: Text("$total_days", textScaleFactor: 2),
        )
      ],
    ));
  }

  Widget totalHours() {
    return Container(
        margin: EdgeInsets.only(left: 155),
        child: Column(
          children: [
            Container(
                child: Text(
              "Total Hours",
              textScaleFactor: 1.5,
              textAlign: TextAlign.right,
            )),
            Container(
              child: Text(
                "$total_hours",
                textScaleFactor: 2,
              ),
            )
          ],
        ));
  }

  Widget totalValues() {
    return Container(
      margin: EdgeInsets.only(left: 25, top: 10),
      child: Row(
        children: [totalDays(), totalHours()],
      ),
    );
  }

  DateTime currentDate = DateTime.now();
  DateTime startDate;
  DateTime endDate;

  String startDateLabel = "MMMM, DD, YYYY";
  String endDateLabel = "MMMM, DD, YYYY";

  void updateTotalDays() {
    Duration diffDays = endDate.difference(startDate);
    total_days = diffDays.inDays;
  }

  void updateTotalHours() {
    Duration diffHours = endDate.difference(startDate);
    total_hours = diffHours.inHours;
  }

  void startDatePicker() {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1900, 1, 1),
        maxTime: DateTime(2100, 12, 31), onChanged: (date) {
      setState(() {
        startDate = date;
        startDateLabel = DateFormat.yMMMMd().format(date);
        updateTotalDays();
        updateTotalHours();
      });
    }, onConfirm: (date) {
      setState(() {
        startDate = date;
        startDateLabel = DateFormat.yMMMMd().format(date);
        updateTotalDays();
        updateTotalHours();
      });
    });
  }

  void endDatePicker() {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1900, 1, 1),
        maxTime: DateTime(2100, 12, 31), onChanged: (date) {
      setState(() {
        endDate = date;
        endDateLabel = DateFormat.yMMMMd().format(date);
        updateTotalDays();
        updateTotalHours();
      });
    }, onConfirm: (date) {
      setState(() {
        endDate = date;
        endDateLabel = DateFormat.yMMMMd().format(date);
        updateTotalDays();
        updateTotalHours();
      });
    });
  }

  Widget startPicker() {
    return TextButton(
        onPressed: startDatePicker,
        child: Container(
            width: 200,
            child: Text(
              '$startDateLabel',
              style: TextStyle(color: Colors.blue),
              textScaleFactor: 1.5,
              textAlign: TextAlign.right,
            )));
  }

  Widget endPicker() {
    return TextButton(
        onPressed: endDatePicker,
        child: Container(
            width: 200,
            child: Text(
              '$endDateLabel',
              style: TextStyle(color: Colors.blue),
              textScaleFactor: 1.5,
              textAlign: TextAlign.right,
            )));
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
    return Container(
        child: Column(children: [
      startDateInput(),
      endDateInput(),
      resultContainer(),
      totalValues()
    ]));
  }
}
