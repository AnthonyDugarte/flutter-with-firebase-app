import "package:firebase_auth/firebase_auth.dart";

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> singIn({String email, String password}) async {
    FirebaseUser user = (await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;

    return user.uid;
  }

  Future<String> singUp({String email, String password}) async {
    FirebaseUser user = (await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;

    return user.uid;
  }

  Future<void> signOut() async {
    return await auth.signOut();
  }
}
