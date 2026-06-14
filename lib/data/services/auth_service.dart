import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;
  Future<void> signInWithEmail(String email, String password) => _auth.signInWithEmailAndPassword(email: email, password: password);
  Future<void> resetPassword(String email) => _auth.sendPasswordResetEmail(email: email);
  Future<void> changePassword(String password) async => _auth.currentUser?.updatePassword(password);
  Future<void> verifyPhone({required String phone, required PhoneVerificationCompleted completed, required PhoneVerificationFailed failed, required PhoneCodeSent codeSent}) => _auth.verifyPhoneNumber(phoneNumber: phone, verificationCompleted: completed, verificationFailed: failed, codeSent: codeSent, codeAutoRetrievalTimeout: (_) {});
  Future<void> signOut() => _auth.signOut();
}
