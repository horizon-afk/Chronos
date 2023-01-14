import 'package:flutter/material.dart';
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
      title: 'Chronos',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.black,
      ),
      darkTheme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.black,
          brightness: Brightness.dark,
          primaryColor: Colors.white),
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

  // the start label
  Widget startDateInput() {
    return Container(
        margin: EdgeInsets.fromLTRB(25, 60, 17, 0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              child: Text(
            "Start Date",
            textScaleFactor: 1.5,
          )),
          startPicker(),
        ]));
  }

  //the end label
  Widget endDateInput() {
    return Container(
        margin: EdgeInsets.fromLTRB(25, 5, 17, 0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              child: Text(
            "End Date",
            textScaleFactor: 1.5,
          )),
          endPicker(),
        ]));
  }

  // the top two coloumn containing labels and idate picker
  Widget inputField() {
    return Container(
      margin: EdgeInsets.only(top: 100),
      child: Column(
        children: [startDateInput(), endDateInput()],
      ),
    );
  }

  // the left part of middle box containing year with the output
  Widget yearLabel() {
    return Expanded(
        child: Container(
            height: 250,
            decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor)),
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

  // the middle part of middle box containing month with the output
  Widget monthLabel() {
    return Expanded(
        child: Container(
            height: 250,
            decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor)),
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

  // the right part of middle box containing days with the output
  Widget dayLabel() {
    return Expanded(
        child: Container(
            height: 250,
            decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor)),
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

  // this label shows the total number of days including the days in years and months
  Widget totalDays() {
    return Container(
        child: Column(
      children: [
        Container(child: Text("Total Days", textScaleFactor: 1.5)),
        Container(
          child: Text("$total_days", textScaleFactor: 2),
        )
      ],
    ));
  }

  // this label shows the total number of hours including the hours in years and months
  Widget totalHours() {
    return Container(
        child: Column(
      children: [
        Container(
            child: Text(
          "Total Hours",
          textScaleFactor: 1.5,
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

  // the bottom row which shows the total days and total hours
  Widget totalValues() {
    return Container(
      margin: EdgeInsets.only(left: 25, top: 10, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [totalDays(), totalHours()],
      ),
    );
  }

  DateTime startDate;
  DateTime endDate;

  // this is shown as a string so as to print the button from displaying null
  String startDateLabel = "MMMM, DD, YYYY";
  String endDateLabel = "MMMM, DD, YYYY";

  //the function which converts total number of days to years, months and days
  void updateYYMMDD(int totalDays) {
    if (totalDays < 30) {
      days = totalDays;
      months = 0;
      years = 0;
    } else if (totalDays < 365) {
      months = totalDays ~/ 30;
      days = totalDays % 30;
      years = 0;
    } else {
      years = totalDays ~/ 365;
      int remainingDays = totalDays % 365;
      months = remainingDays ~/ 30;
      days = remainingDays % 30;
    }
  }

  // processes start date and end date and converts them to total days
  void updateTotalDays() {
    if (startDate != null && endDate != null) {
      Duration diffDays = endDate.difference(startDate);
      total_days = diffDays.inDays;
    }
  }

  // processes start date and end date and converts them to total hours
  void updateTotalHours() {
    if (startDate != null && endDate != null) {
      Duration diffHours = endDate.difference(startDate);
      total_hours = diffHours.inHours;
    }
  }

  // the date picker which lets the user to pick dates(start date)

  void startDatePicker() {
    DatePickerTheme(backgroundColor: Theme.of(context).primaryColor);
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1900, 1, 1),
        maxTime: endDate,
        theme: DatePickerTheme(
            backgroundColor: Theme.of(context).primaryColor == Colors.black ? Colors.white : Colors.black,
            itemStyle: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 18),
            doneStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
            cancelStyle: TextStyle(color: Colors.grey, fontSize: 16)), onChanged: (date) {
      setState(() {
        startDateLabel = DateFormat.yMMMMd().format(date);
        startDate = DateFormat("yMMMMd").parse(startDateLabel);
        updateTotalDays();
        updateTotalHours();
        updateYYMMDD(total_days);
      });
    }, onConfirm: (date) {
      setState(() {
        startDateLabel = DateFormat.yMMMMd().format(date);
        startDate = DateFormat("yMMMMd").parse(startDateLabel);

        updateTotalDays();
        updateTotalHours();
        updateYYMMDD(total_days);
      });
    });
  }

  // the date picker which lets the user pick dates(end date)
  void endDatePicker() {
    DatePickerTheme(backgroundColor: Theme.of(context).primaryColor);
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: startDate,
        maxTime: DateTime(2100, 12, 31),
        theme: DatePickerTheme(
            backgroundColor: Theme.of(context).primaryColor == Colors.black ? Colors.white : Colors.black,
            itemStyle: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 18),
            doneStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
            cancelStyle: TextStyle(color: Colors.grey, fontSize: 16)), onChanged: (date) {
      setState(() {
        endDateLabel = DateFormat.yMMMMd().format(date);
        endDate = DateFormat("yMMMMd").parse(endDateLabel);

        updateTotalDays();
        updateTotalHours();
        updateYYMMDD(total_days);
      });
    }, onConfirm: (date) {
      setState(() {
        endDateLabel = DateFormat.yMMMMd().format(date);
        endDate = DateFormat("yMMMMd").parse(endDateLabel);

        updateTotalDays();
        updateTotalHours();
        updateYYMMDD(total_days);
      });
    });
  }

  // the button which opens the start date picker
  Widget startPicker() {
    return Container(
        child: TextButton(
            onPressed: startDatePicker,
            child: Container(
                child: Text(
              '$startDateLabel',
              style: TextStyle(color: Colors.blue),
              textScaleFactor: 1.5,
            ))));
  }

  // the button which opens the end date picker
  Widget endPicker() {
    return Container(
        child: TextButton(
            onPressed: endDatePicker,
            child: Container(
                child: Text(
              '$endDateLabel',
              style: TextStyle(color: Colors.blue),
              textScaleFactor: 1.5,
            ))));
  }

  // the main box which contains the years, months and days
  Widget resultContainer() {
    return Container(
      margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
      decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor)),
      child: Row(
        children: [yearLabel(), monthLabel(), dayLabel()],
      ),
    );
  }

  // the column of all widgets except the credits
  Widget app() {
    return Container(
        child: Column(children: [
      startDateInput(),
      endDateInput(),
      resultContainer(),
      totalValues(),
    ]));
  }

  // the credits widget shows the name of the developer at the botto
  Widget credits() {
    // gets the screen size
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;
    return Container(
        height: height / 10,
        width: width,
        color: Colors.blue[800],
        child: Center(
            child: Text(
          "© Umesh Kumar Sarkar",
          textScaleFactor: 1.5,
          style: TextStyle(
            color: Colors.white,
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [app(), credits()]));
  }
}
