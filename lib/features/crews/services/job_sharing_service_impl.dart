import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../crews.dart';

class JobSharingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  JobSharingService();

  /// Share a job with specific crews
  Future<void> shareToCrews({
    required DocumentReference jobReference,
    required List<String> crewIds,
    required String sharedBy,
    required String crewNotes,
    required Map<String, dynamic> jobSnapshot,
  }) async {
    try {
      final batch = _firestore.batch();
      final now = DateTime.now();

      for (final crewId in crewIds) {
        // Create shared job document in 'jobs' subcollection
        final sharedJobRef = _firestore
            .collection('crews')
            .doc(crewId)
            .collection('jobs')
            .doc();

        final sharedJobData = {
          'jobReference': jobReference,
          'sharedBy': sharedBy,
          'addedAt': Timestamp.fromDate(now),
          'status': 'new', // new, bidding, in_progress, completed
          'crewNotes': crewNotes,
          'jobSnapshot': jobSnapshot,
        };

        batch.set(sharedJobRef, sharedJobData);

        // Add to crew's activity feed
        final activityRef = _firestore
            .collection('crews')
            .doc(crewId)
            .collection('activity')
            .doc();

        final activityData = {
          'id': activityRef.id,
          'type': 'job_shared',
          'actorId': sharedBy,
          'data': {
            'jobTitle': jobSnapshot['title'] ?? 'a job',
            'crewNotes': crewNotes,
          },
          'timestamp': Timestamp.fromDate(now),
          'readByMemberIds': [],
        };

        batch.set(activityRef, activityData);
      }

      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }

  /// Get shared jobs for a crew
  Stream<List<SharedJob>> getSharedJobsStream(String crewId) {
    return _firestore
        .collection('crews')
        .doc(crewId)
        .collection('jobs')
        .orderBy('addedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => SharedJob.fromFirestore(doc)).toList();
    });
  }

  /// Get sharing analytics for a crew
  Future<Map<String, dynamic>> getCrewSharingAnalytics(String crewId) async {
    // This would need to be updated to match the new stats logic
    return {};
  }
}
