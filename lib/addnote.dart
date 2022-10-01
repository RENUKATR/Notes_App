import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AddNote extends StatefulWidget {

  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();

}

class _AddNoteState extends State<AddNote> {

  String title='';
  String des='';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
        padding: const EdgeInsets.only(left: 10,top: 20),
         child: Column(
         children: [
           Row(
            children: [
              ElevatedButton(onPressed: () { Navigator.of(context).pop();},
                child: const Icon(Icons.arrow_back_ios),
              ),

              const Padding(padding: EdgeInsets.only(left: 230)),
              ElevatedButton(onPressed: add,
                child:  const Text("Save"),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
              )
             ],
            ),
           Form(child: Column(children: [
            const Padding(padding: EdgeInsets.only(left: 10, top:  30)),
             TextFormField(
              decoration: const InputDecoration.collapsed(
              hintText:  '  Title'
            ),
              style: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.green),
              onChanged: (_val){
                title = _val;
              }

            ),
             Container(
               height:MediaQuery.of(context).size.height*0.75,
               padding: const EdgeInsets.only(left:10, top:  40,right: 20),
                child: TextFormField(
                 decoration: const InputDecoration.collapsed(
                     hintText:  'Start typing'
                 ),
                 style: const TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.green),
                 onChanged: (_val){
                   des = _val;
                 },
                 maxLines: 20,
                 )
               ),
          ],))
        ],
        ),
      ),
    )));

  }

  void add() async {
    // save to db
    CollectionReference ref = FirebaseFirestore.instance.collection('users');

    var data = {
      'title': title,
      'description': des,
      'created': DateTime.now(),
    };

    ref.add(data);
    Navigator.pop(context);
  }
}

