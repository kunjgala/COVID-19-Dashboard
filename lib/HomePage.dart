import 'package:flutter/material.dart';
import 'package:hello/routes/pageRoute.dart';
import 'package:hello/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello/main.dart';

/*class HomePage extends StatefulWidget {
  @override
  _HomePageState createState()=> _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool islogged = false;

checkAuthentification() async{
  _auth.authStateChanges().listen((user){
       if(user == null)
       {
         Navigator.push(context, MaterialPageRoute(builder:(context)=> MyApp()));
       }
  });
}
getUser() async{
  User firebaseuser = await _auth.currentUser;
  await firebaseuser?.reload();
  firebaseuser = _auth.currentUser;
  if(firebaseuser!= null)
  {
     if (!mounted) return;
    setState((){
      this.user = firebaseuser;
      this.islogged = true;
    });
  }
}

@override
void initState()
{
this.checkAuthentification();
this.getUser();
}
@override
Widget build(BuildContext context) {
  return Scaffold (
body: Container(
  child: !islogged? CircularProgressIndicator():
  Column(
    children: <Widget>[
      Container(
        child: Text("Hello ${user.displayName} you are logged in as ${user.email}",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold
        ),),
      ),
      
    ]
  ))
  );
}
}*/
void main() {
  runApp(App());
  
}


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Covid-19 Dashboard UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BottomNavScreen(0),
      routes:{
        pageRoute.home:(context)=>BottomNavScreen(0),
        pageRoute.stats:(context)=>BottomNavScreen(1),
        pageRoute.profile:(context)=>ProfileScreen(),
      }
    );
  }
}
