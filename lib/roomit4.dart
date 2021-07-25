import 'package:flutter/material.dart';

import 'arc.dart';

class RoomIT4 extends StatefulWidget {
  @override
  _RoomIT4State createState() => _RoomIT4State();
}

class _RoomIT4State extends State<RoomIT4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "108호",
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.black54,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Arc("IT4", 10, 40, 100 * (40 - 10) / 40),
        ],
      )),
    );
  }
}
