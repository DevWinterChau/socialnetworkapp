import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialnetworkapp/modules/authentication/wrapper/auth_plugin/auth_plugin.dart';

class AuthGmail implements AuthLogin{

  static final AuthGmail _instance = AuthGmail.internal();
  late GoogleSignIn _googleSignIn;

  factory AuthGmail(){
    return _instance;
  }

  AuthGmail.internal(){
    _googleSignIn = GoogleSignIn();
  }

  @override
  Future<bool> isLoggedIn() {
    // TODO: implement isLoggedIn
    return _googleSignIn.isSignedIn();
  }

  @override
  Future<AuthResult> login() async {
    await _googleSignIn.signOut();
    try{
        final googleSigInAccount = await _googleSignIn.signIn();
        // Trường hợp bị hủy bởi người dùng...
        if(googleSigInAccount == null){
          // trả về token Null
          return AuthResult(LoginStatus.cancelledByUser, null);
        }
        final googleSigInAuthentication = await googleSigInAccount.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleSigInAuthentication?.accessToken,
          idToken: googleSigInAuthentication?.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("gmail_token", googleSigInAuthentication!.accessToken!);
        return AuthResult(LoginStatus.loggedIn, googleSigInAuthentication.accessToken);
    }catch(e){
        return AuthResult(LoginStatus.error, null, errMessage: e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try{
      await FirebaseAuth.instance.signOut();
      await _googleSignIn.signOut();
    }
    catch(e){
      print(e.toString());
    }
  }

}