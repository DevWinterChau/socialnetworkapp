import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserController{
  static User? user = FirebaseAuth.instance.currentUser;
  static Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final usercredential =  await FirebaseAuth.instance.signInWithCredential(credential);
    print(usercredential.user!.displayName);
    return usercredential.user;
  }

  static Future<bool> signOut() async {
    try{
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      return true;
    }
    catch(e){
      print(e.toString());
      return false;
    }
  }
}