

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './signup.dart';
import 'package:email_validator/email_validator.dart';
import 'HomePage.dart';




class Login extends StatefulWidget {
   String password;
   Login();


  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _key = new GlobalKey();
  //GlobalKey uniquely identifies the form and allows you to do any validation in the form fields
  
  //String _pass,_name,ver,email;
  String _email, _password;

  checkAuthentification() async {

  _auth
  .authStateChanges()
  .listen((user) {
    if (user != null) {
      
      Navigator.push(context, MaterialPageRoute(
      builder: (context, {result=true})=>App()));
    } 
    else {

         return AlertDialog(
            title: Text('Error'),
            content: Text('Invalid Credentials'),
            actions: <Widget>[
            FlatButton(
            onPressed: (){
                Navigator.of(context).pop();
          },
            child: Text('OK'))
        
      ],
    );
       }
    }
  );
  }
  @override
  void initState() 
  //If a State's build method depends on an object that can itself change state
  // The framework will call this method exactly once for each State object it creates.
  {
    super.initState();  //to override state
    this.checkAuthentification();
  }
  
  login()async 
  //The async and await keywords provide a declarative way to define asynchronous functions and use their results.
  //let your program complete work while waiting for another operation to finish.
  {
    if(_key.currentState.validate())
    {
      _key.currentState.save();

      try{
       UserCredential user = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
 
      }
      catch(e)
      {
        
        showError(e.errormessage);
      }
    }
  }

final scaffoldKey = new GlobalKey<ScaffoldState>();
showError(String errormessage){
  showDialog(
  context: context,
  builder: (BuildContext context)
  {
    return AlertDialog(
      title: Text('Error'),
      content: Text(errormessage),
      actions: <Widget>[
        FlatButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: Text('OK'))
        
      ],
    );
  }
  );
}
@override
  Widget build(BuildContext context) {
    return Scaffold(  
      key: scaffoldKey,
        body: Container(
          
          height: double.infinity,
          padding: EdgeInsets.fromLTRB(20, 160, 20, 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/covid.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: new Column(
              
            children: <Widget>[
            
             new Text(
                        'LOGIN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                        ),
            
             Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  filled: true,
                  fillColor: Colors.white,
                  
                  hintText: "Email: e.g abc@gmail.com",
                  prefixIcon: Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(27.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(27.0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (email) => EmailValidator.validate(email)
                    ? null
                    : "Invalid Email Address",
                onSaved: (value) {
                  _email = value;
                }
            ),),
            
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextFormField(
                
                  validator: (input)
                  {
                    if(input.length < 6)
                    return 'Provide Minimum 6 charachters';
                  },
                    decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(27.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(27.0),
                    ),
                  ),
                    obscureText: true,
                     onSaved: (String value) {
                    _password = value;
                  },
                  
                 
                /*{
                  Pattern pattern = r'^(?=.[0-9]+.)(?=.[a-zA-Z]+.)[0-9a-zA-Z]{6,}$';
                  RegExp regex = new RegExp (pattern);
                  if(!regex.hasMatch(value))
                  {
                    return "Invalid Password";
                  }
                  else
                  {
                    return null;
                  }

                },*/
              ),),
            Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: RaisedButton(
                 elevation: 5.0,
                 color: Colors.white,
                 child: Text('Login',
                    style: TextStyle(color: Colors.deepPurple),),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                 onPressed: login 
                  
                ,),
            ),
            Linkify(
                onOpen: (link) => Navigator.push(context,MaterialPageRoute(builder: (context) => new Signup()),),
                linkStyle: TextStyle(color: Colors.white),
                style: TextStyle(color: Colors.black),
                text: "Don't have an account? https://signup",
        ),
            
        ],
      ),
          ),
        ),
    ),
    );
  }

    /*void success () {
      final snackbar = new SnackBar(
        content: new Text("Successful"), backgroundColor: Colors.green,);
      scaffoldKey.currentState.showSnackBar(snackbar);
    }

  void failure () {
    final snackbar = new SnackBar(
      content: new Text("Not Successful"), backgroundColor: Colors.redAccent,);
    scaffoldKey.currentState.showSnackBar(snackbar);
  }*/

}