export 'connectivity_service_provider.dart';
export 'crew_jobs_riverpod_provider.dart';
export 'crew_selection_provider.dart';
export 'feed_filter_provider.dart';
export 'feed_provider.dart';
export 'global_feed_riverpod_provider.dart';
export 'messaging_riverpod_provider.dart';
// NOTE: Both feed_provider.dart and tailboard_riverpod_provider.dart define
// pinnedPosts/recentPosts (and their generated *Provider symbols). When this
// barrel exports both, Dart sees a name collision.
//
// Keep the Feed providers as the default exported names and hide the Tailboard
// variants. If a caller needs Tailboard's pinned/recent variants, they should
// import tailboard_riverpod_provider.dart directly.
export 'tailboard_riverpod_provider.dart'
    hide
        // Riverpod function + provider symbols
        pinnedPosts,
        pinnedPostsProvider,
        recentPosts,
        recentPostsProvider,
        // Riverpod generated types (also collide)
        PinnedPostsProvider,
        PinnedPostsFamily,
        RecentPostsProvider,
        RecentPostsFamily;
