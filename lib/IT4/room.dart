import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../seat.dart';

class Room extends StatefulWidget {
  String? _id;
  String? building;
  String? room;

  Room(this._id, this.building, this.room);
  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  List<Seat> seats = List.filled(40, Seat("", "", -1, -1, "", "", "", ""));

  Future<void> updateSeats(
      CollectionReference<Map<String, dynamic>> fseats) async {
    return await fseats.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        if (data['seatNumber'] != null) {
          seats[data['seatNumber']] = Seat(
              widget.building,
              widget.room,
              data['seatNumber'],
              data['state'],
              data['id'],
              data['startTime'],
              data['endTime'],
              widget._id);
        }
      });
    });
  }

  // void addSeats() {
  //   CollectionReference<Map<String, dynamic>> seats = FirebaseFirestore.instance
  //       .collection('rooms')
  //       .doc(widget.building)
  //       .collection(widget.room!);
  //   for (int i = 1; i <= 39; i++) {
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
    CollectionReference<Map<String, dynamic>> fseats = FirebaseFirestore
        .instance
        .collection('rooms')
        .doc(widget.building)
        .collection(widget.room!);
    updateSeats(fseats);
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
                  "${widget.building}-${widget.room}",
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
    if (widget.building == 'it4') {
      if (widget.room == '108') {
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
                    Seat(
                        widget.building!, widget.room!, -1, -1, "", "", "", ""),
                    Seat(
                        widget.building!, widget.room!, -1, -1, "", "", "", ""),
                    Seat(
                        widget.building!, widget.room!, -1, -1, "", "", "", ""),
                    Seat(
                        widget.building!, widget.room!, -1, -1, "", "", "", ""),
                    seats[1],
                    seats[2],
                    Seat(
                        widget.building!, widget.room!, -1, -1, "", "", "", ""),
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
                    Seat(
                        widget.building!, widget.room!, -1, -1, "", "", "", ""),
                    Seat(
                        widget.building!, widget.room!, -1, -1, "", "", "", ""),
                    seats[8],
                    seats[9],
                    Seat(
                        widget.building!, widget.room!, -1, -1, "", "", "", ""),
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
                    Seat(
                        widget.building!, widget.room!, -1, -1, "", "", "", ""),
                    seats[16],
                    seats[17],
                    Seat(
                        widget.building!, widget.room!, -1, -1, "", "", "", ""),
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
                    Seat(
                        widget.building!, widget.room!, -1, -1, "", "", "", ""),
                    Seat(
                        widget.building!, widget.room!, -1, -1, "", "", "", ""),
                    Seat(
                        widget.building!, widget.room!, -1, -1, "", "", "", ""),
                    Seat(
                        widget.building!, widget.room!, -1, -1, "", "", "", ""),
                    Seat(
                        widget.building!, widget.room!, -1, -1, "", "", "", ""),
                    Seat(
                        widget.building!, widget.room!, -1, -1, "", "", "", ""),
                    Seat(
                        widget.building!, widget.room!, -1, -1, "", "", "", ""),
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
                    Seat(
                        widget.building!, widget.room!, -1, -1, "", "", "", ""),
                    seats[27],
                    seats[28],
                    Seat(
                        widget.building!, widget.room!, -1, -1, "", "", "", ""),
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
                    Seat(
                        widget.building!, widget.room!, -1, -1, "", "", "", ""),
                    seats[35],
                    seats[36],
                    Seat(
                        widget.building!, widget.room!, -1, -1, "", "", "", ""),
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
    return Container();
  }
}
