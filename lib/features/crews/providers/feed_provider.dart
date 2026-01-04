import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:state_notifier/state_notifier.dart';

import 'package:journeyman_jobs/core/core.dart' as core_providers;
import '../../auth/auth.dart'
    as auth_providers;
import '../crews.dart';

part 'feed_provider.g.dart';

/// FeedService provider
@Riverpod(keepAlive: true)
FeedService feedService(Ref ref) => FeedService();

/// Stream of posts for a specific crew
@riverpod
Stream<List<Post>> crewPostsStream(Ref ref, String crewId) {
  final currentUserId = ref.watch(auth_providers.currentUserIdProvider);
  if (currentUserId == null) return Stream.value([]);

  final feedService = ref.watch(feedServiceProvider);
  return feedService.getCrewPosts(crewId: crewId).map((snapshot) {
    return snapshot.docs.map((doc) => Post.fromFirestore(doc)).toList();
  }).distinct();
}

/// Posts for a specific crew
@riverpod
AsyncValue<List<Post>> crewPosts(Ref ref, String crewId) {
  final postsAsync = ref.watch(crewPostsStreamProvider(crewId));

  return postsAsync.when(
    data: (posts) {
      return AsyncValue.data(posts);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) {
      ref
          .read(core_providers.coreErrorReporterProvider)
          .report('crewPosts', error, stack, 'crewId: $crewId');
      return AsyncValue.error(error, stack);
    },
  );
}

/// Stream of comments for a specific post
@riverpod
Stream<List<PostComment>> postCommentsStream(Ref ref, String crewId, String postId) {
  final feedService = ref.watch(feedServiceProvider);
  return feedService.getPostComments(crewId: crewId, postId: postId).map((snapshot) {
    return snapshot.docs.map((doc) => PostComment.fromFirestore(doc)).toList();
  });
}

/// Comments for a specific post
@riverpod
AsyncValue<List<PostComment>> postComments(Ref ref, String crewId, String postId) {
  final commentsAsync = ref.watch(postCommentsStreamProvider(crewId, postId));

  return commentsAsync.when(
    data: (comments) => AsyncValue.data(comments),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) {
      ref
          .read(core_providers.coreErrorReporterProvider)
          .report('postComments', error, stack, 'postId: $postId');
      return AsyncValue.error(error, stack);
    },
  );
}

/// Provider to get posts for selected crew
@riverpod
AsyncValue<List<Post>> selectedCrewPosts(Ref ref) {
  final selectedCrew = ref.watch(core_providers.selectedCrewProvider);
  if (selectedCrew == null) return const AsyncValue.data([]);

  return ref.watch(crewPostsProvider(selectedCrew.id));
}

