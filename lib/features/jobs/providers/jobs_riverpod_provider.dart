import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:journeyman_jobs/utils/concurrent_operations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../jobs.dart';
import 'package:journeyman_jobs/core/core.dart' hide OperationType;
import '../profile/profile.dart';
import '../../auth/providers/auth_riverpod_provider.dart';

import '../utils/filter_performance.dart';
import '../utils/memory_management.dart';
import '../../../core/providers/riverpod/local_ai_model_provider.dart';

part 'jobs_riverpod_provider.g.dart';

/// Jobs state model for Riverpod
class JobsState {
  const JobsState({
    this.jobs = const <Job>[],
    this.visibleJobs = const <Job>[],
    this.activeFilter = const JobFilterCriteria(),
    this.isLoading = false,
    this.error,
    this.hasMoreJobs = true,
    this.lastDocument,
    this.loadTimes = const <Duration>[],
    this.totalJobsLoaded = 0,
  });
  final List<Job> jobs;
  final List<Job> visibleJobs;
  final JobFilterCriteria activeFilter;
  final bool isLoading;
  final String? error;
  final bool hasMoreJobs;
  final DocumentSnapshot? lastDocument;
  final List<Duration> loadTimes;
  final int totalJobsLoaded;

  JobsState copyWith({
    List<Job>? jobs,
    List<Job>? visibleJobs,
    JobFilterCriteria? activeFilter,
    bool? isLoading,
    String? error,
    bool? hasMoreJobs,
    DocumentSnapshot? lastDocument,
    List<Duration>? loadTimes,
    int? totalJobsLoaded,
  }) =>
      JobsState(
        jobs: jobs ?? this.jobs,
        visibleJobs: visibleJobs ?? this.visibleJobs,
        activeFilter: activeFilter ?? this.activeFilter,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        hasMoreJobs: hasMoreJobs ?? this.hasMoreJobs,
        lastDocument: lastDocument ?? this.lastDocument,
        loadTimes: loadTimes ?? this.loadTimes,
        totalJobsLoaded: totalJobsLoaded ?? this.totalJobsLoaded,
      );

  JobsState clearError() => copyWith();
}

/// Firestore service provider
@riverpod
ResilientFirestoreService firestoreService(Ref ref) =>
    ResilientFirestoreService();

/// Feedback service provider
@riverpod
FeedbackService feedbackService(Ref ref) => FeedbackService();

/// User Preference Service provider
@riverpod
UserPreferenceService userPreferenceService(Ref ref) => UserPreferenceService();

/// Jobs notifier for managing job data and operations
@riverpod
class JobsNotifier extends _$JobsNotifier {
  late final ConcurrentOperationManager _operationManager;
  late final FilterPerformanceEngine _filterEngine;
  late final BoundedJobList _boundedJobList;

  @override
  JobsState build() {
    _operationManager = ConcurrentOperationManager();
    _filterEngine = FilterPerformanceEngine();
    _boundedJobList = BoundedJobList(maxSize: 1000);

    return const JobsState();
  }

