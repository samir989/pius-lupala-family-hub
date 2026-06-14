import 'package:uuid/uuid.dart';
import '../../core/constants/app_constants.dart';
import '../models/member.dart';
import '../models/saving.dart';
import '../models/loan.dart';
import '../models/social_fund_record.dart';
import '../models/meeting.dart';
import '../services/firestore_service.dart';

class GroupRepository {
  final FirestoreService service;
  const GroupRepository(this.service);
  static const _uuid = Uuid();

  Stream<List<Member>> members() => service.streamCollection(AppConstants.members, orderBy: 'name', descending: false).map((s) => s.docs.map((d) => Member.fromMap(d.id, d.data())).toList());
  Stream<List<Saving>> savings() => service.streamCollection(AppConstants.savings, orderBy: 'date').map((s) => s.docs.map((d) => Saving.fromMap(d.id, d.data())).toList());
  Stream<List<Loan>> loans() => service.streamCollection(AppConstants.loans, orderBy: 'issueDate').map((s) => s.docs.map((d) => Loan.fromMap(d.id, d.data())).toList());
  Stream<List<SocialFundRecord>> socialFund() => service.streamCollection(AppConstants.socialFund, orderBy: 'date').map((s) => s.docs.map((d) => SocialFundRecord.fromMap(d.id, d.data())).toList());
  Stream<List<Meeting>> meetings() => service.streamCollection(AppConstants.meetings, orderBy: 'date').map((s) => s.docs.map((d) => Meeting.fromMap(d.id, d.data())).toList());

  Future<void> saveMember(Member member) async {
    final isNew = member.id.isEmpty;
    final id = isNew ? _uuid.v4() : member.id;
    await service.set(AppConstants.members, id, member.toMap());
    if (isNew) await service.incrementSummary(members: 1);
  }

  Future<void> deleteMember(String id) async {
    await service.delete(AppConstants.members, id);
    await service.incrementSummary(members: -1);
  }

  Future<void> addSaving(Saving saving) async {
    await service.add(AppConstants.savings, saving.toMap());
    await service.incrementSummary(savings: saving.amount);
  }

  Future<void> addLoan(Loan loan) async {
    final balance = Loan.calculateBalance(loan.amount, loan.interest);
    await service.add(AppConstants.loans, loan.copyWith(balance: balance).toMap());
    await service.incrementSummary(loans: balance);
  }

  Future<void> addSocialFund(SocialFundRecord record) async {
    await service.add(AppConstants.socialFund, record.toMap());
    await service.incrementSummary(fund: record.type == 'withdrawal' ? -record.amount : record.amount);
  }

  Future<void> addMeeting(Meeting meeting) => service.add(AppConstants.meetings, meeting.toMap());
}
