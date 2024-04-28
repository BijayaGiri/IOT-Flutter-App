import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //final auth=FirebaseAuth.instance;//creating the instance of the firebase
  final ref=FirebaseDatabase.instance.ref("test");
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Center(child: Text("Home Screen",style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),)),
        ),
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: FirebaseAnimatedList(
                    query: ref,
                    itemBuilder: (context,snapshot,animation,index){
                      final val=snapshot.child("tap").value.toString();
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Current Status: ",style: TextStyle(color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),),

                                Text(val,style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),),

                              ],
                            ),
                          ),
                          Container(
                            height: 80,
                            width: 30,
                            child:val=="off"?Image.asset("assets/images/LEDOFF.png"):Image.asset("assets/images/LEDON.png"),
                          ),
                          //Text(snapshot.child("num").value.toString()),

                          Center(
                            child: ElevatedButton(onPressed: (){
                              setState(() {
                                ref.child("click").update({
                                  "tap":val=="on"?"off":"on"

                                });
                              });
                            }, child: Text(val=="on"?"off":"on")),
                          )
                        ],
                      );
                    }))

          ],
        )
    );
  }
}