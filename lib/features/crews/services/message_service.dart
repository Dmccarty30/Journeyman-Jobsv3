import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message.dart';

class MessageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Initialization
  MessageService();

  // Helper to get chat collection
  CollectionReference _chatCollection(String crewId, String channelId) =>
      _firestore.collection('crews').doc(crewId).collection('chat').doc(channelId).collection('messages');

  // Send a crew message
  Future<void> sendCrewMessage({
    required String crewId,
    required String channelId,
    required String senderId,
    required String content,
    Map<String, dynamic> senderSnapshot = const {},
    String type = 'text',
  }) async {
    try {
      final messageData = {
        'senderId': senderId,
        'senderSnapshot': senderSnapshot,
        'content': content,
        'type': type,
        'sentAt': FieldValue.serverTimestamp(),
      };

      await _chatCollection(crewId, channelId).add(messageData);
      
      // Update last message in channel
      await _firestore.collection('crews').doc(crewId).collection('chat').doc(channelId).set({
        'lastMessage': {
          'text': content,
          'author': senderSnapshot['displayName'] ?? senderId,
          'time': FieldValue.serverTimestamp(),
        }
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Error sending crew message: $e');
    }
  }

  // Get crew messages stream
  Stream<List<Message>> getCrewMessagesStream(String crewId, String channelId) {
    return _chatCollection(crewId, channelId)
        .orderBy('sentAt', descending: true)
        .limit(100)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList();
    });
  }

  // Get chat channels for a crew
  Stream<List<ChatChannel>> getCrewChannelsStream(String crewId) {
    return _firestore
        .collection('crews')
        .doc(crewId)
        .collection('chat')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ChatChannel.fromFirestore(doc)).toList();
    });
  }

  // Get recent messages for a user across all their crews
  Future<List<Message>> getRecentMessagesAcrossCrews({
    required String userId,
    required List<String> crewIds,
    int limit = 20,
  }) async {
    try {
      final List<Message> recentMessages = [];

      for (final crewId in crewIds) {
        // Assume 'general' channel for now
        final messagesSnapshot = await _chatCollection(crewId, 'general')
            .orderBy('sentAt', descending: true)
            .limit(5)
            .get();

        for (final messageDoc in messagesSnapshot.docs) {
          recentMessages.add(Message.fromFirestore(messageDoc));
        }
      }

      recentMessages.sort((a, b) => b.sentAt.compareTo(a.sentAt));
      return recentMessages.take(limit).toList();
    } catch (e) {
      return [];
    }
  }
}
