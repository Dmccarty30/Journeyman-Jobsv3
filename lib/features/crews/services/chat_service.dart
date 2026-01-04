import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Get Firestore collections
  CollectionReference get crewsCollection => _firestore.collection('crews');

  // Get or create channels for a crew
  Future<List<ChatChannel>> getChannels(String crewId) async {
    try {
      final channelsSnapshot = await crewsCollection
          .doc(crewId)
          .collection('chat')
          .get();

      final channels = channelsSnapshot.docs.map((doc) => ChatChannel.fromFirestore(doc)).toList();

      // If no channels exist, create a default 'general' channel
      if (channels.isEmpty) {
        final channelRef = crewsCollection.doc(crewId).collection('chat').doc('general');
        await channelRef.set({
          'name': 'General',
          'lastMessage': null,
        });

        channels.add(ChatChannel(
          id: 'general',
          name: 'General',
        ));
      }

      return channels;
    } catch (e) {
      throw Exception('Error getting channels: $e');
    }
  }

  // Create a new channel
  Future<String> createChannel({
    required String crewId,
    required String name,
  }) async {
    try {
      final channelId = name.toLowerCase().replaceAll(' ', '_');
      await crewsCollection
          .doc(crewId)
          .collection('chat')
          .doc(channelId)
          .set({
        'name': name,
        'lastMessage': null,
      });

      return channelId;
    } catch (e) {
      throw Exception('Error creating channel: $e');
    }
  }

  // Get messages stream for a specific channel
  Stream<List<Message>> getChannelMessagesStream(String crewId, String channelId, {int limit = 50}) {
    return crewsCollection
        .doc(crewId)
        .collection('chat')
        .doc(channelId)
        .collection('messages')
        .orderBy('sentAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList());
  }

  // Send a message to a channel
  Future<String> sendMessageToChannel({
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

      final docRef = await crewsCollection
          .doc(crewId)
          .collection('chat')
          .doc(channelId)
          .collection('messages')
          .add(messageData);

      // Update last message in channel
      await crewsCollection.doc(crewId).collection('chat').doc(channelId).update({
        'lastMessage': {
          'text': content,
          'author': senderSnapshot['displayName'] ?? senderId,
          'time': FieldValue.serverTimestamp(),
        }
      });

      return docRef.id;
    } catch (e) {
      throw Exception('Error sending message: $e');
    }
  }
}

