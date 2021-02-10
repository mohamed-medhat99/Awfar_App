import 'package:firebase_auth/firebase_auth.dart';

class Auth
{
  final _auth = FirebaseAuth.instance;

  Future<AuthResult> signup(String email , String password) async{
    final authResult = await  _auth.createUserWithEmailAndPassword(email: email, password: password);
    return authResult ;
  }
  Future<AuthResult> signin(String email , String password)async{

    final authresult =await _auth.signInWithEmailAndPassword(email: email, password: password);

    return authresult;
  }
  Future<FirebaseUser> getUser ()async{
return await _auth.currentUser();
  }
  Future<void> LogOut(){
    _auth.signOut();
  }
}