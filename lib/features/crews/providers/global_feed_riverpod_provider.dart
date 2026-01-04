// lib/providers/riverpod/global_feed_riverpod_provider.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../crews.dart';
import '../../auth/auth.dart';

part 'global_feed_riverpod_provider.g.dart';
/// Stream of global messages
@riverpod
Stream<List<Message>> globalMessagesStream(Ref ref) {
  return FirebaseFirestore.instance
      .collection('global_messages')
      .orderBy('sentAt', descending: true)
      .limit(50)
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList();
      });
}

/// Global messages
@riverpod
List<Message> globalMessages(Ref ref) {
  final messagesAsync = ref.watch(globalMessagesStreamProvider);
  
  return messagesAsync.when(
    data: (messages) => messages,
    loading: () => [],
    error: (_, __) => [],
  );
}

/// Provider to send a global message
@riverpod
class SendGlobalMessageNotifier extends _$SendGlobalMessageNotifier {
  @override
  void build() {} // No initial state needed for a method provider

  Future<void> sendGlobalMessage(String text) async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) {
      throw Exception('User not authenticated to send global message.');
    }

    try {
      await FirebaseFirestore.instance.collection('global_messages').add({
        'content': text,
        'senderId': currentUser.uid,
        'senderSnapshot': {
          'displayName': currentUser.displayName ?? 'User',
          'avatarUrl': currentUser.photoURL,
        },
        'sentAt': FieldValue.serverTimestamp(),
        'type': 'text',
      });
    } catch (e) {
      rethrow;
    }
  }
}

/// Provider to get unread global messages count
@riverpod
int unreadGlobalCount(Ref ref) {
  return 0; // Simplified for now
}


