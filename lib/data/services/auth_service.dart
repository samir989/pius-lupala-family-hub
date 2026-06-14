import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/firebase_error.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<void> signInWithEmail(String email, String password) => guardFirebase(() => _auth.signInWithEmailAndPassword(email: email, password: password));
  Future<void> resetPassword(String email) => guardFirebase(() => _auth.sendPasswordResetEmail(email: email));
  Future<void> changePassword(String password) => guardFirebase(() async => _auth.currentUser?.updatePassword(password));
  Future<UserCredential> signInWithOtp(String verificationId, String smsCode) => guardFirebase(() => _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode)));
  Future<void> verifyPhone({required String phone, required PhoneVerificationCompleted completed, required PhoneVerificationFailed failed, required PhoneCodeSent codeSent}) => guardFirebase(() => _auth.verifyPhoneNumber(phoneNumber: phone, verificationCompleted: completed, verificationFailed: failed, codeSent: codeSent, codeAutoRetrievalTimeout: (_) {}));
  Future<void> saveFcmToken(String token) => guardFirebase(() async {
        final user = _auth.currentUser;
        if (user == null) return;
        await _db.collection(AppConstants.users).doc(user.uid).set({'fcmToken': token, 'updatedAt': FieldValue.serverTimestamp()}, SetOptions(merge: true));
      });
  Future<void> signOut() => guardFirebase(() => _auth.signOut());
}
