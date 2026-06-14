import 'package:cloud_firestore/cloud_firestore.dart';

class Member {
  final String id, name, phone, photo, address, nationalId;
  final DateTime joinDate;
  const Member({required this.id, required this.name, required this.phone, this.photo = '', this.address = '', this.nationalId = '', required this.joinDate});
  factory Member.fromMap(String id, Map<String, dynamic> m) => Member(id: id, name: m['name'] ?? '', phone: m['phone'] ?? '', photo: m['photo'] ?? '', address: m['address'] ?? '', nationalId: m['nationalId'] ?? '', joinDate: (m['joinDate'] as Timestamp?)?.toDate() ?? DateTime.now());
  Map<String, dynamic> toMap() => {'name': name, 'phone': phone, 'photo': photo, 'address': address, 'nationalId': nationalId, 'joinDate': Timestamp.fromDate(joinDate)};
}
