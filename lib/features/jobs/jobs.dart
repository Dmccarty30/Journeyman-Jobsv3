/// Jobs Feature Barrel File
library;

// Models
export 'models/job_model.dart';
export 'models/job_suggestion_model.dart';
export 'models/job_summary_model.dart';
export 'models/filter_criteria.dart';
export 'models/filter_preset.dart';
export 'models/jobs_record.dart';

// Providers
export 'providers/jobs_riverpod_provider.dart';
export 'providers/job_filter_riverpod_provider.dart';
export 'providers/job_recommendation_provider.dart';
export 'providers/user_job_preference_query_provider.dart'
    hide
        userPreferenceService,
        userPreferenceServiceProvider,
        UserPreferenceServiceProvider,
        firestoreService,
        firestoreServiceProvider,
        FirestoreServiceProvider;

// Screens
export 'screens/jobs_screen.dart';

// Services
export 'services/job_repository.dart';
export 'services/get_jobs_use_case.dart';

// Widgets
export 'widgets/condensed_job_card.dart';
export 'widgets/job_card_skeleton.dart';
export 'widgets/job_details_dialog.dart';
export 'widgets/optimized_job_card.dart' hide JobCardSkeleton;
export 'widgets/rich_text_job_card.dart';
export 'widgets/virtual_job_list.dart';
export 'widgets/job_suggestion_card.dart';
export 'widgets/job_suggestions_list.dart';
