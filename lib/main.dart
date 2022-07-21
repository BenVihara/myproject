import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'components.dart';
import 'singin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width / 3,
                    0,
                    MediaQuery.of(context).size.width / 3,
                    0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          width: 3,
                          color: const Color(0xFF0e214a).withOpacity(0.5),
                        ),
                      ),
                      child: TextFormField(
                        style: const TextStyle(
                          color: Color(0xFF0e214a),
                          fontWeight: FontWeight.bold,
                        ),
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is incorrect';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          labelStyle: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF0e214a),
                            fontWeight: FontWeight.bold,
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 5,
                              color: Color(0xFF0e214a),
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          width: 3,
                          color: const Color(0xFF0e214a).withOpacity(0.5),
                        ),
                      ),
                      child: TextFormField(
                        style: const TextStyle(
                          color: Color(0xFF0e214a),
                          fontWeight: FontWeight.bold,
                        ),
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter the password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF0e214a),
                            fontWeight: FontWeight.bold,
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 5,
                              color: Color(0xFF0e214a),
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                signUP();
              },
              child: Container(
                width: 100,
                height: 50,
                color: Colors.amber,
                child: const Center(child: Text('SIGN UP')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signUP() async {
    var dateBody = {
      "userName": emailController.text,
      "userPass": passwordController.text
    };
    http.Response res = await http
        .post(Uri.parse("https://psyclub.ir/psyclub/signup_ga.php"),
            body: jsonEncode(dateBody))
        .timeout(const Duration(seconds: 15));

    var jsonData = jsonDecode(res.body);
    String msg = jsonData['msg'];
    if (msg == "Exists") {
    } else if (msg == "Failed") {
    } else {
      MTD.jumpScreen(context, const SignIn());
    }
  }
}
