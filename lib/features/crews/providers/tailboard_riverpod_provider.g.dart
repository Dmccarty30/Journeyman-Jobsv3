// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tailboard_riverpod_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// TailboardService provider

@ProviderFor(tailboardService)
final tailboardServiceProvider = TailboardServiceProvider._();

/// TailboardService provider

final class TailboardServiceProvider extends $FunctionalProvider<
    TailboardService,
    TailboardService,
    TailboardService> with $Provider<TailboardService> {
  /// TailboardService provider
  TailboardServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'tailboardServiceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$tailboardServiceHash();

  @$internal
  @override
  $ProviderElement<TailboardService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TailboardService create(Ref ref) {
    return tailboardService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TailboardService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TailboardService>(value),
    );
  }
}

String _$tailboardServiceHash() => r'a008ee27926f60cfa4901bb94d74ed464864c13b';

/// Stream of suggested jobs for a specific crew

@ProviderFor(suggestedJobsStream)
final suggestedJobsStreamProvider = SuggestedJobsStreamFamily._();

/// Stream of suggested jobs for a specific crew

final class SuggestedJobsStreamProvider extends $FunctionalProvider<
        AsyncValue<List<SharedJob>>, List<SharedJob>, Stream<List<SharedJob>>>
    with $FutureModifier<List<SharedJob>>, $StreamProvider<List<SharedJob>> {
  /// Stream of suggested jobs for a specific crew
  SuggestedJobsStreamProvider._(
      {required SuggestedJobsStreamFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'suggestedJobsStreamProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$suggestedJobsStreamHash();

  @override
  String toString() {
    return r'suggestedJobsStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<SharedJob>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<SharedJob>> create(Ref ref) {
    final argument = this.argument as String;
    return suggestedJobsStream(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SuggestedJobsStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$suggestedJobsStreamHash() =>
    r'5a0c765beffd9fc8c992a29bb89109bb79f3bd58';

/// Stream of suggested jobs for a specific crew

final class SuggestedJobsStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<SharedJob>>, String> {
  SuggestedJobsStreamFamily._()
      : super(
          retry: null,
          name: r'suggestedJobsStreamProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Stream of suggested jobs for a specific crew

  SuggestedJobsStreamProvider call(
    String crewId,
  ) =>
      SuggestedJobsStreamProvider._(argument: crewId, from: this);

  @override
  String toString() => r'suggestedJobsStreamProvider';
}

/// Suggested jobs for a specific crew

@ProviderFor(suggestedJobs)
final suggestedJobsProvider = SuggestedJobsFamily._();

/// Suggested jobs for a specific crew

final class SuggestedJobsProvider extends $FunctionalProvider<List<SharedJob>,
    List<SharedJob>, List<SharedJob>> with $Provider<List<SharedJob>> {
  /// Suggested jobs for a specific crew
  SuggestedJobsProvider._(
      {required SuggestedJobsFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'suggestedJobsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$suggestedJobsHash();

  @override
  String toString() {
    return r'suggestedJobsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<SharedJob>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<SharedJob> create(Ref ref) {
    final argument = this.argument as String;
    return suggestedJobs(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<SharedJob> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<SharedJob>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SuggestedJobsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$suggestedJobsHash() => r'70410cc7a2167c068fef3c3d36cfbaf6576ac9ad';

/// Suggested jobs for a specific crew

final class SuggestedJobsFamily extends $Family
    with $FunctionalFamilyOverride<List<SharedJob>, String> {
  SuggestedJobsFamily._()
      : super(
          retry: null,
          name: r'suggestedJobsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Suggested jobs for a specific crew

  SuggestedJobsProvider call(
    String crewId,
  ) =>
      SuggestedJobsProvider._(argument: crewId, from: this);

  @override
  String toString() => r'suggestedJobsProvider';
}

/// Stream of activity items for a specific crew

@ProviderFor(activityItemsStream)
final activityItemsStreamProvider = ActivityItemsStreamFamily._();

/// Stream of activity items for a specific crew

final class ActivityItemsStreamProvider extends $FunctionalProvider<
        AsyncValue<List<ActivityItem>>,
        List<ActivityItem>,
        Stream<List<ActivityItem>>>
    with
        $FutureModifier<List<ActivityItem>>,
        $StreamProvider<List<ActivityItem>> {
  /// Stream of activity items for a specific crew
  ActivityItemsStreamProvider._(
      {required ActivityItemsStreamFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'activityItemsStreamProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$activityItemsStreamHash();

  @override
  String toString() {
    return r'activityItemsStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<ActivityItem>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<ActivityItem>> create(Ref ref) {
    final argument = this.argument as String;
    return activityItemsStream(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ActivityItemsStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$activityItemsStreamHash() =>
    r'0090d86914764688f90560e110a2f58a1cde0ab2';

/// Stream of activity items for a specific crew

final class ActivityItemsStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<ActivityItem>>, String> {
  ActivityItemsStreamFamily._()
      : super(
          retry: null,
          name: r'activityItemsStreamProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Stream of activity items for a specific crew

  ActivityItemsStreamProvider call(
    String crewId,
  ) =>
      ActivityItemsStreamProvider._(argument: crewId, from: this);

  @override
  String toString() => r'activityItemsStreamProvider';
}

/// Activity items for a specific crew

@ProviderFor(activityItems)
final activityItemsProvider = ActivityItemsFamily._();

/// Activity items for a specific crew

final class ActivityItemsProvider extends $FunctionalProvider<
    List<ActivityItem>,
    List<ActivityItem>,
    List<ActivityItem>> with $Provider<List<ActivityItem>> {
  /// Activity items for a specific crew
  ActivityItemsProvider._(
      {required ActivityItemsFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'activityItemsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$activityItemsHash();

  @override
  String toString() {
    return r'activityItemsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<ActivityItem>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<ActivityItem> create(Ref ref) {
    final argument = this.argument as String;
    return activityItems(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ActivityItem> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ActivityItem>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ActivityItemsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$activityItemsHash() => r'f556562361eb3d8a86ba3c2a25f075aab38f5b7d';

/// Activity items for a specific crew

final class ActivityItemsFamily extends $Family
    with $FunctionalFamilyOverride<List<ActivityItem>, String> {
  ActivityItemsFamily._()
      : super(
          retry: null,
          name: r'activityItemsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Activity items for a specific crew

  ActivityItemsProvider call(
    String crewId,
  ) =>
      ActivityItemsProvider._(argument: crewId, from: this);

  @override
  String toString() => r'activityItemsProvider';
}

/// Stream of tailboard posts for a specific crew

@ProviderFor(tailboardPostsStream)
final tailboardPostsStreamProvider = TailboardPostsStreamFamily._();

/// Stream of tailboard posts for a specific crew

final class TailboardPostsStreamProvider extends $FunctionalProvider<
        AsyncValue<List<Post>>, List<Post>, Stream<List<Post>>>
    with $FutureModifier<List<Post>>, $StreamProvider<List<Post>> {
  /// Stream of tailboard posts for a specific crew
  TailboardPostsStreamProvider._(
      {required TailboardPostsStreamFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'tailboardPostsStreamProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$tailboardPostsStreamHash();

  @override
  String toString() {
    return r'tailboardPostsStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Post>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Post>> create(Ref ref) {
    final argument = this.argument as String;
    return tailboardPostsStream(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TailboardPostsStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tailboardPostsStreamHash() =>
    r'94224e41897482c065ad0a34ed9adc0999e4dd41';

/// Stream of tailboard posts for a specific crew

final class TailboardPostsStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Post>>, String> {
  TailboardPostsStreamFamily._()
      : super(
          retry: null,
          name: r'tailboardPostsStreamProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Stream of tailboard posts for a specific crew

  TailboardPostsStreamProvider call(
    String crewId,
  ) =>
      TailboardPostsStreamProvider._(argument: crewId, from: this);

  @override
  String toString() => r'tailboardPostsStreamProvider';
}

/// Tailboard posts for a specific crew

@ProviderFor(tailboardPosts)
final tailboardPostsProvider = TailboardPostsFamily._();

/// Tailboard posts for a specific crew

final class TailboardPostsProvider
    extends $FunctionalProvider<List<Post>, List<Post>, List<Post>>
    with $Provider<List<Post>> {
  /// Tailboard posts for a specific crew
  TailboardPostsProvider._(
      {required TailboardPostsFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'tailboardPostsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$tailboardPostsHash();

  @override
  String toString() {
    return r'tailboardPostsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<Post>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Post> create(Ref ref) {
    final argument = this.argument as String;
    return tailboardPosts(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Post> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Post>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TailboardPostsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tailboardPostsHash() => r'ff8c8b745068a7570318ac077d8e1a9ebb0b4c10';

/// Tailboard posts for a specific crew

final class TailboardPostsFamily extends $Family
    with $FunctionalFamilyOverride<List<Post>, String> {
  TailboardPostsFamily._()
      : super(
          retry: null,
          name: r'tailboardPostsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Tailboard posts for a specific crew

  TailboardPostsProvider call(
    String crewId,
  ) =>
      TailboardPostsProvider._(argument: crewId, from: this);

  @override
  String toString() => r'tailboardPostsProvider';
}

/// Provider to get unread activity items count for current user

@ProviderFor(unreadActivityCount)
final unreadActivityCountProvider = UnreadActivityCountFamily._();

/// Provider to get unread activity items count for current user

final class UnreadActivityCountProvider
    extends $FunctionalProvider<int, int, int> with $Provider<int> {
  /// Provider to get unread activity items count for current user
  UnreadActivityCountProvider._(
      {required UnreadActivityCountFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'unreadActivityCountProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$unreadActivityCountHash();

  @override
  String toString() {
    return r'unreadActivityCountProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    final argument = this.argument as String;
    return unreadActivityCount(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UnreadActivityCountProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$unreadActivityCountHash() =>
    r'348b3fc1db5a077a51f6f1b983996adac88ec4a2';

/// Provider to get unread activity items count for current user

final class UnreadActivityCountFamily extends $Family
    with $FunctionalFamilyOverride<int, String> {
  UnreadActivityCountFamily._()
      : super(
          retry: null,
          name: r'unreadActivityCountProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider to get unread activity items count for current user

  UnreadActivityCountProvider call(
    String crewId,
  ) =>
      UnreadActivityCountProvider._(argument: crewId, from: this);

  @override
  String toString() => r'unreadActivityCountProvider';
}

/// Provider to get pinned posts for a specific crew

@ProviderFor(pinnedPosts)
final pinnedPostsProvider = PinnedPostsFamily._();

/// Provider to get pinned posts for a specific crew

final class PinnedPostsProvider
    extends $FunctionalProvider<List<Post>, List<Post>, List<Post>>
    with $Provider<List<Post>> {
  /// Provider to get pinned posts for a specific crew
  PinnedPostsProvider._(
      {required PinnedPostsFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'pinnedPostsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$pinnedPostsHash();

  @override
  String toString() {
    return r'pinnedPostsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<Post>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Post> create(Ref ref) {
    final argument = this.argument as String;
    return pinnedPosts(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Post> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Post>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PinnedPostsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pinnedPostsHash() => r'00318e4be656729119f8859a15560e6a24a734a4';

/// Provider to get pinned posts for a specific crew

final class PinnedPostsFamily extends $Family
    with $FunctionalFamilyOverride<List<Post>, String> {
  PinnedPostsFamily._()
      : super(
          retry: null,
          name: r'pinnedPostsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider to get pinned posts for a specific crew

  PinnedPostsProvider call(
    String crewId,
  ) =>
      PinnedPostsProvider._(argument: crewId, from: this);

  @override
  String toString() => r'pinnedPostsProvider';
}

/// Provider to get recent posts for a specific crew

@ProviderFor(recentPosts)
final recentPostsProvider = RecentPostsFamily._();

/// Provider to get recent posts for a specific crew

final class RecentPostsProvider
    extends $FunctionalProvider<List<Post>, List<Post>, List<Post>>
    with $Provider<List<Post>> {
  /// Provider to get recent posts for a specific crew
  RecentPostsProvider._(
      {required RecentPostsFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'recentPostsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$recentPostsHash();

  @override
  String toString() {
    return r'recentPostsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<Post>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Post> create(Ref ref) {
    final argument = this.argument as String;
    return recentPosts(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Post> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Post>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RecentPostsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$recentPostsHash() => r'93dd643f2cdda640bb90cbb6c794354b8a18e3b4';

/// Provider to get recent posts for a specific crew

final class RecentPostsFamily extends $Family
    with $FunctionalFamilyOverride<List<Post>, String> {
  RecentPostsFamily._()
      : super(
          retry: null,
          name: r'recentPostsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider to get recent posts for a specific crew

  RecentPostsProvider call(
    String crewId,
  ) =>
      RecentPostsProvider._(argument: crewId, from: this);

  @override
  String toString() => r'recentPostsProvider';
}

/// Provider to get posts by a specific author

@ProviderFor(postsByAuthor)
final postsByAuthorProvider = PostsByAuthorFamily._();

/// Provider to get posts by a specific author

final class PostsByAuthorProvider
    extends $FunctionalProvider<List<Post>, List<Post>, List<Post>>
    with $Provider<List<Post>> {
  /// Provider to get posts by a specific author
  PostsByAuthorProvider._(
      {required PostsByAuthorFamily super.from,
      required (
        String,
        String,
      )
          super.argument})
      : super(
          retry: null,
          name: r'postsByAuthorProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$postsByAuthorHash();

  @override
  String toString() {
    return r'postsByAuthorProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<List<Post>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Post> create(Ref ref) {
    final argument = this.argument as (
      String,
      String,
    );
    return postsByAuthor(
      ref,
      argument.$1,
      argument.$2,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Post> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Post>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PostsByAuthorProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$postsByAuthorHash() => r'6d4850ea6d686d4144c5b31e5c8beccec7283608';

/// Provider to get posts by a specific author

final class PostsByAuthorFamily extends $Family
    with
        $FunctionalFamilyOverride<
            List<Post>,
            (
              String,
              String,
            )> {
  PostsByAuthorFamily._()
      : super(
          retry: null,
          name: r'postsByAuthorProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider to get posts by a specific author

  PostsByAuthorProvider call(
    String crewId,
    String authorId,
  ) =>
      PostsByAuthorProvider._(argument: (
        crewId,
        authorId,
      ), from: this);

  @override
  String toString() => r'postsByAuthorProvider';
}

/// Provider to get activity by type

@ProviderFor(activitiesByType)
final activitiesByTypeProvider = ActivitiesByTypeFamily._();

/// Provider to get activity by type

final class ActivitiesByTypeProvider extends $FunctionalProvider<
    List<ActivityItem>,
    List<ActivityItem>,
    List<ActivityItem>> with $Provider<List<ActivityItem>> {
  /// Provider to get activity by type
  ActivitiesByTypeProvider._(
      {required ActivitiesByTypeFamily super.from,
      required (
        String,
        ActivityType,
      )
          super.argument})
      : super(
          retry: null,
          name: r'activitiesByTypeProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$activitiesByTypeHash();

  @override
  String toString() {
    return r'activitiesByTypeProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<List<ActivityItem>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<ActivityItem> create(Ref ref) {
    final argument = this.argument as (
      String,
      ActivityType,
    );
    return activitiesByType(
      ref,
      argument.$1,
      argument.$2,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ActivityItem> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ActivityItem>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ActivitiesByTypeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$activitiesByTypeHash() => r'cbd0752e4336650f5453e86d9befc0ec3992b696';

/// Provider to get activity by type

final class ActivitiesByTypeFamily extends $Family
    with
        $FunctionalFamilyOverride<
            List<ActivityItem>,
            (
              String,
              ActivityType,
            )> {
  ActivitiesByTypeFamily._()
      : super(
          retry: null,
          name: r'activitiesByTypeProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider to get activity by type

  ActivitiesByTypeProvider call(
    String crewId,
    ActivityType type,
  ) =>
      ActivitiesByTypeProvider._(argument: (
        crewId,
        type,
      ), from: this);

  @override
  String toString() => r'activitiesByTypeProvider';
}

/// Provider to get recent activities (last 7 days)

@ProviderFor(recentActivities)
final recentActivitiesProvider = RecentActivitiesFamily._();

/// Provider to get recent activities (last 7 days)

final class RecentActivitiesProvider extends $FunctionalProvider<
    List<ActivityItem>,
    List<ActivityItem>,
    List<ActivityItem>> with $Provider<List<ActivityItem>> {
  /// Provider to get recent activities (last 7 days)
  RecentActivitiesProvider._(
      {required RecentActivitiesFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'recentActivitiesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$recentActivitiesHash();

  @override
  String toString() {
    return r'recentActivitiesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<ActivityItem>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<ActivityItem> create(Ref ref) {
    final argument = this.argument as String;
    return recentActivities(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ActivityItem> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ActivityItem>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RecentActivitiesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$recentActivitiesHash() => r'c82c70514c85fd9e205c2b408559a4eabf901cc4';

/// Provider to get recent activities (last 7 days)

final class RecentActivitiesFamily extends $Family
    with $FunctionalFamilyOverride<List<ActivityItem>, String> {
  RecentActivitiesFamily._()
      : super(
          retry: null,
          name: r'recentActivitiesProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider to get recent activities (last 7 days)

  RecentActivitiesProvider call(
    String crewId,
  ) =>
      RecentActivitiesProvider._(argument: crewId, from: this);

  @override
  String toString() => r'recentActivitiesProvider';
}

/// Provider to get activities by actor

@ProviderFor(activitiesByActor)
final activitiesByActorProvider = ActivitiesByActorFamily._();

/// Provider to get activities by actor

final class ActivitiesByActorProvider extends $FunctionalProvider<
    List<ActivityItem>,
    List<ActivityItem>,
    List<ActivityItem>> with $Provider<List<ActivityItem>> {
  /// Provider to get activities by actor
  ActivitiesByActorProvider._(
      {required ActivitiesByActorFamily super.from,
      required (
        String,
        String,
      )
          super.argument})
      : super(
          retry: null,
          name: r'activitiesByActorProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$activitiesByActorHash();

  @override
  String toString() {
    return r'activitiesByActorProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<List<ActivityItem>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<ActivityItem> create(Ref ref) {
    final argument = this.argument as (
      String,
      String,
    );
    return activitiesByActor(
      ref,
      argument.$1,
      argument.$2,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ActivityItem> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ActivityItem>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ActivitiesByActorProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$activitiesByActorHash() => r'ab85fe28f6de78ca59f115ebcdcca1e28ecf5de7';

/// Provider to get activities by actor

final class ActivitiesByActorFamily extends $Family
    with
        $FunctionalFamilyOverride<
            List<ActivityItem>,
            (
              String,
              String,
            )> {
  ActivitiesByActorFamily._()
      : super(
          retry: null,
          name: r'activitiesByActorProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider to get activities by actor

  ActivitiesByActorProvider call(
    String crewId,
    String actorId,
  ) =>
      ActivitiesByActorProvider._(argument: (
        crewId,
        actorId,
      ), from: this);

  @override
  String toString() => r'activitiesByActorProvider';
}
