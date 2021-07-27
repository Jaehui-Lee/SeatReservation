import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../seat.dart';

class IT4_108 extends StatefulWidget {
  String? _id;

  IT4_108(this._id);
  @override
  State<IT4_108> createState() => _IT4_108State();
}

class _IT4_108State extends State<IT4_108> {
  CollectionReference<Map<String, dynamic>> fseats = FirebaseFirestore.instance
      .collection('rooms')
      .doc('it4-108')
      .collection('seats');
  List<Seat> seats = List.filled(40, Seat("", -1, -1, "", "", "", ""));

  Future<void> updateSeats() async {
    return await fseats.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        seats[data['seatNumber']] = Seat(
            'it4-108',
            data['seatNumber'],
            data['state'],
            data['id'],
            data['startTime'],
            data['endTime'],
            widget._id);
      });
    });
  }

  // void addSeats() {
  //   CollectionReference<Map<String, dynamic>> seats = FirebaseFirestore.instance
  //       .collection('rooms')
  //       .doc('it4-108')
  //       .collection('seats');
  //   for (int i = 2; i <= 39; i++) {
  //     seats.doc('seat$i').set({
  //       "seatNumber": i,
  //       "state": 0,
  //       "id": "",
  //       "startTime": "",
  //       "endTime": "",
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    updateSeats();
    return FutureBuilder<QuerySnapshot>(
        future: fseats.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            fseats.get().then((value) {
              // value.docs.forEach((element) {
              //   print(element.data()['seatNumber']);
              //   print(element.data()['state']);
              //   print(element.data()['id']);
              //   print(element.data()['startTime']);
              //   print(element.data()['endTime']);
              // });
            });
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.orangeAccent,
                title: Text(
                  "IT4-108호",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
              body: _body(context),
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

  Widget board(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 30.0,
      color: Colors.orangeAccent,
      child: Center(
        child: Text(
          "Board",
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget showState() {
    return Container(
      //width: double.infinity,
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 15,
            height: 15,
            color: Colors.amber,
          ),
          SizedBox(
            width: 5,
          ),
          Text("사용 가능"),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 15,
            height: 15,
            color: Colors.black38,
          ),
          SizedBox(
            width: 5,
          ),
          Text("사용중"),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 15,
            height: 15,
            color: Color(0x1F000000),
          ),
          SizedBox(
            width: 5,
          ),
          Text("사용 불가"),
        ],
      ),
    );
  }

  Widget _body(context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          children: [
            board(context),
            showState(),
            SizedBox(
              height: 10,
            ),
            Row(
              // Row1 seats
              children: [
                Seat('it4-108', -1, -1, "", "", "", ""),
                Seat('it4-108', -1, -1, "", "", "", ""),
                Seat('it4-108', -1, -1, "", "", "", ""),
                Seat('it4-108', -1, -1, "", "", "", ""),
                seats[1],
                seats[2],
                Seat('it4-108', -1, -1, "", "", "", ""),
                seats[3],
                seats[4],
                seats[5],
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              // Row2 seats
              children: [
                seats[6],
                seats[7],
                Seat('it4-108', -1, -1, "", "", "", ""),
                Seat('it4-108', -1, -1, "", "", "", ""),
                seats[8],
                seats[9],
                Seat('it4-108', -1, -1, "", "", "", ""),
                seats[10],
                seats[11],
                seats[12],
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              // Row3 seats
              children: [
                seats[13],
                seats[14],
                seats[15],
                Seat('it4-108', -1, -1, "", "", "", ""),
                seats[16],
                seats[17],
                Seat('it4-108', -1, -1, "", "", "", ""),
                seats[18],
                seats[19],
                seats[20],
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              // Row4 seats
              children: [
                Seat('it4-108', -1, -1, "", "", "", ""),
                Seat('it4-108', -1, -1, "", "", "", ""),
                Seat('it4-108', -1, -1, "", "", "", ""),
                Seat('it4-108', -1, -1, "", "", "", ""),
                Seat('it4-108', -1, -1, "", "", "", ""),
                Seat('it4-108', -1, -1, "", "", "", ""),
                Seat('it4-108', -1, -1, "", "", "", ""),
                seats[21],
                seats[22],
                seats[23],
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              // Row5 seats
              children: [
                seats[24],
                seats[25],
                seats[26],
                Seat('it4-108', -1, -1, "", "", "", ""),
                seats[27],
                seats[28],
                Seat('it4-108', -1, -1, "", "", "", ""),
                seats[29],
                seats[30],
                seats[31],
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              // Row6 seats
              children: [
                seats[32],
                seats[33],
                seats[34],
                Seat('it4-108', -1, -1, "", "", "", ""),
                seats[35],
                seats[36],
                Seat('it4-108', -1, -1, "", "", "", ""),
                seats[37],
                seats[38],
                seats[39],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
