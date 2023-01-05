// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//The main function is the starting point for all our Flutter apps
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Surfify',
      theme: ThemeData(
        textTheme: GoogleFonts.sacramentoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 200, 231, 233),
        appBar: AppBar(
          title: Center(
            child: Column(children: [
              Text(
                '🏄‍♀️ Surfify',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              Text(
                'Locate the best spot on Earth !',
                style: GoogleFonts.lato(
                  textStyle:
                      TextStyle(fontStyle: FontStyle.italic, fontSize: 10),
                ),
              )
            ]),
          ),
          backgroundColor: Color.fromARGB(255, 59, 130, 166),
        ),
        body: OneSpot(),
      ),
    );
  }
}

class OneSpot extends StatelessWidget {
  const OneSpot({super.key});

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
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              // margin: const EdgeInsets.all(40.0),
              height: 400,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 185, 184, 184),
                    blurRadius: 6.0,
                    spreadRadius: 2.0,
                    offset: Offset(0.0, 3),
                  )
                ],
              ),
              child: Column(
                children: [
                  Text(
                    spot['Surf Break'],
                    textScaleFactor: 3,
                    // style: const TextStyle(fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: NetworkImage(spot['Photos']),
                    ),
                  ),
                  Text(
                    spot['Address'],
                    textScaleFactor: 2,
                    // style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
