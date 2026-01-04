/// Crews Feature Barrel File
library crews;

// Models
export 'models/crew.dart';
export 'models/crew_member.dart';
export 'models/crew_location.dart';
export 'models/crew_preferences.dart';
export 'models/crew_stats.dart';
export 'models/message.dart';
export 'models/post.dart';
export 'models/shared_job.dart';
export 'models/tailboard.dart';

// Providers
export 'providers/crews_riverpod_provider.dart';
export 'providers/crew_jobs_riverpod_provider.dart';
export 'providers/crew_selection_provider.dart';
export 'providers/feed_provider.dart';
export 'providers/feed_filter_provider.dart';
export 'providers/global_feed_riverpod_provider.dart';
export 'providers/messaging_riverpod_provider.dart';
export 'providers/tailboard_riverpod_provider.dart';
export 'providers/connectivity_service_provider.dart';

// Screens
export 'screens/tailboard_screen.dart';
export 'screens/create_crew_screen.dart';
export 'screens/join_crew_screen.dart';
export 'screens/crew_onboarding_screen.dart';

// Services
export 'services/chat_service.dart';
export 'services/crew_service.dart';
export 'services/feed_service.dart';
export 'services/message_service.dart';
export 'services/tailboard_service.dart';
