import 'package:firebase_auth/firebase_auth.dart';
import 'package:idea_list/api/user_api.dart';

enum AuthState {
  uninitialized,
  authenticated,
  unauthenticated,
}

class AuthModel {
  final UserApi userApi;

  AuthModel(this.userApi);

  static Stream<FirebaseUser> get authUser$ =>
      FirebaseAuth.instance.onAuthStateChanged;

  Future<void> logout() async {
    await userApi.logout();
  }

  Future<FirebaseUser> getAuthUser() async {
    return await userApi.getAuthUser();
  }
}
