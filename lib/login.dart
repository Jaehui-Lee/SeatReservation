import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _id = '';
  String _password = '';
  final _idnameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isAllWritten = false;
  bool _isIdWritten = false;
  bool _isPasswordWritten = false;
  // bool _isLogin = false;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //       colors: [Color(0xFFE96A2C), Color(0xFFEE9C52)],
        //       begin: Alignment.topRight,
        //       end: Alignment.bottomLeft),
        // ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Seat',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Reservation',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              TextField(
                controller: _idnameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.8)),
                  ),
                  labelText: '아이디',
                  labelStyle: const TextStyle(color: Colors.grey),
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
              const SizedBox(height: 12.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.8)),
                  ),
                  labelText: '비밀번호',
                  labelStyle: const TextStyle(color: Colors.grey),
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
              const SizedBox(
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
                      ? () {
                          _showToast("아이디와 비밀번호를 입력해주세요");
                        }
                      : () {
                          login(context);
                        },
                  child: const Text(
                    '로그인',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: const Text('가입하기',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0)),
                  )
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }

  Future<void> login(context) async {
    return await users.doc(_id).get().then((DocumentSnapshot doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data['id'] == _id && data['password'] == _password) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Home(_id)));
        // _isLogin = true;
      } else {
        _showToast("아이디와 비밀번호를 다시 확인해주세요");
      }
    });
  }

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
