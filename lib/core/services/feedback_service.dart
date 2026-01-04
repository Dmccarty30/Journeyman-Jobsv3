import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:journeyman_jobs/features/jobs/profile/profile.dart';

class FeedbackService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addFeedback(UserFeedback feedback) async {
    try {
      await _firestore.collection('feedback').add(feedback.toFirestore());
    } catch (e) {
      // In a real app, you'd have more robust error handling and logging.
      print('Error submitting feedback: $e');
      rethrow;
    }
  }
}
