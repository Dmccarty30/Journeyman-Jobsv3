import 'package:cloud_firestore/cloud_firestore.dart';

class ChatChannel {
  final String id;
  final String name;
  final Map<String, dynamic>? lastMessage; // { text, author, time }

  ChatChannel({
    required this.id,
    required this.name,
    this.lastMessage,
  });

  factory ChatChannel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatChannel(
      id: doc.id,
      name: data['name'] ?? '',
      lastMessage: data['lastMessage'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'lastMessage': lastMessage,
    };
  }
}

class Message {
  final String id;
  final String senderId;
  final Map<String, dynamic> senderSnapshot; // { displayName, avatarUrl, role }
  final String content;
  final String type; // 'text', 'image', 'location'
  final DateTime sentAt;

  Message({
    required this.id,
    required this.senderId,
    required this.senderSnapshot,
    required this.content,
    required this.type,
    required this.sentAt,
  });

  factory Message.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Message(
      id: doc.id,
      senderId: data['senderId'] ?? '',
      senderSnapshot: data['senderSnapshot'] as Map<String, dynamic>? ?? {},
      content: data['content'] ?? '',
      type: data['type'] ?? 'text',
      sentAt: (data['sentAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'senderId': senderId,
      'senderSnapshot': senderSnapshot,
      'content': content,
      'type': type,
      'sentAt': Timestamp.fromDate(sentAt),
    };
  }

  Message copyWith({
    String? id,
    String? senderId,
    Map<String, dynamic>? senderSnapshot,
    String? content,
    String? type,
    DateTime? sentAt,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      senderSnapshot: senderSnapshot ?? this.senderSnapshot,
      content: content ?? this.content,
      type: type ?? this.type,
      sentAt: sentAt ?? this.sentAt,
    );
  }
}