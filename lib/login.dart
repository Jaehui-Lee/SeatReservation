import 'package:flutter/material.dart';

import 'home.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email = '';
  String _password = '';
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = false;
  late final String documentId;

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
                controller: _usernameController,
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
                    _email = value;
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
                  onPressed: () {
                    if ((_email == 'jaehui') && (_password == '1234')) {
                      _isLogin = true;
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Home()));
                    }
                    if (!_isLogin) {
                      print('failure');
                    }
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
}
