import 'package:flutter/material.dart';

import '../seat.dart';

class IT4_108 extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
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
                  Seat(-1, -1),
                  Seat(-1, -1),
                  Seat(-1, -1),
                  Seat(-1, -1),
                  Seat(0, 1),
                  Seat(2, 2),
                  Seat(-1, -1),
                  Seat(0, 3),
                  Seat(2, 4),
                  Seat(0, 5),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                // Row2 seats
                children: [
                  Seat(2, 6),
                  Seat(0, 7),
                  Seat(-1, -1),
                  Seat(-1, -1),
                  Seat(0, 8),
                  Seat(2, 9),
                  Seat(-1, -1),
                  Seat(0, 10),
                  Seat(2, 11),
                  Seat(0, 12),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                // Row3 seats
                children: [
                  Seat(2, 13),
                  Seat(0, 14),
                  Seat(2, 15),
                  Seat(-1, -1),
                  Seat(0, 16),
                  Seat(2, 17),
                  Seat(-1, -1),
                  Seat(0, 18),
                  Seat(2, 19),
                  Seat(0, 20),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                // Row4 seats
                children: [
                  Seat(-1, -1),
                  Seat(-1, -1),
                  Seat(-1, -1),
                  Seat(-1, -1),
                  Seat(-1, -1),
                  Seat(-1, -1),
                  Seat(-1, -1),
                  Seat(0, 21),
                  Seat(2, 22),
                  Seat(0, 23),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                // Row4 seats
                children: [
                  Seat(2, 24),
                  Seat(0, 25),
                  Seat(2, 26),
                  Seat(-1, -1),
                  Seat(0, 27),
                  Seat(2, 28),
                  Seat(-1, -1),
                  Seat(0, 29),
                  Seat(2, 30),
                  Seat(0, 31),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                // Row4 seats
                children: [
                  Seat(2, 32),
                  Seat(0, 33),
                  Seat(2, 34),
                  Seat(-1, -1),
                  Seat(0, 35),
                  Seat(2, 36),
                  Seat(-1, -1),
                  Seat(0, 37),
                  Seat(2, 38),
                  Seat(0, 39),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
