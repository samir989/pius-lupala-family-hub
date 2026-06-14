import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/app_constants.dart';

class FirestoreService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> collection(String path) => db.collection(path);
  Stream<QuerySnapshot<Map<String, dynamic>>> stream(String path) => collection(path).orderBy('date', descending: true).snapshots();
  Future<void> set(String path, String id, Map<String, dynamic> data) => collection(path).doc(id).set(data, SetOptions(merge: true));
  Future<void> add(String path, Map<String, dynamic> data) => collection(path).add(data);
  Future<void> delete(String path, String id) => collection(path).doc(id).delete();
  Future<Map<String, num>> totals() async {
    final savings = await collection(AppConstants.savings).get();
    final loans = await collection(AppConstants.loans).get();
    final fund = await collection(AppConstants.socialFund).get();
    return {
      'savings': savings.docs.fold<num>(0, (p, e) => p + (e.data()['amount'] ?? 0)),
      'loans': loans.docs.fold<num>(0, (p, e) => p + (e.data()['balance'] ?? 0)),
      'fund': fund.docs.fold<num>(0, (p, e) => p + ((e.data()['type'] == 'withdrawal' ? -1 : 1) * (e.data()['amount'] ?? 0))),
    };
  }
}
