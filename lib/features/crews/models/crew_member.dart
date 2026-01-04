import 'package:cloud_firestore/cloud_firestore.dart';

class CrewMember {
  final String uid; // Document ID and User Auth UID
  final String crewId; // Reference to Crew
  final String role; // Strictly 'Foreman' or 'Member'
  final DateTime joinedAt;
  final String status; // 'active', 'suspended'
  final Map<String, dynamic> userSnapshot; // { displayName, avatarUrl, jobTitle }

  CrewMember({
    required this.uid,
    required this.crewId,
    required this.role,
    required this.joinedAt,
    required this.status,
    required this.userSnapshot,
  });

  factory CrewMember.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CrewMember(
      uid: doc.id,
      crewId: data['crewId'] ?? '',
      role: data['role'] ?? 'Member',
      joinedAt: (data['joinedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: data['status'] ?? 'active',
      userSnapshot: data['userSnapshot'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'crewId': crewId,
      'role': role,
      'joinedAt': Timestamp.fromDate(joinedAt),
      'status': status,
      'userSnapshot': userSnapshot,
    };
  }

  factory CrewMember.fromMap(Map<String, dynamic> map) {
    return CrewMember(
      uid: map['uid'] ?? '',
      crewId: map['crewId'] ?? '',
      role: map['role'] ?? 'Member',
      joinedAt: (map['joinedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: map['status'] ?? 'active',
      userSnapshot: map['userSnapshot'] as Map<String, dynamic>? ?? {},
    );
  }

  CrewMember copyWith({
    String? uid,
    String? crewId,
    String? role,
    DateTime? joinedAt,
    String? status,
    Map<String, dynamic>? userSnapshot,
  }) {
    return CrewMember(
      uid: uid ?? this.uid,
      crewId: crewId ?? this.crewId,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
      status: status ?? this.status,
      userSnapshot: userSnapshot ?? this.userSnapshot,
    );
  }

  // Getters for convenience
  String get displayName => userSnapshot['displayName'] ?? '';
  String get avatarUrl => userSnapshot['avatarUrl'] ?? '';
  String get jobTitle => userSnapshot['jobTitle'] ?? '';
}

