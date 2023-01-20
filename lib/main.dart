import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'surf_spot.dart';

//The main function is the starting point for all our Flutter apps
//Connect Flutter with Firebase
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "surfify-99e91",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("coucou");
  //Connect firebase realtime database
  final ref = FirebaseDatabase.instance.ref();

  final snapshot = await ref.child('/spots').get();
  if (snapshot.exists) {
    log(snapshot.value.toString());
  } else {
    log('No data available.');
  }

  runApp(const MyApp());
}


//Our main widget : contain appbar, theme and body
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    log("hello la team");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Surfify',
      theme: ThemeData(
        textTheme: GoogleFonts.sacramentoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routes: {
        ExtractArgumentsScreen.routeName: (context) =>
            const ExtractArgumentsScreen(),
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
        body: const MyList(),
      ),
    );
  }
}

//List our spots
class MyList extends StatelessWidget {
  const MyList({super.key});

  @override
  Widget build(BuildContext context) {
    // var spot1 = SurfSpot(
    //     'Reef Break',
    //     'https://dl.airtable.com/ZuXJZ2NnTF40kCdBfTld_thomas-ashlock-64485-unsplash.jpg',
    //     'Pipeline, Oahu, Hawaii');
    // var spot2 = SurfSpot(
    //     'Point Break',
    //     'https://dl.airtable.com/e3QoP3cFSyykZJOvWGIy_cesar-couto-477018-unsplash%20(1).jpg',
    //     'Supertubes, Jeffreys Bay, South Africa');
    // final List<SurfSpot> spots = [spot1, spot2];

    List spots = [];
    spots.add(SurfSpot(
        'Reef Break',
        'https://dl.airtable.com/ZuXJZ2NnTF40kCdBfTld_thomas-ashlock-64485-unsplash.jpg',
        'Pipeline, Oahu, Hawaii'));
    spots.add(SurfSpot(
        'Point Break',
        'https://dl.airtable.com/e3QoP3cFSyykZJOvWGIy_cesar-couto-477018-unsplash%20(1).jpg',
        'Supertubes, Jeffreys Bay, South Africa'));
    spots.add(SurfSpot(
        'Prout Spot',
        'https://dl.airtable.com/e3QoP3cFSyykZJOvWGIy_cesar-couto-477018-unsplash%20(1).jpg',
        'SuperShit, North Dakota'));



    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/background.jpg"), fit: BoxFit.cover),
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
                    ExtractArgumentsScreen.routeName,
                    arguments: ScreenArguments('${spots[index].name}',
                        '${spots[index].url}', '${spots[index].address}'),
                  );
                },
                child: Column(
                  children: [
                    Text(
                      '${spots[index].name}',
                      style: GoogleFonts.lato(fontSize: 25),
                    ),
                    Text(
                      '${spots[index].address}',
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
}

// You can pass any object to the arguments parameter.
class ScreenArguments {
  final String name;
  final String url;
  final String address;

  ScreenArguments(this.name, this.url, this.address);
}

// A Widget that extracts the necessary arguments from
// the ModalRoute.
class ExtractArgumentsScreen extends StatelessWidget {
  const ExtractArgumentsScreen({super.key});

  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

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

//USELESS
// class OneSpot extends StatelessWidget {
//   const OneSpot({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Map spot = Map.unmodifiable({
//       'Surf Break': 'Reef Break',
//       'Photos':
//           'https://dl.airtable.com/ZuXJZ2NnTF40kCdBfTld_thomas-ashlock-64485-unsplash.jpg',
//       'Address': 'Pipeline, Oahu, Hawaii'
//     });

//     // String spotName = 'Reef Break';
//     // String spotURL =
//     //     'https://dl.airtable.com/ZuXJZ2NnTF40kCdBfTld_thomas-ashlock-64485-unsplash.jpg';
//     // String spotLocation = 'Pipeline, Oahu, Hawaii';
//     return Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//             image: AssetImage("images/background.jpg"), fit: BoxFit.cover),
//       ),
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 // margin: const EdgeInsets.all(40.0),
//                 height: 400,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromARGB(255, 185, 184, 184),
//                       blurRadius: 6.0,
//                       spreadRadius: 2.0,
//                       offset: Offset(0.0, 3),
//                     )
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       spot['Surf Break'],
//                       // textScaleFactor: 3,
//                       style: const TextStyle(fontSize: 40),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Image(
//                         image: NetworkImage(spot['Photos']),
//                       ),
//                     ),
//                     Text(
//                       spot['Address'],
//                       style: GoogleFonts.lato(
//                         textStyle: TextStyle(
//                             fontWeight: FontWeight.w300,
//                             fontStyle: FontStyle.italic,
//                             fontSize: 20),
//                         // style: const TextStyle(fontSize: 18),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(30.0),
//                 child: ElevatedButton(
//                   child: Text(
//                     'All Spots',
//                     style: GoogleFonts.lato(
//                       textStyle: TextStyle(fontSize: 15),
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const SpotsLists()),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     primary: Color.fromARGB(255, 59, 130, 166),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//USELESS
// class SpotsLists extends StatelessWidget {
//   const SpotsLists({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Surfify',
//       theme: ThemeData(
//         textTheme: GoogleFonts.sacramentoTextTheme(
//           Theme.of(context).textTheme,
//         ),
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Center(
//             child: Column(children: [
//               Text(
//                 '🏄‍♀️ Surfify',
//                 style:
//                     const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
//               ),
//               Text(
//                 'Locate the best spot on Earth !',
//                 style: GoogleFonts.lato(
//                   textStyle:
//                       TextStyle(fontStyle: FontStyle.italic, fontSize: 10),
//                 ),
//               )
//             ]),
//           ),
//           backgroundColor: Color.fromARGB(255, 59, 130, 166),
//         ),
//         body: Center(
//           child: Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage("images/background.jpg"),
//                   fit: BoxFit.cover),
//             ),
//             child: Center(
//               child: ElevatedButton(
//                 child: Text(
//                   'Go back!',
//                   style: GoogleFonts.lato(
//                     textStyle: TextStyle(fontSize: 15),
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Color.fromARGB(255, 59, 130, 166),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
