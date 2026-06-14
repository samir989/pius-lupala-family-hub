import 'package:cloud_firestore/cloud_firestore.dart';

class SupportTicket {
  final String id;
  final String userId;
  final String message;
  final String reply;
  final String status;
  final DateTime createdAt;

  const SupportTicket({
    required this.id,
    required this.userId,
    required this.message,
    this.reply = '',
    this.status = 'open',
    required this.createdAt,
  });

  factory SupportTicket.fromMap(String id, Map<String, dynamic> map) => SupportTicket(
        id: id,
        userId: map['userId'] ?? '',
        message: map['message'] ?? '',
        reply: map['reply'] ?? '',
        status: map['status'] ?? 'open',
        createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      );

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'message': message,
        'reply': reply,
        'status': status,
        'createdAt': Timestamp.fromDate(createdAt),
      };
}
