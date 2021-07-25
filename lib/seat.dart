import 'package:flutter/material.dart';

class Seat extends StatelessWidget {
  int? state;
  int? seatNumber;

  Seat(this.state, this.seatNumber);

  @override
  Widget build(BuildContext context) {
    // no seat
    if (state == -1) {
      return Container(
        width: 60,
        height: 40,
        color: Colors.transparent,
      );
    }
    // not reserved seat
    else if (state == 0) {
      return Container(
        width: 60,
        height: 40,
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                primary: Colors.amber,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                side: const BorderSide(color: Colors.transparent)),
            child: Text(
              '$seatNumber',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              _showDialog(context);
            },
          ),
        ),
      );
    }
    // reserved seat
    else if (state == 1) {
      return Container(
        width: 60,
        height: 40,
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                primary: Colors.black38,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                side: const BorderSide(color: Colors.transparent)),
            child: Text(
              '$seatNumber',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          ),
        ),
      );
    }
    // impossible seat
    else {
      return Container(
        width: 60,
        height: 40,
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                primary: Color(0x1F000000),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                side: const BorderSide(color: Colors.transparent)),
            child: Text(
              '$seatNumber',
              style: TextStyle(color: Colors.black38),
            ),
            onPressed: () {},
          ),
        ),
      );
    }
  }

  void _showDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Alert Dialog title"),
          content: const Text("Alert Dialog body"),
          actions: [
            FlatButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
