import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

//A future represents the result of an asynchronous operation, and can have two states: uncompleted or completed.
Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn(); //Holds fields describing a signed in user's identity.
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication; //Holds authentication tokens after sign in.

  final AuthCredential credential = GoogleAuthProvider.credential(   //Creates a credential for Google. At least one of ID token and access token is required.
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
final UserCredential authResult = await _auth.signInWithCredential(credential); //If successful, it also signs the user in into the app and updates any [authStateChanges]
final User user = authResult.user;
if (user!=null) {
  assert(!user.isAnonymous); //test if boolean expression is true
  assert(await user.getIdToken()!= null);
  final User currentUser = _auth.currentUser; //Returns the current [User] if they are currently signed-in, or null if not.
  assert(user.uid == currentUser.uid);
  print('signinwithgoogle succeeded: $user');
  return '$user';
}
return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
  print('user signed out');
}