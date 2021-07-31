import 'dart:ui';

import 'package:flutter/material.dart';

import 'IT4/room.dart';
import 'mypainter.dart';

class Arc extends StatelessWidget {
  String? _id;
  String? building;
  String? room;
  int? reserved;
  int? total;
  double percentage = 0.0;
  late AnimationController percentageAnimationController;

  Arc(this._id, this.building, this.room, this.reserved, this.total,
      this.percentage);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        child: CustomPaint(
          foregroundPainter: MyPainter(
              Colors.transparent, Colors.orangeAccent, percentage, 8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
                color: Colors.white,
                splashColor: Colors.blueAccent,
                shape: const CircleBorder(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${total! - reserved!}",
                      style: TextStyle(
                        fontSize: 27.0,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.black45,
                    ),
                    Text(
                      "${total!}",
                      style: TextStyle(fontSize: 18.0, color: Colors.black45),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Room(_id, building, room)));
                }),
          ),
        ),
      ),
    );
  }
}
