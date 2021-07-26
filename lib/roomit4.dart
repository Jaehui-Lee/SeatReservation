import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'arc.dart';

class RoomIT4 extends StatefulWidget {
  String? _id;

  RoomIT4(this._id);
  @override
  _RoomIT4State createState() => _RoomIT4State();
}

class _RoomIT4State extends State<RoomIT4> {
  int total = 40;
  int reserved = 0;

  @override
  Widget build(BuildContext context) {
    DocumentReference<Map<String, dynamic>> info =
        FirebaseFirestore.instance.collection('rooms').doc('it4-108');
    return FutureBuilder<DocumentSnapshot>(
        future: info.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            reserved = data['reserved'];
            total = data['total'];
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
                  Arc(widget._id, "IT4", reserved, total,
                      100 * (total - reserved) / total),
                ],
              )),
            );
          }
          return Container(
            child: Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 50.0,
                width: 50.0,
              ),
            ),
          );
        });
  }
}
