import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //atributo
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //metodo login user
  Future<User?> loginUsuario(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user!;
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