  /// Load jobs with pagination
  Future<void> loadJobs({
    JobFilterCriteria? filter,
    bool isRefresh = false,
    int limit = 20,
  }) async {
    if (_operationManager.isOperationInProgress(OperationType.loadJobs)) {
      return;
    }

    if (kDebugMode) {
      debugPrint(
          '[DEBUG] JobsNotifier.loadJobs called - isRefresh: $isRefresh, filter: ${filter?.toString()}, limit: $limit');
    }

    if (isRefresh) {
      state = state.copyWith(
        jobs: <Job>[],
        visibleJobs: <Job>[],
        hasMoreJobs: true,
        isLoading: true,
      );
    } else {
      state = state.copyWith(isLoading: true);
    }

    final Stopwatch stopwatch = Stopwatch()..start();

    try {
      final result = await _operationManager.executeOperation(
        type: OperationType.loadJobs,
        operation: () async {
          final firestoreService = ref.read(firestoreServiceProvider);
          if (kDebugMode) debugPrint('[DEBUG] Calling Firestore service...');

          if (filter != null) {
            return await firestoreService.getJobsWithFilter(
              filter: filter,
              startAfter: isRefresh ? null : state.lastDocument,
              limit: limit,
            );
          } else {
            if (kDebugMode) debugPrint('[DEBUG] Using basic jobs query');
            final stream = firestoreService.getJobs(
              startAfter: isRefresh ? null : state.lastDocument,
              limit: limit,
            );
            return await stream.first;
          }
        },
      );

      stopwatch.stop();
      if (kDebugMode) {
        debugPrint(
            '[DEBUG] Query completed in ${stopwatch.elapsedMilliseconds}ms');
        debugPrint('[DEBUG] Documents received: ${result.docs.length}');
      }

      if (result.docs.isNotEmpty) {
        if (kDebugMode) {
          debugPrint('[DEBUG] Sample document ID: ${result.docs.first.id}');
          debugPrint(
              '[DEBUG] Sample document data keys: ${(result.docs.first.data() as Map<String, dynamic>).keys.toList()}');
          debugPrint('[DEBUG] Sample raw data: ${result.docs.first.data()}');
        }
      }

      // Convert QuerySnapshot to Job objects
      final jobs = result.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        if (kDebugMode) {
          debugPrint(
              '[DEBUG] Parsing job ${doc.id}: raw hours=${data['hours']}, wage=${data['wage']}, perDiem=${data['perDiem']}, startDate=${data['startDate']}');
        }
        final job = Job.fromJson(data);
        if (kDebugMode) {
          debugPrint(
              '[DEBUG] Parsed job ${doc.id}: hours=${job.hours}, wage=${job.wage}, perDiem=${job.perDiem}, startDate=${job.startDate}');
        }
        return job;
      }).toList();

      if (kDebugMode) {
        debugPrint('[DEBUG] Successfully parsed ${jobs.length} jobs');
      }

      // Update state with the new jobs
      final List<Job> updatedJobs = isRefresh ? jobs : [...state.jobs, ...jobs];

      // Update load times for performance tracking
      final List<Duration> newLoadTimes = List<Duration>.from(state.loadTimes)
        ..add(stopwatch.elapsed);
      if (newLoadTimes.length > 50) {
        newLoadTimes.removeAt(0); // Keep only last 50 measurements
      }

      // Update bounded list
      if (isRefresh) {
        _boundedJobList.clear();
      }
      _boundedJobList.addAll(updatedJobs);

      state = state.copyWith(
        jobs: updatedJobs,
        visibleJobs: updatedJobs, // For now, all jobs are visible
        activeFilter: filter ?? state.activeFilter,
        isLoading: false,
        hasMoreJobs: jobs.length >= limit, // Assume more if we got a full page
        lastDocument: result.docs.isNotEmpty ? result.docs.last : null,
        loadTimes: newLoadTimes,
        totalJobsLoaded: updatedJobs.length,
      );
      if (kDebugMode) {
        debugPrint('[DEBUG] State updated - total jobs: ${updatedJobs.length}');
      }

