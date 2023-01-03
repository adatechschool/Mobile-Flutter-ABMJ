// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

//The main function is the starting point for all our Flutter apps
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Map spot = Map.unmodifiable({
      'Surf Break': 'Reef Break',
      'Photos':
          'https://dl.airtable.com/ZuXJZ2NnTF40kCdBfTld_thomas-ashlock-64485-unsplash.jpg',
      'Address': 'Pipeline, Oahu, Hawaii'
    });

    // String spotName = 'Reef Break';
    // String spotURL =
    //     'https://dl.airtable.com/ZuXJZ2NnTF40kCdBfTld_thomas-ashlock-64485-unsplash.jpg';
    // String spotLocation = 'Pipeline, Oahu, Hawaii';

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 164, 231, 234),
          title: const Center(
              child: Text('Our Surf App 🏄‍♀️', textScaleFactor: 2))),
      body: Center(
        child: Container(
          color: Color.fromARGB(255, 200, 231, 233),
          child: Column(
            children: [
              Text(spot['Surf Break'],
                  textScaleFactor: 3, style: TextStyle(color: Colors.blueGrey)),
              Image.network(spot['Photos']),
              Text(spot['Address'],
                  textScaleFactor: 2, style: TextStyle(color: Colors.blueGrey)),
            ],
          ),
        ),
      ),
    ));
  }
}
