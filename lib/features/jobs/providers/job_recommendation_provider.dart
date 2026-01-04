import 'package:journeyman_jobs/features/jobs/jobs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:journeyman_jobs/core/core.dart';
// New import

part 'job_recommendation_provider.g.dart';

@riverpod
SubscriptionService subscriptionService(Ref ref) => SubscriptionService();

@riverpod
Future<List<JobSuggestion>> jobRecommendations(Ref ref) async {
  final SubscriptionService subService = ref.watch(subscriptionServiceProvider);

  // Check if the user is a pro subscriber
  final bool isPro = await subService.isProSubscriber();
  if (!isPro) {
    return []; // Return empty list if not a pro subscriber
  }

  final localModelService = ref.watch(localModelServiceProvider);

  // Placeholder for user preferences. In a real app, this would come from a user preferences provider.
  final Map<String, dynamic> userPreferences = {
    'per_diem_min': 100,
    'location_preference': 'Florida',
    'job_type': 'Journeyman Lineman',
  };

  return localModelService.getJobRecommendations(userPreferences);
}



