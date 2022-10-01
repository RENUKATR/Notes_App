import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/addnote.dart';
import 'viewnote.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push( MaterialPageRoute(builder: (context) => AddNote(),),)
              .then((value) {
            setState(() {});
          });
        },
        backgroundColor: Colors.lightGreen,
        child: const Icon(
          Icons.add,
          color: Colors.white70,
        ),
      ),
      //
      appBar: AppBar(
        title: const Text(
          "Notes",
          style: TextStyle(
            fontSize: 32.0,
            //fontFamily: "lato",
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
      ),
      //

      body: FutureBuilder<QuerySnapshot>(
        future: ref.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // if (snapshot.data!.docs.isEmpty) {
            //   return const Center(
            //     child: Text(
            //       " no saved Notes !",
            //       style: TextStyle(
            //         color: Colors.white70,
            //       ),
            //     ),
            //   );
            // }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {

                Map data = snapshot.data!.docs[index].data();
                DateTime dt = data['created'].toDate();
                String formattedTime =
                DateFormat.yMMMd().add_jm().format(dt);

                return InkWell(
                  onTap: () {
                    Navigator.of(context).push( MaterialPageRoute(
                        builder: (context) => ViewNote(
                          data,
                          formattedTime,
                          snapshot.data!.docs[index].reference,
                        ),
                      ),
                    ) .then((value) {
                      setState(() {});
                    });
                  },

                  child: Card(
                    margin: EdgeInsets.only(left: 20, top:10, right: 20),
                    color: Colors.lightGreen,
                    child: Padding(padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data['title']}",
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          //
                          Container(
                          alignment: Alignment.centerRight,
                            child: Text(
                              formattedTime,
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text("Loading..."),
            );
          }
        },
      ),
    );
  }
}