/// Provider to get pinned posts for a crew
@riverpod
AsyncValue<List<Post>> pinnedPosts(Ref ref, String crewId) {
  final postsAsync = ref.watch(crewPostsProvider(crewId));
  // Note: For now, return empty list or filter if field exists
  return postsAsync.when(
    data: (_) => const AsyncValue.data([]),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
}

/// Provider to get recent posts for a crew
@riverpod
AsyncValue<List<Post>> recentPosts(Ref ref, String crewId) {
  final postsAsync = ref.watch(crewPostsProvider(crewId));
  return postsAsync.when(
    data: (posts) => AsyncValue.data(
        posts..sort((a, b) => b.createdAt.compareTo(a.createdAt))),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
}

/// Notifier for post creation
class PostCreationNotifier extends StateNotifier<AsyncValue<String?>> {
  PostCreationNotifier(this._ref) : super(const AsyncValue.data(null));

  final Ref _ref;

  Future<void> createPost({
    required String crewId,
    required String content,
    List<String> mediaUrls = const [],
    String type = 'text',
  }) async {
    final currentUser = _ref.read(auth_providers.currentUserProvider);
    if (currentUser == null) {
      state = const AsyncValue.error('User not authenticated', StackTrace.empty);
      return;
    }

    state = const AsyncValue.loading();
    try {
      final feedService = _ref.read(feedServiceProvider);
      // Construct author snapshot
      final authorSnapshot = {
        'displayName': currentUser.displayName ?? currentUser.email?.split('@')[0] ?? 'User',
        'avatarUrl': currentUser.photoURL,
        'role': 'Member', // This should be fetched from crew member doc
      };

      final postId = await feedService.createPost(
        crewId: crewId,
        authorId: currentUser.uid,
        authorSnapshot: authorSnapshot,
        content: content,
        mediaUrls: mediaUrls,
        type: type,
      );
      state = AsyncValue.data(postId);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

/// Provider for post creation notifier
@riverpod
PostCreationNotifier postCreationNotifier(Ref ref) {
  return PostCreationNotifier(ref);
}

/// Stream of post creation state
@riverpod
AsyncValue<String?> postCreationState(Ref ref) {
  return ref.watch(postCreationStateProvider);
}

/// Notifier for post updates
class PostUpdateNotifier extends StateNotifier<AsyncValue<void>> {
  PostUpdateNotifier(this._ref) : super(const AsyncValue.data(null));

  final Ref _ref;

  Future<void> updatePost({
    required String crewId,
    required String postId,
    required String content,
    List<String>? mediaUrls,
  }) async {
    final currentUser = _ref.read(auth_providers.currentUserProvider);
    if (currentUser == null) {
      state = const AsyncValue.error('User not authenticated', StackTrace.empty);
      return;
    }

    state = const AsyncValue.loading();
    try {
      final feedService = _ref.read(feedServiceProvider);
      await feedService.updatePost(
        crewId: crewId,
        postId: postId,
        content: content,
        mediaUrls: mediaUrls,
      );
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> deletePost({required String crewId, required String postId}) async {
    state = const AsyncValue.loading();
    try {
      final feedService = _ref.read(feedServiceProvider);
      await feedService.deletePost(crewId, postId);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

/// Provider for post update notifier
@riverpod
PostUpdateNotifier postUpdateNotifier(Ref ref) {
  return PostUpdateNotifier(ref);
}

/// Stream of post update state
@riverpod
AsyncValue<void> postUpdateState(Ref ref) {
  return ref.watch(postUpdateStateProvider);
}

/// Notifier for reactions
class ReactionNotifier extends StateNotifier<AsyncValue<void>> {
  ReactionNotifier(this._ref) : super(const AsyncValue.data(null));

  final Ref _ref;

  Future<void> addReaction({
    required String crewId,
    required String postId,
    required String type,
  }) async {
    final currentUser = _ref.read(auth_providers.currentUserProvider);
    if (currentUser == null) {
      state = const AsyncValue.error('User not authenticated', StackTrace.empty);
      return;
    }

    state = const AsyncValue.loading();
    try {
      final feedService = _ref.read(feedServiceProvider);
      final userSnapshot = {
        'displayName': currentUser.displayName ?? 'User',
        'avatarUrl': currentUser.photoURL,
      };

      await feedService.addReaction(
        crewId: crewId,
        postId: postId,
        userId: currentUser.uid,
        type: type,
        userSnapshot: userSnapshot,
      );
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> removeReaction({required String crewId, required String postId}) async {
    final currentUser = _ref.read(auth_providers.currentUserProvider);
    if (currentUser == null) {
      state = const AsyncValue.error('User not authenticated', StackTrace.empty);
      return;
    }

    state = const AsyncValue.loading();
    try {
      final feedService = _ref.read(feedServiceProvider);
      await feedService.removeReaction(
        crewId: crewId,
        postId: postId,
        userId: currentUser.uid,
      );
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

/// Provider for reaction notifier
@riverpod
ReactionNotifier reactionNotifier(Ref ref) {
  return ReactionNotifier(ref);
}

/// Stream of reaction state
@riverpod
AsyncValue<void> reactionState(Ref ref) {
  return ref.watch(reactionStateProvider);
}

/// Notifier for comments
class CommentNotifier extends StateNotifier<AsyncValue<String?>> {
  CommentNotifier(this._ref) : super(const AsyncValue.data(null));

  final Ref _ref;

  Future<void> addComment({
    required String crewId,
    required String postId,
    required String content,
  }) async {
    final currentUser = _ref.read(auth_providers.currentUserProvider);
    if (currentUser == null) {
      state = const AsyncValue.error('User not authenticated', StackTrace.empty);
      return;
    }

    state = const AsyncValue.loading();
    try {
      final feedService = _ref.read(feedServiceProvider);
      final authorSnapshot = {
        'displayName': currentUser.displayName ?? 'User',
        'avatarUrl': currentUser.photoURL,
      };

      final commentId = await feedService.addComment(
        crewId: crewId,
        postId: postId,
        authorId: currentUser.uid,
        authorSnapshot: authorSnapshot,
        content: content,
      );
      state = AsyncValue.data(commentId);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

/// Provider for comment notifier
@riverpod
CommentNotifier commentNotifier(Ref ref) {
  return CommentNotifier(ref);
}

/// Stream of comment state
@riverpod
AsyncValue<String?> commentState(Ref ref) {
  return ref.watch(commentStateProvider);
}

/// Provider to get crew post statistics
@riverpod
Future<Map<String, dynamic>> crewPostStats(Ref ref, String crewId) async {
  final feedService = ref.watch(feedServiceProvider);
  // Note: This method needs to be refactored in FeedService if needed, 
  // for now returning empty map to avoid build errors if not yet implemented.
  return {}; 
}

/// Provider to get reaction counts for a post
@riverpod
Future<Map<String, int>> postReactionCounts(
    Ref ref, String crewId, String postId) async {
  try {
    return await ref.watch(feedServiceProvider).getPostReactionCounts(crewId, postId);
  } catch (e, stack) {
    ref
        .read(core_providers.coreErrorReporterProvider)
        .report('postReactionCounts', e, stack, 'postId: $postId');
    rethrow;
  }
}

/// Provider to check if current user has reacted to a post
@riverpod
Future<bool> userReactionToPost(
    Ref ref, String crewId, String postId, String type) async {
  final currentUser = ref.watch(auth_providers.currentUserIdProvider);
  if (currentUser == null) return false;

  try {
    return await ref.watch(feedServiceProvider).hasUserReacted(
          crewId,
          postId,
          currentUser,
          type,
        );
  } catch (e, stack) {
    ref.read(core_providers.coreErrorReporterProvider).report(
        'userReactionToPost',
        e,
        stack,
        'postId: $postId, type: $type');
    rethrow;
  }
}



