import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //metodo login user
  Future<User?> loginUsuario(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //metodo register user
  Future<void> registerUsuario(String email, String password) async {
    try {
      
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
    } catch (e) {
      print(e.toString());

    }
  }

  //metodo logout user
  Future<void> logoutUsuario() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

    Future<void> logout() async {
    await _auth.signOut();
  }
  
}