      // After loading jobs, check for matches and notify
      await checkForNewJobMatches(jobs);
    } catch (e) {
      stopwatch.stop();
      if (kDebugMode) debugPrint('[DEBUG] LoadJobs ERROR: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  /// Apply filter to jobs
  Future<void> applyFilter(JobFilterCriteria filter) async {
    if (_operationManager.isOperationInProgress(OperationType.loadJobs)) {
      return;
    }

    try {
      // Store the filter and reload jobs
      state = state.copyWith(activeFilter: filter);

      final Stopwatch filterTimer = _filterEngine.startMeasure();

      await _operationManager.executeOperation(
        type: OperationType.loadJobs,
        operation: () => loadJobs(filter: filter, isRefresh: true),
      );

      _filterEngine.stopMeasure('applyFilter', filterTimer);
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  /// Load more jobs (pagination)
  Future<void> loadMoreJobs() async {
    if (!state.hasMoreJobs || state.isLoading) {
      return;
    }

    await loadJobs();
  }

  /// Refresh jobs
  Future<void> refreshJobs() async {
    await loadJobs(isRefresh: true);
  }

  /// Update visible jobs for virtual scrolling
  void updateVisibleJobsRange(int startIndex, int endIndex) {
    // Basic implementation: filter the visible jobs based on the range
    if (startIndex < 0 || endIndex < 0 || startIndex > endIndex) {
      return;
    }

    final List<Job> visibleJobs;
    if (startIndex >= state.jobs.length) {
      visibleJobs = <Job>[];
    } else {
      final safeEndIndex =
          endIndex >= state.jobs.length ? state.jobs.length - 1 : endIndex;
      visibleJobs = state.jobs.sublist(startIndex, safeEndIndex + 1);
    }

    state = state.copyWith(visibleJobs: visibleJobs);
  }

  /// Get job by ID
  Job? getJobById(String jobId) {
    try {
      return state.jobs.firstWhere((Job job) => job.id == jobId);
    } catch (e) {
      return null;
    }
  }

  /// Checks newly loaded jobs against user preferences and triggers notifications for matches.
  Future<void> checkForNewJobMatches(List<Job> newJobs) async {
    if (kDebugMode) {
      debugPrint('[DEBUG] Checking ${newJobs.length} new jobs for matches...');
    }

    final String? userId = ref.read(currentUserIdProvider);
    if (userId == null) {
      if (kDebugMode) debugPrint('[DEBUG] No user ID found for matching.');
      return;
    }

    final UserPreferenceService preferenceService =
        ref.read(userPreferenceServiceProvider);
    final LocalModelService localModelService =
        ref.read(localModelServiceProvider);

    final Map<String, dynamic> userPreferences =
        await preferenceService.getUserPreferences(userId) ?? {};

    if (kDebugMode) {
      debugPrint('[DEBUG] User preferences for matching: $userPreferences');
    }

    for (final job in newJobs) {
      // Basic preference check
      bool fitsBasicCriteria = true;
      if (userPreferences.containsKey('minWage') &&
          job.wage != null &&
          job.wage! < (userPreferences['minWage'] as num)) {
        fitsBasicCriteria = false;
      }

      if (fitsBasicCriteria) {
        // AI match
        // Assuming user has 'skills' in shared preferences or part of user model usually.
        // For now, passing empty skills list as placeholder if not in preferences.
        final List<String> userSkills =
            (userPreferences['skills'] as List<dynamic>?)?.cast<String>() ?? [];

        final double matchScore =
            await localModelService.matchUserExperienceToPreferences(
          jobDescription: job.jobDescription ?? job.jobTitle ?? '',
          userPreferences: userPreferences,
          userSkills: userSkills,
        );

        if (matchScore > 0.7) {
          // Threshold for notification
          if (kDebugMode) {
            debugPrint(
                '[DEBUG] Job match found: ${job.jobTitle} at ${job.company}');
          }

          await _triggerNotification(
            job.id,
            'New Job Match!',
            '${job.jobTitle} at ${job.company} matches your profile.',
            job,
          );
        }
      }
    }
    if (kDebugMode) {
      debugPrint('[DEBUG] Finished checking new jobs for matches.');
    }
  }

  /// Triggers a local notification.
  Future<void> _triggerNotification(
      String jobId, String title, String body, Job job) async {
    final String? userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    await NotificationService.createJobAlert(
      userId: userId,
      jobId: jobId,
      jobTitle: job.jobTitle ?? 'Job Opportunity',
      company: job.company,
      location: job.location,
      hourlyRate: job.wage,
    );
  }

  /// Collects user feedback for a specific job.
  Future<void> collectJobFeedback(Job job,
      {String? feedbackText, double rating = 0.0}) async {
    if (kDebugMode) {
      debugPrint('[DEBUG] Collecting feedback for job: ${job.id}');
    }
    final FeedbackService feedbackService = ref.read(feedbackServiceProvider);

    final String? userId = ref.read(currentUserIdProvider);
    if (userId == null) {
      if (kDebugMode) {
        debugPrint('[DEBUG] Cannot submit feedback: No user logged in');
      }
      return; // Cannot submit feedback without user
    }

    final UserFeedback feedback = UserFeedback(
      id: '', // Firestore will assign an ID
      userId: userId,
      subjectId: job.id,
      subjectType: 'job',
      feedbackText: feedbackText ?? 'Job viewed',
      rating: rating,
      createdAt: Timestamp.now(),
    );

    try {
      await feedbackService.addFeedback(feedback);
      if (kDebugMode) {
        debugPrint(
            '[DEBUG] Feedback successfully collected for job: ${job.id}');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('[ERROR] Failed to collect feedback for job ${job.id}: $e');
      }
    }
  }

  /// Clear error
  void clearError() {
    state = state.clearError();
  }

  /// Get performance metrics
  Map<String, dynamic> getPerformanceMetrics() => <String, dynamic>{
        'averageLoadTime': state.loadTimes.isEmpty
            ? Duration.zero
            : Duration(
                milliseconds: state.loadTimes
                        .map((Duration d) => d.inMilliseconds)
                        .reduce((int a, int b) => a + b) ~/
                    state.loadTimes.length,
              ),
        'totalJobsLoaded': state.totalJobsLoaded,
        'memoryUsage': _boundedJobList.estimatedMemoryUsage,
        'filterPerformance': _filterEngine.getAverageFilterTime(),
      };

  /// Dispose resources
  void dispose() {
    _operationManager.dispose();
    _filterEngine.clearMetrics();
    _boundedJobList.dispose();
  }
}

/// Filtered jobs provider using family for auto-dispose
@riverpod
Future<List<Job>> filteredJobs(
  Ref ref,
  JobFilterCriteria filter,
) async {
  final firestoreService = ref.watch(firestoreServiceProvider);

  final result = await firestoreService.getJobsWithFilter(
    filter: filter,
    limit: 50,
  );

  // Convert QuerySnapshot to Job objects
  return result.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;
    data['id'] = doc.id;
    return Job.fromJson(data);
  }).toList();
}

/// Auto-dispose provider for job search
@riverpod
Future<List<Job>> searchJobs(
  Ref ref,
  String searchTerm,
) async {
  if (searchTerm.trim().isEmpty) {
    return <Job>[];
  }

  final firestoreService = ref.watch(firestoreServiceProvider);

  final JobFilterCriteria filter = JobFilterCriteria(
    searchQuery: searchTerm,
  );

  final result = await firestoreService.getJobsWithFilter(
    filter: filter,
    limit: 20,
  );

  // Convert QuerySnapshot to Job objects
  return result.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;
    data['id'] = doc.id;
    return Job.fromJson(data);
  }).toList();
}

