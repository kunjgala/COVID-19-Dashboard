import 'package:flutter/material.dart';
import 'package:hello/screens/home_screen.dart';
import 'package:hello/screens/screens.dart';
import 'package:hello/routes/pageRoute.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello/main.dart';


class CustomDrawer extends StatefulWidget {
  
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int index=0;
  List list= [
    Scaffold(),
    HomeScreen(),
    StatsScreen(),
    Scaffold(),
  ];
  void onTap(ctx,i){

    setState(() {
    index = i;
    Navigator.pop(ctx);
    });
    }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.5,
      height: MediaQuery.of(context).size.height*1,
      child: Drawer(

        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          
          children: [
            ListTile(
              title: Text("PROFILE",style: TextStyle(color:Color(0xFF473F97),fontWeight:FontWeight.w900),),
              onTap: ()=>Navigator.pushReplacementNamed(context,pageRoute.profile),
            ),
            ListTile(
              title: Text("Home",style: TextStyle(color:Color(0xFF473F97)),),
              onTap: ()=>Navigator.pushReplacementNamed(context,pageRoute.home),
            ),
            ListTile(
              title: Text("Statistics",style: TextStyle(color:Color(0xFF473F97))),
              onTap: ()=>Navigator.pushReplacementNamed(context,pageRoute.stats),
            ),
            ListTile(
              title: Text("Information",style: TextStyle(color:Color(0xFF473F97))),
              onTap: ()=>onTap(context,3),
            ),
             ListTile(
              title: Text("Sign Out",style: TextStyle(color:Color(0xFF473F97))),
              onTap: ()=>{_auth.signOut(), Navigator.push(context, MaterialPageRoute(
        builder: (context)=>MyApp()))}
            ),
          ],
        ),
      ),
    );
  }
}