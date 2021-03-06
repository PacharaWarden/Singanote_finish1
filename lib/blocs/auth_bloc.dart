import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:singanote/services/auth_service.dart';

class AuthBloc {
  final authService = AuthService();
  final googleSignIn = GoogleSignIn(scopes: ['email']);

  Stream<User?>get currentUser => authService.currentUser;

  loginGoogle() async {

    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential( 
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken
      );

      //Firebase Sign in
      var result = await authService.signInWithCredential(credential);

      // ignore: avoid_print
      print('${result.user?.displayName}');
      

    } catch(error){
      // ignore: avoid_print
      print(error);
    }

  }

  logout()async {

   await authService.logout();
   await googleSignIn.signOut();
  }


}