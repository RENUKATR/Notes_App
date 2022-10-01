import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewNote extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  ViewNote(this.data, this.time, this.ref);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  String title='';
  String des='';

  bool edit = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    title = widget.data['title'];
    des = widget.data['description'];
    return SafeArea(
      child: Scaffold(
        //
        floatingActionButton: edit
            ? FloatingActionButton(
                onPressed: save,
                backgroundColor: Colors.green,
                child: const Text("Save", style: TextStyle(color: Colors.white),
                    ),): null,

        resizeToAvoidBottomInset: false,

        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all( 12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 20.0,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all( Colors.blueGrey,),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 25.0,vertical: 8.0,),
                        ),
                      ),
                    ),
                    //
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              edit = !edit;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blueGrey,),
                            padding: MaterialStateProperty.all( const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8.0,),
                            ),
                          ),
                          child:Text("Edit")
                        ),
                        //
                        const SizedBox(
                          width: 10.0,
                        ),
                        const Padding(padding: EdgeInsets.only(top:50)),
                        ElevatedButton(
                          onPressed: delete,
                          child: const Icon(Icons.delete_forever,size: 24.0,),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.green,),
                            padding: MaterialStateProperty.all( EdgeInsets.symmetric(horizontal: 5.0,vertical: 8.0,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //
                const SizedBox(
                  height: 10.0,
                ),
                //
                const Padding(padding: EdgeInsets.only(top: 50)) ,
                Form(
                  key: key,
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration.collapsed(
                          hintText: "Title",
                        ),
                        style: const TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                        initialValue: widget.data['title'],
                        enabled: edit,
                        onChanged: (_val) {
                          title = _val;
                        },
                        validator: (_val) {
                          if (_val!.isEmpty) {
                            return "Can't be empty !";
                          } else {
                            return null;
                          }
                        },
                      ),
                      //
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0,bottom: 12.0,),
                        child: Text(
                          widget.time,
                          style: const TextStyle(fontSize: 20.0,color: Colors.blueGrey,),
                        ),
                      ),

                      TextFormField(
                        decoration: const InputDecoration.collapsed(
                          hintText: "Note Description",
                        ),
                        style: const TextStyle(fontSize: 20.0,color: Colors.blueGrey,),
                        initialValue: widget.data['description'],
                        enabled: edit,
                        onChanged: (_val) {
                          des = _val;
                        },
                        maxLines: 20,
                        validator: (_val) {
                          if (_val!.isEmpty) {
                            return "Can't be empty !";
                          } else {
                            return null;
                          }
                        },
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
 // delete from database
  void delete() async {
    await widget.ref.delete();
    Navigator.pop(context);
  }

  void save() async {
    if (key.currentState!.validate()) {
      await widget.ref.update(
        {'title': title, 'description': des},
      );
      Navigator.of(context).pop();
    }
  }
}