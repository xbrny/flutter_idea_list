import 'package:firebase_auth/firebase_auth.dart';

class UserApi {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login(email, password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> register(username, email, password) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  Future<FirebaseUser> getAuthUser() async {
    return await auth.currentUser();
  }
}
