import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//The main function is the starting point for all our Flutter apps
//Connect Flutter with Firebase
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "surfify-99e91",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SurfifyApp());
}


//Our main widget : contain appbar, theme and body
class SurfifyApp extends StatelessWidget {
  const SurfifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    log("SurfifyApp");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Surfify',
      theme: ThemeData(
        textTheme: GoogleFonts.sacramentoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routes: {
        SpotDetailsScreen.routeName: (context) =>
            const SpotDetailsScreen(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Column(children: [
              const Text(
                '🏄‍♀️ Surfify',
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              Text(
                'Locate the best spot on Earth !',
                style: GoogleFonts.lato(
                  textStyle:
                      const TextStyle(fontStyle: FontStyle.italic, fontSize: 10),
                ),
              )
            ]),
          ),
          backgroundColor: const Color.fromARGB(255, 59, 130, 166),
        ),
        body: const Spots(),
      ),
    );
  }
}

//List our spots
class Spots extends StatelessWidget {
  const Spots({super.key});
  
  @override
  Widget build(BuildContext context) {
    log("Spots");
    //Connect firebase realtime database
    final databaseRef = FirebaseDatabase.instance.ref();
    
    // spots.add(SurfSpot(
    //     'Reef Break',
    //     'https://dl.airtable.com/ZuXJZ2NnTF40kCdBfTld_thomas-ashlock-64485-unsplash.jpg',
    //     'Pipeline, Oahu, Hawaii'));
    // spots.add(SurfSpot(
    //     'Point Break',
    //     'https://dl.airtable.com/e3QoP3cFSyykZJOvWGIy_cesar-couto-477018-unsplash%20(1).jpg',
    //     'Supertubes, Jeffreys Bay, South Africa'));
    // spots.add(SurfSpot(
    //     'Prout Spot',
    //     'https://dl.airtable.com/e3QoP3cFSyykZJOvWGIy_cesar-couto-477018-unsplash%20(1).jpg',
    //     'SuperShit, North Dakota'));

// FutureBuilder récupère les données du serveur pour le construire dans le widget
    return FutureBuilder(
      future: databaseRef.child('/spots').get(),
      builder: ((context, snapshot) {
        final spots = [];

// Vérifie si le résultat est ok
        if(snapshot.hasData == true
            && snapshot.data is DataSnapshot
            && (snapshot.data as DataSnapshot).value is List){
          // Data from Firebase
          final data = (snapshot.data as DataSnapshot).value;

          // Enrichir la liste des spots
          if(data is List){
            for (final spot in data) {
              spots.add(
                {
                  'name' : spot['name'],
                  'address':spot['address'],
                  'url': spot['url']
                }
              );
            }
          } 
  
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: spots.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 60,
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 59, 130, 166),
                      ),
                      onPressed: () {
                        // When the user taps the button,
                        // navigate to a named route and
                        // provide the arguments as an optional
                        // parameter.
                        Navigator.pushNamed(
                          context,
                          SpotDetailsScreen.routeName,
                          arguments: SpotDetailsArgument(
                            spots[index]['name'] ?? '',
                            spots[index]['url'] ?? '',
                            spots[index]['address'] ?? '',
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Text(
                            // "??" pour éviter à l'appli de crasher,  
                            // il faut toujours avoir une donnée lisible. 
                            spots[index]['name'] ?? 'Defaut',
                            style: GoogleFonts.lato(fontSize: 25),
                          ),
                          Text(
                            spots[index]['address'] ?? 'Defaut',
                            style: GoogleFonts.lato(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            ),
          );
        }
        else{
          return const Center(
            child: Text('No data'),
          );
        }
      }),
    );
  }
}

// You can pass any object to the arguments parameter.
class SpotDetailsArgument {
  final String name;
  final String url;
  final String address;

  SpotDetailsArgument(this.name, this.url, this.address);
}

// A Widget that extracts the necessary arguments from
// the ModalRoute.
class SpotDetailsScreen extends StatelessWidget {
  const SpotDetailsScreen({super.key});

  static const routeName = '/spotDetails';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args
      = ModalRoute.of(context)!.settings.arguments as SpotDetailsArgument;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          args.name,
          style: GoogleFonts.lato(),
        ),
        backgroundColor: const Color.fromARGB(255, 59, 130, 166),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
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
                        args.name,
                        // textScaleFactor: 3,
                        style: const TextStyle(fontSize: 40),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: NetworkImage(args.url),
                        ),
                      ),
                      Text(
                        args.address,
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic,
                              fontSize: 20),
                          // style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}