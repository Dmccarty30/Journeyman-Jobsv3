import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../auth/auth.dart';
import '../models/post.dart';
import '../models/shared_job.dart';
import '../models/tailboard.dart';
import '../services/tailboard_service.dart';

part 'tailboard_riverpod_provider.g.dart';

/// TailboardService provider
@riverpod
TailboardService tailboardService(Ref ref) => TailboardService();


/// Stream of suggested jobs for a specific crew
@riverpod
Stream<List<SharedJob>> suggestedJobsStream(Ref ref, String crewId) {
  final tailboardService = ref.watch(tailboardServiceProvider);
  return tailboardService
      .getJobFeedStream(crewId)
      .distinct();
}

/// Suggested jobs for a specific crew
@riverpod
List<SharedJob> suggestedJobs(Ref ref, String crewId) {
  final jobsAsync = ref.watch(suggestedJobsStreamProvider(crewId));
  
  return jobsAsync.when(
    data: (jobs) => jobs,
    loading: () => [],
    error: (_, __) => [],
  );
}

/// Stream of activity items for a specific crew
@riverpod
Stream<List<ActivityItem>> activityItemsStream(Ref ref, String crewId) {
  return ref
      .watch(tailboardServiceProvider)
      .getActivityStream(crewId)
      .distinct();
}

/// Activity items for a specific crew
@riverpod
List<ActivityItem> activityItems(Ref ref, String crewId) {
  final activitiesAsync = ref.watch(activityItemsStreamProvider(crewId));
  
  return activitiesAsync.when(
    data: (activities) => activities,
    loading: () => [],
    error: (_, __) => [],
  );
}

/// Stream of tailboard posts for a specific crew
@riverpod
Stream<List<Post>> tailboardPostsStream(Ref ref, String crewId) {
  final tailboardService = ref.watch(tailboardServiceProvider);
  return tailboardService.getPostsStream(crewId);
}

/// Tailboard posts for a specific crew
@riverpod
List<Post> tailboardPosts(Ref ref, String crewId) {
  final postsAsync = ref.watch(tailboardPostsStreamProvider(crewId));
  
  return postsAsync.when(
    data: (posts) => posts,
    loading: () => [],
    error: (_, __) => [],
  );
}

/// Provider to get unread activity items count for current user
@riverpod
int unreadActivityCount(Ref ref, String crewId) {
  final currentUser = ref.watch(currentUserProvider);
  final activities = ref.watch(activityItemsProvider(crewId));
  
  if (currentUser == null) return 0;
  
  return activities.where((activity) {
    return !activity.readByMemberIds.contains(currentUser.uid);
  }).length;
}

/// Provider to get pinned posts for a specific crew
@riverpod
List<Post> pinnedPosts(Ref ref, String crewId) {
  final posts = ref.watch(tailboardPostsProvider(crewId));
  // Post model doesn't have isPinned yet in the new schema, returning empty
  return [];
}

/// Provider to get recent posts for a specific crew
@riverpod
List<Post> recentPosts(Ref ref, String crewId) {
  final posts = ref.watch(tailboardPostsProvider(crewId));
  return posts;
}

/// Provider to get posts by a specific author
@riverpod
List<Post> postsByAuthor(Ref ref, String crewId, String authorId) {
  final posts = ref.watch(tailboardPostsProvider(crewId));
  return posts.where((post) => post.authorId == authorId).toList();
}

/// Provider to get activity by type
@riverpod
List<ActivityItem> activitiesByType(Ref ref, String crewId, ActivityType type) {
  final activities = ref.watch(activityItemsProvider(crewId));
  return activities.where((activity) => activity.type == type).toList();
}

/// Provider to get recent activities (last 7 days)
@riverpod
List<ActivityItem> recentActivities(Ref ref, String crewId) {
  final activities = ref.watch(activityItemsProvider(crewId));
  final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
  
  return activities.where((activity) {
    return activity.timestamp.isAfter(sevenDaysAgo);
  }).toList();
}

/// Provider to get activities by actor
@riverpod
List<ActivityItem> activitiesByActor(Ref ref, String crewId, String actorId) {
  final activities = ref.watch(activityItemsProvider(crewId));
  return activities.where((activity) => activity.actorId == actorId).toList();
}
