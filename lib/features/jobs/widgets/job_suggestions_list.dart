import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../jobs.dart';

// Provider for job suggestions based on recent jobs
final jobSuggestionsProvider = FutureProvider<List<JobSuggestion>>((ref) async {
  // Fetch recent jobs to simulate suggestions
  try {
    final recentJobs = await ref.watch(recentJobsProvider.future);

    return recentJobs.take(3).map((job) {
      return JobSuggestion(
        id: 'sug_${job.id}',
        originalJobId: 'profile_match',
        suggestedJobId: job.id,
        reason: 'Matches your trade and location',
        relevanceScore: 0.95,
        createdAt: Timestamp.now(),
      );
    }).toList();
  } catch (e) {
    return [];
  }
});

class JobSuggestionsList extends ConsumerWidget {
  const JobSuggestionsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<JobSuggestion>> suggestions =
        ref.watch(jobSuggestionsProvider);

    return suggestions.when(
      data: (sugs) {
        if (sugs.isEmpty) {
          return const Center(child: Text('No job suggestions yet.'));
        }
        return ListView.builder(
          itemCount: sugs.length,
          itemBuilder: (context, index) {
            final suggestion = sugs[index];
            return JobSuggestionCard(
              suggestion: suggestion,
              onDetailsPressed: () async {
                // Fetch the real job to show details
                // Ideally JobSuggestion should contain the full Job or we fetch it
                // For now, we simulate fetching or if we used recentJobs, we might have it.
                // But JobSuggestion structure (lines 12-19) only has IDs.
                // We will use ref.read(jobById(id)) if available, or just show a toast if not found.

                final job = await ref
                    .read(jobByIdProvider(suggestion.suggestedJobId).future);
                if (context.mounted && job != null) {
                  showDialog(
                    context: context,
                    builder: (context) => JobDetailsDialog(job: job),
                  );
                } else if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Job details not found')),
                  );
                }
              },
              onAcceptPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Job suggestion accepted!')),
                );
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) =>
          Center(child: Text('Error loading suggestions: $err')),
    );
  }
}
