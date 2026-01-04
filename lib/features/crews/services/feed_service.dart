import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

import '../../../domain/exceptions/app_exception.dart';
import '../models/post.dart';

class FeedService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Performance optimization constants
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Get Firestore instance
  FirebaseFirestore get firestore => _firestore;

  // Helper to get feed collection
  CollectionReference _feedCollection(String crewId) =>
      _firestore.collection('crews').doc(crewId).collection('feed');

  // Post CRUD Operations

  /// Create a new post in a crew's feed
  Future<String> createPost({
    required String crewId,
    required String authorId,
    required String content,
    Map<String, dynamic> authorSnapshot = const {},
    List<String> mediaUrls = const [],
    String type = 'text',
  }) async {
    try {
      // Validate input
      if (crewId.isEmpty) throw AppException('Crew ID cannot be empty');
      if (authorId.isEmpty) throw AppException('Author ID cannot be empty');
      if (content.trim().isEmpty)
        throw AppException('Post content cannot be empty');

      final postData = {
        'authorId': authorId,
        'authorSnapshot': authorSnapshot,
        'content': content.trim(),
        'mediaUrls': mediaUrls,
        'type': type,
        'createdAt': FieldValue.serverTimestamp(),
        'stats': {
          'likeCount': 0,
          'lolCount': 0,
          'dislikeCount': 0,
          'commentCount': 0,
        },
      };

      final docRef = await _feedCollection(crewId).add(postData);

      return docRef.id;
    } catch (e) {
      throw AppException('Failed to create post: $e');
    }
  }

  /// Get posts for a specific crew with pagination
  Stream<QuerySnapshot> getCrewPosts({
    required String crewId,
    int limit = defaultPageSize,
    DocumentSnapshot? startAfter,
  }) {
    // Enforce pagination limits for performance
    if (limit > maxPageSize) {
      limit = maxPageSize;
    }

    Query query = _feedCollection(crewId)
        .orderBy('createdAt', descending: true);

    // Always enforce pagination
    query = query.limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    return query.snapshots();
  }

  /// Get a single post by ID
  Future<Post?> getPost(String crewId, String postId) async {
    try {
      final doc = await _feedCollection(crewId).doc(postId).get();
      if (!doc.exists) return null;

      return Post.fromFirestore(doc);
    } catch (e) {
      throw AppException('Failed to get post: $e');
    }
  }

  /// Update a post's content
  Future<void> updatePost({
    required String crewId,
    required String postId,
    required String content,
    List<String>? mediaUrls,
  }) async {
    try {
      if (content.trim().isEmpty)
        throw AppException('Post content cannot be empty');

      final updateData = {
        'content': content.trim(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (mediaUrls != null) {
        updateData['mediaUrls'] = mediaUrls;
      }

      await _feedCollection(crewId).doc(postId).update(updateData);
    } catch (e) {
      throw AppException('Failed to update post: $e');
    }
  }

  /// Delete a post
  Future<void> deletePost(String crewId, String postId) async {
    try {
      await _feedCollection(crewId).doc(postId).delete();
    } catch (e) {
      throw AppException('Failed to delete post: $e');
    }
  }

  // Reactions

  /// Add or update a reaction to a post
  Future<void> addReaction({
    required String crewId,
    required String postId,
    required String userId,
    required String type,
    Map<String, dynamic> userSnapshot = const {},
  }) async {
    try {
      final postRef = _feedCollection(crewId).doc(postId);
      final reactionRef = postRef.collection('reactions').doc(userId);

      await _firestore.runTransaction((transaction) async {
        final reactionDoc = await transaction.get(reactionRef);
        final postDoc = await transaction.get(postRef);
        
        if (!postDoc.exists) throw AppException('Post not found');
        
        String? oldType;
        if (reactionDoc.exists) {
          final data = reactionDoc.data() as Map<String, dynamic>?;
          oldType = data?['type'] as String?;
        }
        
        // Update reaction document
        transaction.set(reactionRef, {
          'type': type,
          'createdAt': FieldValue.serverTimestamp(),
          'userSnapshot': userSnapshot,
        });

        // Update post stats
        final stats = Map<String, int>.from(
          (postDoc.data() as Map<String, dynamic>?)?['stats'] as Map<dynamic, dynamic>? ?? {}
        );
        
        if (oldType != null) {
          final oldKey = '${oldType}Count';
          stats[oldKey] = (stats[oldKey] ?? 1) - 1;
        }
        
        final newKey = '${type}Count';
        stats[newKey] = (stats[newKey] ?? 0) + 1;

        transaction.update(postRef, {'stats': stats});
      });
    } catch (e) {
      throw AppException('Failed to add reaction: $e');
    }
  }

  /// Remove a reaction from a post
  Future<void> removeReaction({
    required String crewId,
    required String postId,
    required String userId,
  }) async {
    try {
      final postRef = _feedCollection(crewId).doc(postId);
      final reactionRef = postRef.collection('reactions').doc(userId);

      await _firestore.runTransaction((transaction) async {
        final reactionDoc = await transaction.get(reactionRef);
        final postDoc = await transaction.get(postRef);
        
        if (!reactionDoc.exists || !postDoc.exists) return;
        
        final type = (reactionDoc.data() as Map<String, dynamic>?)?['type'] as String;
        
        transaction.delete(reactionRef);

        final stats = Map<String, int>.from(
          (postDoc.data() as Map<String, dynamic>?)?['stats'] as Map<dynamic, dynamic>? ?? {}
        );
        final key = '${type}Count';
        stats[key] = (stats[key] ?? 1) - 1;

        transaction.update(postRef, {'stats': stats});
      });
    } catch (e) {
      throw AppException('Failed to remove reaction: $e');
    }
  }

  // Comments

  /// Add a comment to a post
  Future<String> addComment({
    required String crewId,
    required String postId,
    required String authorId,
    required String content,
    Map<String, dynamic> authorSnapshot = const {},
  }) async {
    try {
      if (content.trim().isEmpty)
        throw AppException('Comment content cannot be empty');

      final postRef = _feedCollection(crewId).doc(postId);
      
      final commentData = {
        'authorId': authorId,
        'authorSnapshot': authorSnapshot,
        'content': content.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      };

      final commentRef = await postRef.collection('comments').add(commentData);

      // Update comment count on post
      await postRef.update({
        'stats.commentCount': FieldValue.increment(1),
      });

      return commentRef.id;
    } catch (e) {
      throw AppException('Failed to add comment: $e');
    }
  }

  /// Get comments for a post
  Stream<QuerySnapshot> getPostComments({
    required String crewId,
    required String postId,
    int limit = defaultPageSize,
  }) {
    return _feedCollection(crewId)
        .doc(postId)
        .collection('comments')
        .orderBy('createdAt', descending: false)
        .limit(limit)
        .snapshots();
  }

  /// Get reaction counts for a post from Firestore
  Future<Map<String, int>> getPostReactionCounts(String crewId, String postId) async {
    try {
      final doc = await _feedCollection(crewId).doc(postId).get();
      if (!doc.exists) return {};

      final data = doc.data() as Map<String, dynamic>;
      return Map<String, int>.from(data['stats'] ?? {});
    } catch (e) {
      throw AppException('Failed to get reaction counts: $e');
    }
  }

  /// Check if a user has reacted to a post with a specific type
  Future<bool> hasUserReacted(
      String crewId, String postId, String userId, String type) async {
    try {
      final doc = await _feedCollection(crewId).doc(postId).collection('reactions').doc(userId).get();
      if (!doc.exists) return false;

      final data = doc.data();
      return data?['type'] == type;
    } catch (e) {
      throw AppException('Failed to check user reaction: $e');
    }
  }
}