/// Job by ID provider
@riverpod
Future<Job?> jobById(Ref ref, String jobId) async {
  final firestoreService = ref.watch(firestoreServiceProvider);

  // Use the basic getJobs stream and filter by ID
  final stream = firestoreService.getJobs(limit: 1);
  final snapshot = await stream.first;

  for (final doc in snapshot.docs) {
    if (doc.id == jobId) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return Job.fromJson(data);
    }
  }

  return null;
}

/// Recent jobs provider
@riverpod
Future<List<Job>> recentJobs(Ref ref) async {
  final firestoreService = ref.watch(firestoreServiceProvider);

  const JobFilterCriteria filter = JobFilterCriteria(
    sortBy: JobSortOption.datePosted,
    sortDescending: true,
  );

  final result = await firestoreService.getJobsWithFilter(
    filter: filter,
    limit: 10,
  );

  // Convert QuerySnapshot to Job objects
  return result.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;
    data['id'] = doc.id;
    return Job.fromJson(data);
  }).toList();
}

/// Storm jobs provider (high priority jobs)
@riverpod
Future<List<Job>> stormJobs(Ref ref) async {
  final firestoreService = ref.watch(firestoreServiceProvider);

  const JobFilterCriteria filter = JobFilterCriteria(
    constructionTypes: <String>['storm', 'emergency'],
    sortBy: JobSortOption.datePosted,
    sortDescending: true,
  );

  final result = await firestoreService.getJobsWithFilter(
    filter: filter,
    limit: 20,
  );

  // Convert QuerySnapshot to Job objects
  return result.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;
    data['id'] = doc.id;
    return Job.fromJson(data);
  }).toList();
}

/// Backwards compatibility alias for legacy code using the old `jobsProvider` name.
/// The @riverpod annotation generates `jobsNotifierProvider` from `JobsNotifier`,
/// but existing code references `jobsProvider`. This alias maintains compatibility.
// ignore: non_constant_identifier_names
final jobsNotifierProvider = jobsProvider;
