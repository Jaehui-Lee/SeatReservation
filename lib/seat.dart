import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Seat extends StatefulWidget {
  String? room;
  int? seatNumber;
  int? state;
  String? id;
  String? startTime;
  String? endTime;
  String? name; // user name

  Seat(this.room, this.seatNumber, this.state, this.id, this.startTime,
      this.endTime, this.name);

  @override
  State<Seat> createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  CollectionReference<Map<String, dynamic>> fseats =
      FirebaseFirestore.instance.collection('rooms');
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    // no seat
    if (widget.state == -1) {
      return Container(
        width: 60,
        height: 40,
        color: Colors.transparent,
      );
    }
    // not reserved seat
    else if (widget.state == 0) {
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
              '${widget.seatNumber}',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              getCurrentUsingSeat(context);
            },
          ),
        ),
      );
    }
    // reserved seat
    else if (widget.state == 1) {
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
              '${widget.seatNumber}',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              _showDialogUsing(context);
            },
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
              '${widget.seatNumber}',
              style: TextStyle(color: Colors.black38),
            ),
            onPressed: () {},
          ),
        ),
      );
    }
  }

  Future<void> getCurrentUsingSeat(context) async {
    return await users.doc(widget.name).get().then((DocumentSnapshot ds) {
      Map<String, dynamic> data = ds.data() as Map<String, dynamic>;
      if (data['currentUsingSeat'] == '') {
        _showDialogPossible(context);
      }
    });
  }

  void _showDialogPossible(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: const Text("예약 하시겠습니까?"),
          actions: [
            TextButton(
              child: const Text("확인"),
              onPressed: () {
                DateTime sTime = Timestamp.now().toDate();
                DateTime eTime = DateTime(sTime.year, sTime.month, sTime.day,
                    sTime.hour + 2, sTime.minute, sTime.second);
                print("startTime : " +
                    sTime
                        .toString()
                        .substring(0, sTime.toString().indexOf('.')));
                print("endTime : " +
                    eTime
                        .toString()
                        .substring(0, eTime.toString().indexOf('.')));
                setState(() {
                  widget.state = 1;
                  widget.id = widget.name;
                  widget.startTime = sTime
                      .toString()
                      .substring(0, sTime.toString().indexOf('.'));
                  widget.endTime = eTime
                      .toString()
                      .substring(0, eTime.toString().indexOf('.'));
                  updateSeat(
                      1,
                      widget.name!,
                      sTime
                          .toString()
                          .substring(0, sTime.toString().indexOf('.')),
                      eTime
                          .toString()
                          .substring(0, eTime.toString().indexOf('.')),
                      0);
                  _showToast('예약 완료되었습니다');
                });
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text("취소"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogUsing(context) {
    if (widget.id == widget.name) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            content: const Text("사용 종료 하시겠습니까?"),
            actions: [
              TextButton(
                child: const Text("확인"),
                onPressed: () {
                  setState(() {
                    widget.state = 0;
                    widget.id = "";
                    widget.startTime = "";
                    widget.endTime = "";
                    updateSeat(0, "", "", "", 1);
                    _showToast('사용 종료 되었습니다');
                  });
                  //print(Timestamp.now().toDate());
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text("취소"),
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

  Future<void> updateSeat(int _state, String _id, String _startTime,
      String _endTime, int mode) async {
    return await fseats
        .doc(widget.room)
        .collection('seats')
        .doc('seat${widget.seatNumber}')
        .update({
      'state': _state,
      'id': _id,
      'startTime': _startTime,
      'endTime': _endTime,
    }).then((value) async {
      updateUser(mode);
      await FirebaseFirestore.instance
          .collection('rooms')
          .doc(widget.room)
          .get()
          .then((DocumentSnapshot ds) async {
        var v = ds.data() as Map<String, dynamic>;
        updateReserved(mode, v['reserved']);
        await users
            .doc(widget.name)
            .collection('history')
            .doc('information')
            .get()
            .then((value) async {
          int userHistoryCount = value['count'];
          if (mode == 0) {
            userHistoryCount++;
          }
          String temp = Timestamp.now().toDate().toString();
          updateUserHistory(
            mode,
            userHistoryCount,
            _startTime,
            temp.substring(0, temp.indexOf('.')),
          );
          await fseats
              .doc(widget.room)
              .collection('history')
              .doc(_startTime.substring(0, 7))
              .collection(_startTime.substring(0, 10))
              .doc('information')
              .get()
              .then((value) {
            int roomHistoryCount = value['count'];
            if (mode == 0) {
              roomHistoryCount++;
            }
            //updateRoomHistory(mode, roomHistoryCount, _startTime, temp.substring(0, temp.indexOf('.')));
          });
        });

        // updateRoomHistory(mode);
      });
    });
  }

  Future<void> updateUser(int mode) async {
    if (mode == 0) {
      // 사용
      return await users.doc(widget.name).update({
        'currentUsingSeat': 'it4-108-${widget.seatNumber}',
      });
    } else {
      // 사용 취소
      return await users.doc(widget.name).update({
        'currentUsingSeat': '',
      });
    }
  }

  Future<void> updateReserved(int mode, int reserved) async {
    if (mode == 0) {
      // 사용
      return await FirebaseFirestore.instance
          .collection('rooms')
          .doc(widget.room)
          .update({
        'reserved': reserved + 1,
      });
    } else {
      // 사용 취소
      return await FirebaseFirestore.instance
          .collection('rooms')
          .doc(widget.room)
          .update({
        'reserved': reserved - 1,
      });
    }
  }

  Future<void> updateUserHistory(
      int mode, int userHistoryCount, String startTime, String endTime) async {
    if (mode == 0) {
      // 사용
      return await users
          .doc(widget.name)
          .collection('history')
          .doc(userHistoryCount.toString())
          .set({
        'room': widget.room,
        'seatNumber': widget.seatNumber,
        'startTime': startTime,
      }).then((value) async {
        await users
            .doc(widget.name)
            .collection('history')
            .doc('information')
            .update({
          'count': userHistoryCount,
        });
      });
    } else {
      // 사용 취소
      return await users
          .doc(widget.name)
          .collection('history')
          .doc(userHistoryCount.toString())
          .update({
        'endTime': endTime,
      });
    }
  }

  // Future<void> updateRoomHistory(int mode, int roomHistoryCount, String startTime, String endTime) async{
  //   if ( mode == 0 ){ // 사용
  //     return await fseats.doc(widget.room).collection('history').doc()
  //   }else{
  //     // 사용 취소
  //     return await
  //   }
  // }

  void _showToast(String _msg) {
    Fluttertoast.showToast(
        msg: _msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
