import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello/login.dart'; 
import 'HomePage.dart';
import 'package:hello/screens/home_screen.dart'; 

class Signup extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Signup> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _key = new GlobalKey();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _name, _email, _password;
checkAuthentification() async {
    
_auth
  .authStateChanges()
  .listen((user) {
    if (user != null) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context)=>App()));
    } 
  });
  }
  @override
  void initState()
  {
    super.initState();
    this.checkAuthentification();
  }

  signUp()async
  {
    if(_key.currentState.validate())
    {
      _key.currentState.save();

      try{
       UserCredential user = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
       if(user!=null)
       {
         /*UserUpdateInfo updateuser = UserUpdateInfo();
         updateuser.displayName = _name;
         user.updateProfile(updateuser);*/
         
         User firebaseUser = user.user; //Returns a [User] containing additional information and user specific methods.
         firebaseUser.updateProfile( displayName: _name);


        }
      }
      catch(e)
      {
        showError(e.errormessage);
      }
    }
  }

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
                      child: new Column(children: <Widget>[
            
             new Text(
                        'SIGN UP',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                        ),
            Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: TextFormField(
              validator:(input)
              {
                if(input.isEmpty)
                return 'Enter Name';
              },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  filled: true,
                  fillColor: Colors.white,
                  
                  hintText: "Enter Name",
                  prefixIcon: Icon(Icons.person),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(27.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(27.0),
                  ),
                ),
                
                onSaved: (value) {
                  _name = value;
                }
            ),),

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
                child: Text('Signup',
                  style: TextStyle(color: Colors.deepPurple),),
                  shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                onPressed: signUp,
                  
                ),
            ),
            Linkify(
                onOpen: (link) => Navigator.push(context,MaterialPageRoute(builder: (context) => new Login()),),
                linkStyle: TextStyle(color: Colors.white),
                style: TextStyle(color: Colors.black),
                text: "have an account? https://login",
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

  /*bool enabled = false;
  bool check = false;
  bool _validate = false;
  bool _passwordVisible = false;

  Map<String, String> _authData = {
    'email' : '',
    'password' : ''
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: scaffoldKey,
          body: Center(
              child: SingleChildScrollView(
                child: Container(
                   padding: EdgeInsets.fromLTRB(20, 80, 20, 20),
                   decoration: BoxDecoration(
                      image: DecorationImage(
                      image: AssetImage("images/covid.png"),
                      fit: BoxFit.cover,
          ),
        ),
        
                  child: Form(
                    key: _key,
                    autovalidate: _validate,
                    child: formUI(),
                  ),
                ),
              )
          ),
        )
    );
  }
  Widget formUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text(
                      'SIGN UP',
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
                hintText: 'First Name',
                prefixIcon: Icon(Icons.person),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(27.0),

                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(27.0),
                ),
              ),
              validator: validateName,
              onSaved: (String value) {
                fname = value;
              }
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Last Name',
                prefixIcon: Icon(Icons.person),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(27.0),

                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(27.0),
                ),
              ),
              // validator: validateName,
              keyboardType: TextInputType.text,
              // ignore: missing_return
              validator: (value) {
                if(value.length < 2) {
                  return 'Name not long enough';
                }
              },
              onSaved: (String value) {
                lname = value;
              }
          ),
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
                _authData['email'] = value;
              }
          ),),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: TextFormField(
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: ()
                  {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(27.0),

                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(27.0),

                ),
              ),
              keyboardType: TextInputType.text,
              validator: validatePassword,
              /*{
                Pattern pattern = r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
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
              onSaved: (value) {
                 _authData['password'] = value;
              }
          ),),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Phone Number',
                prefixIcon: Icon(Icons.phone),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(27.0),

                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(27.0),
                ),
              ),
              keyboardType: TextInputType.number,
              validator: validateMobile,
              onSaved: (String value) {
                phone = value;

              }
          ),),
        /*Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Text("Send Notification"),
            Switch(onChanged: (bool val) {
              setState(() {
                enabled = val;
              }
              );
            },
              activeColor: Colors.indigo.shade900,
              activeTrackColor: Colors.indigoAccent,
              value: enabled,
            )
          ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              CheckboxListTileFormField(
                title : Text('I Agree'),
                onSaved: (bool value) {
                  check = value;
                },
                // ignore: missing_return
                validator: (bool value) {
                  if(value == true) {
                    return null;
                  }
                  else
                  {
                    return "Accept Terms to Proceed";
                  }
                },
              ),],
          ),
        ),*/
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            elevation: 5.0,
            color: Colors.white,
            child: Text('Register',
              style: TextStyle(color: Colors.deepPurple),),
            shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(16.0))),
            onPressed: () {
              _sendTOServer();
            },),
        ),
        /*Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            color: Colors.indigo.shade900,
            child: Text('Login',
              style: TextStyle(color: Colors.white),),
              onPressed: () {
                


              },

          ),



        )*/
         Linkify(
              onOpen: (link) => Navigator.push(context,MaterialPageRoute(builder: (context) => new Login()),),
              linkStyle: TextStyle(color: Colors.white),
              style: TextStyle(color: Colors.black),
              text: "Already a user? https://Login",
        ),],
    );

  }
  void success () {
    final snackbar = new SnackBar(content: new Text("Successful"),backgroundColor: Colors.green,);
    scaffoldKey.currentState.showSnackBar(snackbar);
  }
  String validateName(String value)
  {
    String pattern = r'(^[a-z A-Z,.\-]+$)';
    RegExp regExp = new RegExp(pattern);
    if(value.length==0)
    {
      return "Name is required";
    }
    else if(!regExp.hasMatch(value))
    {
      return "Name must be a a-z and A-Z";
    }
    else
    {
      return null;
    }
  }

  String validateMobile(String value)
  {
    String pattern = r'(^[0-9]*)';
    RegExp regExp = new RegExp(pattern);
    if(value.length==0)
    {
      return "Number is required";
    }
    else if(!regExp.hasMatch(value))
    {
      return "Number must be a 0-9";
    }
    else
    {
      return null;
    }
  }

  String validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value))
        return 'Enter valid password';
      else
        return null;
    }
  }

  Future<void> _sendTOServer() async {
    if(_key.currentState.validate()) {
      _key.currentState.save();
      success();
    }
    else {
      setState(() {
        _validate = true;
      });
    }
  }
}*/