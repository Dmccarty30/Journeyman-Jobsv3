import 'package:cloud_firestore/cloud_firestore.dart';

enum ActivityType {
  memberJoined,
  memberLeft,
  jobShared,
  jobApplied,
  announcementPosted,
  milestoneReached
}

class ActivityItem {
  final String id;
  final String actorId;                // User who performed action
  final ActivityType type;             // Type of activity
  final Map<String, dynamic> data;     // Activity-specific data
  final DateTime timestamp;             // When it happened
  final List<String> readByMemberIds;  // Who has seen it

  ActivityItem({
    required this.id,
    required this.actorId,
    required this.type,
    required this.data,
    required this.timestamp,
    required this.readByMemberIds,
  });

  factory ActivityItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ActivityItem(
      id: doc.id,
      actorId: data['actorId'] ?? '',
      type: ActivityType.values.firstWhere(
        (t) => t.toString().split('.').last == (data['type'] ?? 'memberJoined'),
        orElse: () => ActivityType.memberJoined,
      ),
      data: Map<String, dynamic>.from(data['data'] ?? {}),
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      readByMemberIds: List<String>.from(data['readByMemberIds'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'actorId': actorId,
      'type': type.toString().split('.').last,
      'data': data,
      'timestamp': Timestamp.fromDate(timestamp),
      'readByMemberIds': readByMemberIds,
    };
  }

  ActivityItem copyWith({
    String? id,
    String? actorId,
    ActivityType? type,
    Map<String, dynamic>? data,
    DateTime? timestamp,
    List<String>? readByMemberIds,
  }) {
    return ActivityItem(
      id: id ?? this.id,
      actorId: actorId ?? this.actorId,
      type: type ?? this.type,
      data: data ?? this.data,
      timestamp: timestamp ?? this.timestamp,
      readByMemberIds: readByMemberIds ?? this.readByMemberIds,
    );
  }
}

// Tailboard aggregates the state for the UI
class Tailboard {
  final String crewId;
  final DateTime lastUpdated;

  Tailboard({
    required this.crewId,
    required this.lastUpdated,
  });

  factory Tailboard.fromMap(Map<String, dynamic> map) {
    return Tailboard(
      crewId: map['crewId'] ?? '',
      lastUpdated: map['lastUpdated'] != null
          ? DateTime.parse(map['lastUpdated'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'crewId': crewId,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}