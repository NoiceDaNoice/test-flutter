// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_1/shared_pref.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            TextButton(
              onPressed: () async {
                try {
                  var response = await http.post(
                    Uri.parse(
                        'http://10.251.2.102:8123/web/session/authenticate'),
                    headers: {'Content-Type': 'application/json'},
                    body: json.encode({
                      "jsonrpc": "2.0",
                      "params": {
                        "db": "odoo12_prodcopy",
                        "login": "admin",
                        "password": "admin"
                      }
                    }),
                  );

                  print('Response body:\n\n${response.body}\n\n');

                  print(response.headers);
                  print('cokieeeeee ' + response.headers['set-cookie']!);
                  String delimiter = ';';
                  int lastIndex = response.headers['set-cookie']
                      .toString()
                      .indexOf(delimiter);
                  String trimmed = response.headers['set-cookie']
                      .toString()
                      .substring(0, lastIndex);

                  print('$trimmed ini yang dah di trimmed');
                  // var jsonResponse = jsonDecode(response.body);

                  // print(
                  //     'session idnya ${jsonResponse['result']['session_id']}\n');
                  setState(() {
                    SharedPref().setStringValue(
                      'sessionId',
                      trimmed,
                    );
                  });
                } catch (e) {
                  print(e);
                }
              },
              child: Text('auth'),
            ),
            TextButton(
              onPressed: () async {
                String session = await SharedPref().getStringValue('sessionId');
                print('\n\nSesion masuk $session\n\n');
                try {
                  var response = await http.post(
                    Uri.parse(
                        'http://10.251.2.102:8123/mobile/create/attendance'),
                    headers: {
                      'Content-Type': 'application/json',
                      'Cookie': session
                    },
                    body: json.encode({
                      "params": {
                        "create_uid": "80",
                        "uid": "74",
                        "time": "2022-11-18 16:09:06",
                        "latitude": "0.1234",
                        "longitude": "0.1234"
                      }
                    }),
                  );

                  print('Response body:\n\n${response.body}\n\n');
                } catch (e) {
                  print(e);
                }
              },
              child: Text('attend'),
            ),
          ],
        ),
      ),
    );
  }
}
