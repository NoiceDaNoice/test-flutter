// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    Widget httpPostTest(
      String url,
      var header,
      var body,
      String title,
    ) {
      return TextButton(
        onPressed: () async {
          try {
            var response = await http.post(
              Uri.parse(url),
              headers: header,
              body: body,
            );

            print('Response body:\n\n${response.body}\n\n');
          } catch (e) {
            print(e);
          }
        },
        child: Text(title),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            httpPostTest(
              'https://reqres.in/api/users',
              {'':''},
              {"name": "joemama", "job": "leader"},
              'reqres test',
            ),
            httpPostTest(
              'https://reqres.in/api/users',
              {'': ''},
              {"name": "asdasdasdasdasdasd", "job": "leader"},
              'reqres test',
            ),
          ],
        ),
      ),
    );
  }
}
