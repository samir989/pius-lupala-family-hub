import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/firebase_error.dart';

class FirestoreService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> collection(String path) => db.collection(path);

  Stream<QuerySnapshot<Map<String, dynamic>>> streamCollection(String path, {String? orderBy, bool descending = true}) {
    try {
      final ref = collection(path);
      return (orderBy == null ? ref : ref.orderBy(orderBy, descending: descending)).snapshots();
    } catch (error) {
      return Stream.error(error);
    }
  }

  Future<void> set(String path, String id, Map<String, dynamic> data) => guardFirebase(() => collection(path).doc(id).set(data, SetOptions(merge: true)));
  Future<DocumentReference<Map<String, dynamic>>> add(String path, Map<String, dynamic> data) => guardFirebase(() => collection(path).add(data));
  Future<void> delete(String path, String id) => guardFirebase(() => collection(path).doc(id).delete());

  Future<void> incrementSummary({num members = 0, num savings = 0, num loans = 0, num fund = 0}) => guardFirebase(() {
        return db.collection(AppConstants.summaries).doc(AppConstants.groupSummary).set({
          'members': FieldValue.increment(members),
          'savings': FieldValue.increment(savings),
          'loans': FieldValue.increment(loans),
          'fund': FieldValue.increment(fund),
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      });

  Future<Map<String, num>> totals() => guardFirebase(() async {
        final doc = await db.collection(AppConstants.summaries).doc(AppConstants.groupSummary).get();
        final data = doc.data() ?? const {};
        return {
          'members': data['members'] ?? 0,
          'savings': data['savings'] ?? 0,
          'loans': data['loans'] ?? 0,
          'fund': data['fund'] ?? 0,
        };
      });
}
