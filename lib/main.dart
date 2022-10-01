import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
       primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'WELCOME'),
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
 

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
      
        title: Text(widget.title),
       
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[

            const Padding(padding:EdgeInsets.only(left: 20)),
            ElevatedButton(
              onPressed: (() {}),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 160, 227, 168),)),
              child: const Text("Sign up",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),

            const Text("or",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey)),

            ElevatedButton(
              onPressed: (() {

                Navigator.push(context, MaterialPageRoute(builder: (context) =>Log()
                ));
              }), 
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 160, 227, 168),)),
              child: const Text("Log in",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
            
          ],
        ),
      ),

    );
  }
}
