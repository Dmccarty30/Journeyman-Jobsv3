import 'package:cloud_firestore/cloud_firestore.dart';
import '../crews.dart';

class TailboardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Helper to get crew doc
  DocumentReference _crewDoc(String crewId) => _firestore.collection('crews').doc(crewId);

  // Get job feed stream
  Stream<List<SharedJob>> getJobFeedStream(String crewId) {
    return _crewDoc(crewId)
        .collection('jobs')
        .orderBy('addedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => SharedJob.fromFirestore(doc)).toList();
    });
  }

  // Get activity stream
  Stream<List<ActivityItem>> getActivityStream(String crewId) {
    return _crewDoc(crewId)
        .collection('activity')
        .orderBy('timestamp', descending: true)
        .limit(50)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ActivityItem.fromFirestore(doc)).toList();
    });
  }

  // Get posts stream
  Stream<List<Post>> getPostsStream(String crewId) {
    return _crewDoc(crewId)
        .collection('feed')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Post.fromFirestore(doc)).toList();
    });
  }

  // Add a shared job to the feed
  Future<void> addSharedJob({
    required String crewId,
    required DocumentReference jobReference,
    required String sharedBy,
    required String crewNotes,
    required Map<String, dynamic> jobSnapshot,
  }) async {
    try {
      final sharedJob = SharedJob(
        id: '', 
        jobReference: jobReference,
        sharedBy: sharedBy,
        addedAt: DateTime.now(),
        status: 'new',
        crewNotes: crewNotes,
        jobSnapshot: jobSnapshot,
      );

      await _crewDoc(crewId)
          .collection('jobs')
          .add(sharedJob.toFirestore());
    } catch (e) {
      throw Exception('Error adding shared job: $e');
    }
  }

  // Add an activity item
  Future<void> addActivityItem({
    required String crewId,
    required String actorId,
    required ActivityType type,
    required Map<String, dynamic> data,
  }) async {
    try {
      final activityItem = ActivityItem(
        id: '',
        actorId: actorId,
        type: type,
        data: data,
        timestamp: DateTime.now(),
        readByMemberIds: [],
      );

      await _crewDoc(crewId)
          .collection('activity')
          .add(activityItem.toFirestore());
    } catch (e) {
      throw Exception('Error adding activity item: $e');
    }
  }

  // Mark activity as read by member
  Future<void> markActivityAsRead({
    required String crewId,
    required String activityId,
    required String memberId,
  }) async {
    try {
      final activityRef = _crewDoc(crewId).collection('activity').doc(activityId);
      await activityRef.update({
        'readByMemberIds': FieldValue.arrayUnion([memberId]),
      });
    } catch (e) {
      throw Exception('Error marking activity as read: $e');
    }
  }
}

