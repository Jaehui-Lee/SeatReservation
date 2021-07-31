import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'arc.dart';

class Building extends StatefulWidget {
  String? _id;
  String? _building;

  Building(this._id, this._building);
  @override
  _BuildingState createState() => _BuildingState();
}

class _BuildingState extends State<Building> {
  List<int> total = List.filled(10, 0);
  List<int> reserved = List.filled(10, 0);

  @override
  Widget build(BuildContext context) {
    DocumentReference<Map<String, dynamic>> info =
        FirebaseFirestore.instance.collection('rooms').doc(widget._building);
    updateTotalAndReserved();
    return FutureBuilder<DocumentSnapshot>(
        future: info.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              body: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: getRoomList(),
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

  Future<void> updateTotalAndReserved() async {
    DocumentReference<Map<String, dynamic>> info =
        FirebaseFirestore.instance.collection('rooms').doc(widget._building);
    if (widget._building == 'it4') {
      return await info
          .collection('108')
          .doc('information')
          .get()
          .then((value) {
        total[0] = value['total'];
        reserved[0] = value['reserved'];
      });
    }
  }

  List<Widget> getRoomList() {
    updateTotalAndReserved();
    if (widget._building == 'it4') {
      return [
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
        Arc(widget._id, "it4", "108", reserved[0], total[0],
            100 * (total[0] - reserved[0]) / total[0])
      ];
    }

    return [];
  }
}
