import 'package:flutter/material.dart';

class OutputBox {
  String textOutput;
  int numberOutput;

  OutputBox(String prompt, int number) {
    textOutput = prompt;
    numberOutput = number;
  
  }

  Widget label(BuildContext context) {
    return Expanded(
      child: Container(
          height: 250,
          decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor)),
          child: Column(
            children: [
              Text(
                '$textOutput',
                textScaleFactor: 1.6,
              ),
              Container(
                margin: EdgeInsets.only(top: 75),
                child: Text(
                  '$numberOutput',
                  textScaleFactor: 3,
                ),
              )
            ],
          )),
    );
  }
}

class DatePickerButton {
  String prompt;
  void Function() event;

  DatePickerButton(String output, void Function() process) {
    prompt = output;
    event = process;
  }

  Widget datePickerPrompt(BuildContext context) {
    return Container(
        child: TextButton(
            onPressed: event,
            child: Container(
                child: Text(
              '$prompt',
              style: TextStyle(color: Colors.blue),
              textScaleFactor: 1.5,
            ))));
  }
}

class TotalValues {
  String prompt;
  int number;

  TotalValues(String output, int value) {
    prompt = output;
    number = value;
  }
  Widget totalData(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Container(
            child: Text(
          "$prompt",
          textScaleFactor: 1.5,
        )),
        Container(
          child: Text(
            "$number",
            textScaleFactor: 2,
          ),
        )
      ],
    ));
  }
}
