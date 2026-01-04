// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// FeedService provider

@ProviderFor(feedService)
final feedServiceProvider = FeedServiceProvider._();

/// FeedService provider

final class FeedServiceProvider
    extends $FunctionalProvider<FeedService, FeedService, FeedService>
    with $Provider<FeedService> {
  /// FeedService provider
  FeedServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'feedServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$feedServiceHash();

  @$internal
  @override
  $ProviderElement<FeedService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FeedService create(Ref ref) {
    return feedService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FeedService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FeedService>(value),
    );
  }
}

String _$feedServiceHash() => r'e4adaf3d0765ea270bafbca76dcd9d0be6570ba1';

/// Stream of posts for a specific crew

@ProviderFor(crewPostsStream)
final crewPostsStreamProvider = CrewPostsStreamFamily._();

/// Stream of posts for a specific crew

final class CrewPostsStreamProvider extends $FunctionalProvider<
        AsyncValue<List<Post>>, List<Post>, Stream<List<Post>>>
    with $FutureModifier<List<Post>>, $StreamProvider<List<Post>> {
  /// Stream of posts for a specific crew
  CrewPostsStreamProvider._(
      {required CrewPostsStreamFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'crewPostsStreamProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$crewPostsStreamHash();

  @override
  String toString() {
    return r'crewPostsStreamProvider'
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
    return crewPostsStream(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CrewPostsStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$crewPostsStreamHash() => r'5e1d785a3a8d359dc17cea64eb9718ffd00e9bcf';

/// Stream of posts for a specific crew

final class CrewPostsStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Post>>, String> {
  CrewPostsStreamFamily._()
      : super(
          retry: null,
          name: r'crewPostsStreamProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Stream of posts for a specific crew

  CrewPostsStreamProvider call(
    String crewId,
  ) =>
      CrewPostsStreamProvider._(argument: crewId, from: this);

  @override
  String toString() => r'crewPostsStreamProvider';
}

/// Posts for a specific crew

@ProviderFor(crewPosts)
final crewPostsProvider = CrewPostsFamily._();

/// Posts for a specific crew

final class CrewPostsProvider extends $FunctionalProvider<
    AsyncValue<List<Post>>,
    AsyncValue<List<Post>>,
    AsyncValue<List<Post>>> with $Provider<AsyncValue<List<Post>>> {
  /// Posts for a specific crew
  CrewPostsProvider._(
      {required CrewPostsFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'crewPostsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$crewPostsHash();

  @override
  String toString() {
    return r'crewPostsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<AsyncValue<List<Post>>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AsyncValue<List<Post>> create(Ref ref) {
    final argument = this.argument as String;
    return crewPosts(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<Post>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<Post>>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CrewPostsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$crewPostsHash() => r'bf2eced5fde8644744e8a3ea070933983b00749f';

/// Posts for a specific crew

final class CrewPostsFamily extends $Family
    with $FunctionalFamilyOverride<AsyncValue<List<Post>>, String> {
  CrewPostsFamily._()
      : super(
          retry: null,
          name: r'crewPostsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Posts for a specific crew

  CrewPostsProvider call(
    String crewId,
  ) =>
      CrewPostsProvider._(argument: crewId, from: this);

  @override
  String toString() => r'crewPostsProvider';
}

/// Stream of comments for a specific post

@ProviderFor(postCommentsStream)
final postCommentsStreamProvider = PostCommentsStreamFamily._();

/// Stream of comments for a specific post

final class PostCommentsStreamProvider extends $FunctionalProvider<
        AsyncValue<List<PostComment>>,
        List<PostComment>,
        Stream<List<PostComment>>>
    with
        $FutureModifier<List<PostComment>>,
        $StreamProvider<List<PostComment>> {
  /// Stream of comments for a specific post
  PostCommentsStreamProvider._(
      {required PostCommentsStreamFamily super.from,
      required (
        String,
        String,
      )
          super.argument})
      : super(
          retry: null,
          name: r'postCommentsStreamProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$postCommentsStreamHash();

  @override
  String toString() {
    return r'postCommentsStreamProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<List<PostComment>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<PostComment>> create(Ref ref) {
    final argument = this.argument as (
      String,
      String,
    );
    return postCommentsStream(
      ref,
      argument.$1,
      argument.$2,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PostCommentsStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$postCommentsStreamHash() =>
    r'30dbdb75bc0b20c7e01d196325ab920b75d43f5a';

/// Stream of comments for a specific post

final class PostCommentsStreamFamily extends $Family
    with
        $FunctionalFamilyOverride<
            Stream<List<PostComment>>,
            (
              String,
              String,
            )> {
  PostCommentsStreamFamily._()
      : super(
          retry: null,
          name: r'postCommentsStreamProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Stream of comments for a specific post

  PostCommentsStreamProvider call(
    String crewId,
    String postId,
  ) =>
      PostCommentsStreamProvider._(argument: (
        crewId,
        postId,
      ), from: this);

  @override
  String toString() => r'postCommentsStreamProvider';
}

/// Comments for a specific post

@ProviderFor(postComments)
final postCommentsProvider = PostCommentsFamily._();

/// Comments for a specific post

final class PostCommentsProvider extends $FunctionalProvider<
        AsyncValue<List<PostComment>>,
        AsyncValue<List<PostComment>>,
        AsyncValue<List<PostComment>>>
    with $Provider<AsyncValue<List<PostComment>>> {
  /// Comments for a specific post
  PostCommentsProvider._(
      {required PostCommentsFamily super.from,
      required (
        String,
        String,
      )
          super.argument})
      : super(
          retry: null,
          name: r'postCommentsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$postCommentsHash();

  @override
  String toString() {
    return r'postCommentsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<AsyncValue<List<PostComment>>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AsyncValue<List<PostComment>> create(Ref ref) {
    final argument = this.argument as (
      String,
      String,
    );
    return postComments(
      ref,
      argument.$1,
      argument.$2,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<PostComment>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<AsyncValue<List<PostComment>>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PostCommentsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$postCommentsHash() => r'894dba659d2b6a0665d1e053f8169b30b58f868f';

/// Comments for a specific post

final class PostCommentsFamily extends $Family
    with
        $FunctionalFamilyOverride<
            AsyncValue<List<PostComment>>,
            (
              String,
              String,
            )> {
  PostCommentsFamily._()
      : super(
          retry: null,
          name: r'postCommentsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Comments for a specific post

  PostCommentsProvider call(
    String crewId,
    String postId,
  ) =>
      PostCommentsProvider._(argument: (
        crewId,
        postId,
      ), from: this);

  @override
  String toString() => r'postCommentsProvider';
}

/// Provider to get posts for selected crew

@ProviderFor(selectedCrewPosts)
final selectedCrewPostsProvider = SelectedCrewPostsProvider._();

/// Provider to get posts for selected crew

final class SelectedCrewPostsProvider extends $FunctionalProvider<
    AsyncValue<List<Post>>,
    AsyncValue<List<Post>>,
    AsyncValue<List<Post>>> with $Provider<AsyncValue<List<Post>>> {
  /// Provider to get posts for selected crew
  SelectedCrewPostsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'selectedCrewPostsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$selectedCrewPostsHash();

  @$internal
  @override
  $ProviderElement<AsyncValue<List<Post>>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AsyncValue<List<Post>> create(Ref ref) {
    return selectedCrewPosts(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<Post>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<Post>>>(value),
    );
  }
}

String _$selectedCrewPostsHash() => r'3ca6e1ad9399be2b8e0f9adda475b615e1f41b6e';

/// Provider to get pinned posts for a crew

@ProviderFor(pinnedPosts)
final pinnedPostsProvider = PinnedPostsFamily._();

/// Provider to get pinned posts for a crew

final class PinnedPostsProvider extends $FunctionalProvider<
    AsyncValue<List<Post>>,
    AsyncValue<List<Post>>,
    AsyncValue<List<Post>>> with $Provider<AsyncValue<List<Post>>> {
  /// Provider to get pinned posts for a crew
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
  $ProviderElement<AsyncValue<List<Post>>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AsyncValue<List<Post>> create(Ref ref) {
    final argument = this.argument as String;
    return pinnedPosts(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<Post>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<Post>>>(value),
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

String _$pinnedPostsHash() => r'18279562a585679143452804667be13c9333f6f1';

/// Provider to get pinned posts for a crew

final class PinnedPostsFamily extends $Family
    with $FunctionalFamilyOverride<AsyncValue<List<Post>>, String> {
  PinnedPostsFamily._()
      : super(
          retry: null,
          name: r'pinnedPostsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider to get pinned posts for a crew

  PinnedPostsProvider call(
    String crewId,
  ) =>
      PinnedPostsProvider._(argument: crewId, from: this);

  @override
  String toString() => r'pinnedPostsProvider';
}

/// Provider to get recent posts for a crew

@ProviderFor(recentPosts)
final recentPostsProvider = RecentPostsFamily._();

/// Provider to get recent posts for a crew

final class RecentPostsProvider extends $FunctionalProvider<
    AsyncValue<List<Post>>,
    AsyncValue<List<Post>>,
    AsyncValue<List<Post>>> with $Provider<AsyncValue<List<Post>>> {
  /// Provider to get recent posts for a crew
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
  $ProviderElement<AsyncValue<List<Post>>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AsyncValue<List<Post>> create(Ref ref) {
    final argument = this.argument as String;
    return recentPosts(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<Post>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<Post>>>(value),
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

String _$recentPostsHash() => r'9db4058154c106d3ca362029340e8fe52fd8a443';

/// Provider to get recent posts for a crew

final class RecentPostsFamily extends $Family
    with $FunctionalFamilyOverride<AsyncValue<List<Post>>, String> {
  RecentPostsFamily._()
      : super(
          retry: null,
          name: r'recentPostsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider to get recent posts for a crew

  RecentPostsProvider call(
    String crewId,
  ) =>
      RecentPostsProvider._(argument: crewId, from: this);

  @override
  String toString() => r'recentPostsProvider';
}

/// Provider for post creation notifier

@ProviderFor(postCreationNotifier)
final postCreationProvider = PostCreationNotifierProvider._();

/// Provider for post creation notifier

final class PostCreationNotifierProvider extends $FunctionalProvider<
    PostCreationNotifier,
    PostCreationNotifier,
    PostCreationNotifier> with $Provider<PostCreationNotifier> {
  /// Provider for post creation notifier
  PostCreationNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'postCreationProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$postCreationNotifierHash();

  @$internal
  @override
  $ProviderElement<PostCreationNotifier> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PostCreationNotifier create(Ref ref) {
    return postCreationNotifier(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostCreationNotifier value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostCreationNotifier>(value),
    );
  }
}

String _$postCreationNotifierHash() =>
    r'adca49ffd817ee1e6eafc9b6b00d952d9c37a364';

/// Stream of post creation state

@ProviderFor(postCreationState)
final postCreationStateProvider = PostCreationStateProvider._();

/// Stream of post creation state

final class PostCreationStateProvider extends $FunctionalProvider<
    AsyncValue<String?>,
    AsyncValue<String?>,
    AsyncValue<String?>> with $Provider<AsyncValue<String?>> {
  /// Stream of post creation state
  PostCreationStateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'postCreationStateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$postCreationStateHash();

  @$internal
  @override
  $ProviderElement<AsyncValue<String?>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AsyncValue<String?> create(Ref ref) {
    return postCreationState(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<String?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<String?>>(value),
    );
  }
}

String _$postCreationStateHash() => r'211ef6732351f047d73271d5d809fcdc9504dc78';

/// Provider for post update notifier

@ProviderFor(postUpdateNotifier)
final postUpdateProvider = PostUpdateNotifierProvider._();

/// Provider for post update notifier

final class PostUpdateNotifierProvider extends $FunctionalProvider<
    PostUpdateNotifier,
    PostUpdateNotifier,
    PostUpdateNotifier> with $Provider<PostUpdateNotifier> {
  /// Provider for post update notifier
  PostUpdateNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'postUpdateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$postUpdateNotifierHash();

  @$internal
  @override
  $ProviderElement<PostUpdateNotifier> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PostUpdateNotifier create(Ref ref) {
    return postUpdateNotifier(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostUpdateNotifier value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostUpdateNotifier>(value),
    );
  }
}

String _$postUpdateNotifierHash() =>
    r'b26a1b333a91d7ca44a5f6712629393d6ea53661';

/// Stream of post update state

@ProviderFor(postUpdateState)
final postUpdateStateProvider = PostUpdateStateProvider._();

/// Stream of post update state

final class PostUpdateStateProvider extends $FunctionalProvider<
    AsyncValue<void>,
    AsyncValue<void>,
    AsyncValue<void>> with $Provider<AsyncValue<void>> {
  /// Stream of post update state
  PostUpdateStateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'postUpdateStateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$postUpdateStateHash();

  @$internal
  @override
  $ProviderElement<AsyncValue<void>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AsyncValue<void> create(Ref ref) {
    return postUpdateState(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$postUpdateStateHash() => r'128318e900ff323065834267e844948ea9adce90';

/// Provider for reaction notifier

@ProviderFor(reactionNotifier)
final reactionProvider = ReactionNotifierProvider._();

/// Provider for reaction notifier

final class ReactionNotifierProvider extends $FunctionalProvider<
    ReactionNotifier,
    ReactionNotifier,
    ReactionNotifier> with $Provider<ReactionNotifier> {
  /// Provider for reaction notifier
  ReactionNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'reactionProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$reactionNotifierHash();

  @$internal
  @override
  $ProviderElement<ReactionNotifier> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReactionNotifier create(Ref ref) {
    return reactionNotifier(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReactionNotifier value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReactionNotifier>(value),
    );
  }
}

String _$reactionNotifierHash() => r'82089bf49cb8dd28fa332f32db59bc3568954181';

/// Stream of reaction state

@ProviderFor(reactionState)
final reactionStateProvider = ReactionStateProvider._();

/// Stream of reaction state

final class ReactionStateProvider extends $FunctionalProvider<AsyncValue<void>,
    AsyncValue<void>, AsyncValue<void>> with $Provider<AsyncValue<void>> {
  /// Stream of reaction state
  ReactionStateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'reactionStateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$reactionStateHash();

  @$internal
  @override
  $ProviderElement<AsyncValue<void>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AsyncValue<void> create(Ref ref) {
    return reactionState(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$reactionStateHash() => r'26f3c4d1148ddb58a2097fe4c7dcfa390de96923';

/// Provider for comment notifier

@ProviderFor(commentNotifier)
final commentProvider = CommentNotifierProvider._();

/// Provider for comment notifier

final class CommentNotifierProvider extends $FunctionalProvider<CommentNotifier,
    CommentNotifier, CommentNotifier> with $Provider<CommentNotifier> {
  /// Provider for comment notifier
  CommentNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'commentProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$commentNotifierHash();

  @$internal
  @override
  $ProviderElement<CommentNotifier> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CommentNotifier create(Ref ref) {
    return commentNotifier(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommentNotifier value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommentNotifier>(value),
    );
  }
}

String _$commentNotifierHash() => r'a3c4fdcf94232f02dbb52dc995f0a51b46506e2f';

/// Stream of comment state

@ProviderFor(commentState)
final commentStateProvider = CommentStateProvider._();

/// Stream of comment state

final class CommentStateProvider extends $FunctionalProvider<
    AsyncValue<String?>,
    AsyncValue<String?>,
    AsyncValue<String?>> with $Provider<AsyncValue<String?>> {
  /// Stream of comment state
  CommentStateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'commentStateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$commentStateHash();

  @$internal
  @override
  $ProviderElement<AsyncValue<String?>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AsyncValue<String?> create(Ref ref) {
    return commentState(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<String?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<String?>>(value),
    );
  }
}

String _$commentStateHash() => r'fc18eb56484e024ce924a7f06a53cd8294379a84';

/// Provider to get crew post statistics

@ProviderFor(crewPostStats)
final crewPostStatsProvider = CrewPostStatsFamily._();

/// Provider to get crew post statistics

final class CrewPostStatsProvider extends $FunctionalProvider<
        AsyncValue<Map<String, dynamic>>,
        Map<String, dynamic>,
        FutureOr<Map<String, dynamic>>>
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  /// Provider to get crew post statistics
  CrewPostStatsProvider._(
      {required CrewPostStatsFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'crewPostStatsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$crewPostStatsHash();

  @override
  String toString() {
    return r'crewPostStatsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Map<String, dynamic>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
    final argument = this.argument as String;
    return crewPostStats(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CrewPostStatsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$crewPostStatsHash() => r'a7b55a55eb4b5e09ebbe4446f1b8c2b8c0c28662';

/// Provider to get crew post statistics

final class CrewPostStatsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Map<String, dynamic>>, String> {
  CrewPostStatsFamily._()
      : super(
          retry: null,
          name: r'crewPostStatsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider to get crew post statistics

  CrewPostStatsProvider call(
    String crewId,
  ) =>
      CrewPostStatsProvider._(argument: crewId, from: this);

  @override
  String toString() => r'crewPostStatsProvider';
}

/// Provider to get reaction counts for a post

@ProviderFor(postReactionCounts)
final postReactionCountsProvider = PostReactionCountsFamily._();

/// Provider to get reaction counts for a post

final class PostReactionCountsProvider extends $FunctionalProvider<
        AsyncValue<Map<String, int>>,
        Map<String, int>,
        FutureOr<Map<String, int>>>
    with $FutureModifier<Map<String, int>>, $FutureProvider<Map<String, int>> {
  /// Provider to get reaction counts for a post
  PostReactionCountsProvider._(
      {required PostReactionCountsFamily super.from,
      required (
        String,
        String,
      )
          super.argument})
      : super(
          retry: null,
          name: r'postReactionCountsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$postReactionCountsHash();

  @override
  String toString() {
    return r'postReactionCountsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Map<String, int>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, int>> create(Ref ref) {
    final argument = this.argument as (
      String,
      String,
    );
    return postReactionCounts(
      ref,
      argument.$1,
      argument.$2,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PostReactionCountsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$postReactionCountsHash() =>
    r'639ca44449374950e3d5d34556360fa649a21300';

/// Provider to get reaction counts for a post

final class PostReactionCountsFamily extends $Family
    with
        $FunctionalFamilyOverride<
            FutureOr<Map<String, int>>,
            (
              String,
              String,
            )> {
  PostReactionCountsFamily._()
      : super(
          retry: null,
          name: r'postReactionCountsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider to get reaction counts for a post

  PostReactionCountsProvider call(
    String crewId,
    String postId,
  ) =>
      PostReactionCountsProvider._(argument: (
        crewId,
        postId,
      ), from: this);

  @override
  String toString() => r'postReactionCountsProvider';
}

/// Provider to check if current user has reacted to a post

@ProviderFor(userReactionToPost)
final userReactionToPostProvider = UserReactionToPostFamily._();

/// Provider to check if current user has reacted to a post

final class UserReactionToPostProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Provider to check if current user has reacted to a post
  UserReactionToPostProvider._(
      {required UserReactionToPostFamily super.from,
      required (
        String,
        String,
        String,
      )
          super.argument})
      : super(
          retry: null,
          name: r'userReactionToPostProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userReactionToPostHash();

  @override
  String toString() {
    return r'userReactionToPostProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    final argument = this.argument as (
      String,
      String,
      String,
    );
    return userReactionToPost(
      ref,
      argument.$1,
      argument.$2,
      argument.$3,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UserReactionToPostProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userReactionToPostHash() =>
    r'5073db55049e327e04ae58529427d699b24aee7e';

/// Provider to check if current user has reacted to a post

final class UserReactionToPostFamily extends $Family
    with
        $FunctionalFamilyOverride<
            FutureOr<bool>,
            (
              String,
              String,
              String,
            )> {
  UserReactionToPostFamily._()
      : super(
          retry: null,
          name: r'userReactionToPostProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider to check if current user has reacted to a post

  UserReactionToPostProvider call(
    String crewId,
    String postId,
    String type,
  ) =>
      UserReactionToPostProvider._(argument: (
        crewId,
        postId,
        type,
      ), from: this);

  @override
  String toString() => r'userReactionToPostProvider';
}
