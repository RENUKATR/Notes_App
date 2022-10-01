
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'home.dart';


class Log extends StatelessWidget {
   Log({super.key});

   final TextEditingController _textEditingController= TextEditingController();
   final TextEditingController _password= TextEditingController();
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   final Firestore= FirebaseFirestore.instance;

  @override

  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color.fromARGB(255, 201, 237, 247),

      appBar: AppBar(leading: IconButton(
         onPressed: (){ Navigator.pop(context);},
         icon: const Icon(Icons.arrow_back_ios),
         color: Colors.black,)
         ),
      
      body: Center(
        child: Column(
          children: [
            Expanded(child: Container(
              margin: EdgeInsets.only(bottom:80,),
              decoration:const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image.jpeg"),fit: BoxFit.fitHeight),),
              )
            ),


           const Text("Email",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
           const Padding(padding: EdgeInsets.only(top: 20)),
            Container(
            margin: const EdgeInsets.only(left: 20,right: 20,bottom: 60),
             color: Color.fromARGB(255, 255, 255, 255),
             child: Form(
               key: _formKey,
               child: Column(
                 children: [

                   TextFormField(
                     validator: (text){
                       if(text==null || text.isEmpty)
                       {
                         return "enter email";
                       }

                       if(!text.contains("@"))
                       {
                         return "invalid email";
                       }

                       return null;
                     },
                     controller:  _textEditingController,
                     keyboardType: TextInputType.emailAddress,

                ),
              ],
            ),
          )
         ),


          const Text("Password",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Container(
                margin: const EdgeInsets.only(left: 20,right: 20,bottom: 60),
                color:Color.fromARGB(255, 255, 255, 255),
               child: Form(
               child: Column(
                children: [
                  TextFormField(
                    validator: (text)
                    {
                      if(text==null || text.isEmpty)
                      {
                        return "enter password";
                      }
                      return null;
                    },
                    obscureText: true,
                    controller:  _password,
                    keyboardType: TextInputType.visiblePassword,

                  )
               ],
            )
           )
          ),
            const Padding(padding: EdgeInsets.only(top:60)),
            Container(
              margin: const EdgeInsets.only(bottom:10),
             child: ElevatedButton(onPressed: (){
               _formKey.currentState!.validate();
               Firestore.collection('users').doc('notes');

              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
              } ,
                child:const Text("Log in",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))
            )),
      ],))


    );
  }
}



