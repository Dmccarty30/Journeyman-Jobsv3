import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a job that has been shared with a crew
class SharedJob {
  final String id;
  final DocumentReference jobReference; // Points to global /jobs/{jobId}
  final String sharedBy; // UID of the member who added it
  final DateTime addedAt;
  final String status; // 'new', 'bidding', 'in_progress', 'completed'
  final String crewNotes;
  final Map<String, dynamic> jobSnapshot; // { title, location, rate }

  const SharedJob({
    required this.id,
    required this.jobReference,
    required this.sharedBy,
    required this.addedAt,
    required this.status,
    required this.crewNotes,
    required this.jobSnapshot,
  });

  factory SharedJob.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SharedJob(
      id: doc.id,
      jobReference: data['jobReference'] as DocumentReference,
      sharedBy: data['sharedBy'] ?? '',
      addedAt: (data['addedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: data['status'] ?? 'new',
      crewNotes: data['crewNotes'] ?? '',
      jobSnapshot: data['jobSnapshot'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'jobReference': jobReference,
      'sharedBy': sharedBy,
      'addedAt': Timestamp.fromDate(addedAt),
      'status': status,
      'crewNotes': crewNotes,
      'jobSnapshot': jobSnapshot,
    };
  }

  SharedJob copyWith({
    String? id,
    DocumentReference? jobReference,
    String? sharedBy,
    DateTime? addedAt,
    String? status,
    String? crewNotes,
    Map<String, dynamic>? jobSnapshot,
  }) {
    return SharedJob(
      id: id ?? this.id,
      jobReference: jobReference ?? this.jobReference,
      sharedBy: sharedBy ?? this.sharedBy,
      addedAt: addedAt ?? this.addedAt,
      status: status ?? this.status,
      crewNotes: crewNotes ?? this.crewNotes,
      jobSnapshot: jobSnapshot ?? this.jobSnapshot,
    );
  }

  // Getters for convenience
  String get title => jobSnapshot['title'] ?? '';
  String get location => jobSnapshot['location'] ?? '';
  String get rate => jobSnapshot['rate'] ?? '';
}