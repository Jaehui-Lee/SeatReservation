import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _id = '';
  String _password = '';
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isAllWritten = false;
  bool _isIdWritten = false;
  bool _isPasswordWritten = false;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  var count;

  Future<void> updateCount() async {
    return await users
        .doc('information')
        .update({'userCount': count})
        .then((value) => print("Count Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateUserHistory() async {
    return await users.doc(_id).collection('history').doc('information').set({
      'historyCount': 0, // using-history count
    });
  }

  Future<void> addUser() async {
    return await users.doc(_id).set({
      'id': _id, // John Doe
      'password': _password, // Stokes and Sons
      'currentUsingSeat': "",
    }).then((value) {
      print('Add User');
      updateCount();
      updateUserHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '회원가입',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.8)),
                ),
                labelText: '아이디',
                labelStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (value) {
                setState(() {
                  _id = value;
                  _isIdWritten = value == '' ? false : true;
                  _isAllWritten =
                      (_isIdWritten && _isPasswordWritten) ? true : false;
                });
              },
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.8)),
                ),
                labelText: '비밀번호',
                labelStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (value) {
                setState(() {
                  _password = value;
                  _isPasswordWritten = value == '' ? false : true;
                  _isAllWritten =
                      (_isIdWritten && _isPasswordWritten) ? true : false;
                });
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: double.infinity,
              height: 50.0,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    side: const BorderSide(color: Colors.transparent)),
                onPressed: !_isAllWritten
                    ? null
                    : () async {
                        await users
                            .doc('information')
                            .get()
                            .then((DocumentSnapshot ds) {
                          count = ds.data();
                          count = count['userCount'] + 1;
                        });
                        addUser();
                        Navigator.pop(context);
                      },
                child: Text(
                  '가입하기',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
