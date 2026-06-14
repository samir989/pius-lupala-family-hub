import 'package:uuid/uuid.dart';
import '../../core/constants/app_constants.dart';
import '../models/member.dart';
import '../models/saving.dart';
import '../models/loan.dart';
import '../models/social_fund_record.dart';
import '../models/meeting.dart';
import '../services/firestore_service.dart';

class GroupRepository {
  final FirestoreService service; const GroupRepository(this.service); static const _uuid = Uuid();
  Stream<List<Member>> members() => service.collection(AppConstants.members).orderBy('name').snapshots().map((s) => s.docs.map((d) => Member.fromMap(d.id, d.data())).toList());
  Stream<List<Saving>> savings() => service.stream(AppConstants.savings).map((s) => s.docs.map((d) => Saving.fromMap(d.id, d.data())).toList());
  Stream<List<Loan>> loans() => service.stream(AppConstants.loans).map((s) => s.docs.map((d) => Loan.fromMap(d.id, d.data())).toList());
  Stream<List<SocialFundRecord>> socialFund() => service.stream(AppConstants.socialFund).map((s) => s.docs.map((d) => SocialFundRecord.fromMap(d.id, d.data())).toList());
  Stream<List<Meeting>> meetings() => service.stream(AppConstants.meetings).map((s) => s.docs.map((d) => Meeting.fromMap(d.id, d.data())).toList());
  Future<void> saveMember(Member x) => service.set(AppConstants.members, x.id.isEmpty ? _uuid.v4() : x.id, x.toMap());
  Future<void> deleteMember(String id) => service.delete(AppConstants.members, id);
  Future<void> addSaving(Saving x) => service.add(AppConstants.savings, x.toMap());
  Future<void> addLoan(Loan x) => service.add(AppConstants.loans, x.toMap());
  Future<void> addSocialFund(SocialFundRecord x) => service.add(AppConstants.socialFund, x.toMap());
  Future<void> addMeeting(Meeting x) => service.add(AppConstants.meetings, x.toMap());
}
