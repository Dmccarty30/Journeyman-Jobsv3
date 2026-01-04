import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String authorId;
  final Map<String, dynamic> authorSnapshot; // { displayName, avatarUrl, role }
  final String content;
  final List<String> mediaUrls;
  final String type; // 'text', 'image', 'announcement'
  final DateTime createdAt;
  final Map<String, int> stats; // { likeCount, lolCount, dislikeCount, commentCount }

  Post({
    required this.id,
    required this.authorId,
    required this.authorSnapshot,
    required this.content,
    required this.mediaUrls,
    required this.type,
    required this.createdAt,
    required this.stats,
  });

  factory Post.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Post(
      id: doc.id,
      authorId: data['authorId'] ?? '',
      authorSnapshot: data['authorSnapshot'] as Map<String, dynamic>? ?? {},
      content: data['content'] ?? '',
      mediaUrls: List<String>.from(data['mediaUrls'] ?? []),
      type: data['type'] ?? 'text',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      stats: Map<String, int>.from(data['stats'] ?? {
        'likeCount': 0,
        'lolCount': 0,
        'dislikeCount': 0,
        'commentCount': 0,
      }),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'authorId': authorId,
      'authorSnapshot': authorSnapshot,
      'content': content,
      'mediaUrls': mediaUrls,
      'type': type,
      'createdAt': Timestamp.fromDate(createdAt),
      'stats': stats,
    };
  }

  Post copyWith({
    String? id,
    String? authorId,
    Map<String, dynamic>? authorSnapshot,
    String? content,
    List<String>? mediaUrls,
    String? type,
    DateTime? createdAt,
    Map<String, int>? stats,
  }) {
    return Post(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      authorSnapshot: authorSnapshot ?? this.authorSnapshot,
      content: content ?? this.content,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      stats: stats ?? this.stats,
    );
  }
}

class Reaction {
  final String userId; // Document ID
  final String type; // 'like', 'lol', 'dislike'
  final DateTime createdAt;
  final Map<String, dynamic> userSnapshot; // { displayName, avatarUrl }

  Reaction({
    required this.userId,
    required this.type,
    required this.createdAt,
    required this.userSnapshot,
  });

  factory Reaction.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Reaction(
      userId: doc.id,
      type: data['type'] ?? 'like',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      userSnapshot: data['userSnapshot'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'type': type,
      'createdAt': Timestamp.fromDate(createdAt),
      'userSnapshot': userSnapshot,
    };
  }
}

class PostComment {
  final String id;
  final String authorId;
  final Map<String, dynamic> authorSnapshot; // { displayName, avatarUrl }
  final String content;
  final DateTime createdAt;

  PostComment({
    required this.id,
    required this.authorId,
    required this.authorSnapshot,
    required this.content,
    required this.createdAt,
  });

  factory PostComment.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PostComment(
      id: doc.id,
      authorId: data['authorId'] ?? '',
      authorSnapshot: data['authorSnapshot'] as Map<String, dynamic>? ?? {},
      content: data['content'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'authorId': authorId,
      'authorSnapshot': authorSnapshot,
      'content': content,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
