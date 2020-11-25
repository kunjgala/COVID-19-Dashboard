
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import './login.dart';
import './signup.dart';
import 'package:firebase_core/firebase_core.dart';
import './auth.dart';
import 'HomePage.dart';
import 'package:hello/routes/pageRoute.dart';
import 'package:hello/screens/screens.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //glue between the widgets layer and the Flutter engine.
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes:{
        pageRoute.home:(context)=>BottomNavScreen(0),
        pageRoute.stats:(context)=>BottomNavScreen(1),
        pageRoute.profile:(context)=>ProfileScreen(),
      },
        home: Scaffold(
            body: Center(
                child: Container(
                    padding: EdgeInsets.fromLTRB(20, 200, 20, 20),
                    constraints: BoxConstraints.expand(),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/covid.png"),    //backgroundimage
                          fit: BoxFit.cover),
                    ),
                    child: new Center(
                        child: new Column(children: <Widget>[    //covid19 text
                          Stack(
                               children: <Widget>[
                              // Stroked text as border.
                                Text(
                                    'COVID-19',
                                    style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 3
                                    ..color = Colors.white,
                                    ),
                                    ),
                               // Solid text as fill.
                                 Text(
                                    'COVID-19',
                                     style: TextStyle(
                                     fontSize: 40,
                                     fontWeight: FontWeight.bold,
                                     color: Colors.deepPurple[800],
                                     ),
                                    ),
                                ],
                           ),
                     
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                      ),
                      new RaisedButton(
                        child: Text('Sign up'),
                        padding: EdgeInsets.only(left: 80, right: 80),
                        elevation: 10.0,
                        color: Colors.white,
                        splashColor: Colors.purple[100],
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new Signup()),
                          );
                        },
                      ),
                      new RaisedButton(
                        child: Text('Login'),
                        padding: EdgeInsets.only(left: 85, right: 85),
                        elevation: 10.0,
                        splashColor: Colors.purple[100],
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new Login()),
                          );
                        },
                      ),
                      Text('OR' ,style: TextStyle(fontWeight: FontWeight.bold,height: 2, fontSize: 20, color: Colors.deepPurple[900],)),
                      SignInButton(
                          Buttons.Google,
                          text: "Sign up with Google",
                          padding: EdgeInsets.only(left: 8),
                          elevation: 10.0,
                       
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                          onPressed: () {
                            signInWithGoogle().then((result){    //to use the Google sign-in data to authenticate a FirebaseUser and then return that user.
                              if (result!=null) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context){
                                    return App();
                                  },),);
                              }
                            });
                          },
                          )
                    ]))))));
  }
}
