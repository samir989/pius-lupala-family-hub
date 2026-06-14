import 'package:cloud_firestore/cloud_firestore.dart';

class Loan {
  final String id, memberId;
  final double amount, interest, balance;
  final DateTime issueDate, dueDate;
  const Loan({required this.id, required this.memberId, required this.amount, required this.interest, required this.issueDate, required this.dueDate, required this.balance});
  static double calculateBalance(double amount, double interest) => amount + (amount * interest / 100);
  factory Loan.fromMap(String id, Map<String, dynamic> m) => Loan(id: id, memberId: m['memberId'] ?? '', amount: (m['amount'] ?? 0).toDouble(), interest: (m['interest'] ?? 0).toDouble(), issueDate: (m['issueDate'] as Timestamp?)?.toDate() ?? DateTime.now(), dueDate: (m['dueDate'] as Timestamp?)?.toDate() ?? DateTime.now(), balance: (m['balance'] ?? calculateBalance((m['amount'] ?? 0).toDouble(), (m['interest'] ?? 0).toDouble())).toDouble());
  Loan copyWith({double? balance}) => Loan(id: id, memberId: memberId, amount: amount, interest: interest, issueDate: issueDate, dueDate: dueDate, balance: balance ?? this.balance);
  Map<String, dynamic> toMap() => {'memberId': memberId, 'amount': amount, 'interest': interest, 'issueDate': Timestamp.fromDate(issueDate), 'dueDate': Timestamp.fromDate(dueDate), 'balance': balance};
  @override
  String toString() => 'Loan TZS $amount • balance TZS $balance';
}
