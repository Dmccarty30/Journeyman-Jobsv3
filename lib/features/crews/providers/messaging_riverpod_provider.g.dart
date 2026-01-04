// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messaging_riverpod_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// MessageService provider

@ProviderFor(messageService)
final messageServiceProvider = MessageServiceProvider._();

/// MessageService provider

final class MessageServiceProvider
    extends $FunctionalProvider<MessageService, MessageService, MessageService>
    with $Provider<MessageService> {
  /// MessageService provider
  MessageServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'messageServiceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$messageServiceHash();

  @$internal
  @override
  $ProviderElement<MessageService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MessageService create(Ref ref) {
    return messageService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MessageService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MessageService>(value),
    );
  }
}

String _$messageServiceHash() => r'd0c924722f972d18522e390071877fc71dc7770b';

/// Stream of crew messages for a specific channel

@ProviderFor(crewMessagesStream)
final crewMessagesStreamProvider = CrewMessagesStreamFamily._();

/// Stream of crew messages for a specific channel

final class CrewMessagesStreamProvider extends $FunctionalProvider<
        AsyncValue<List<Message>>, List<Message>, Stream<List<Message>>>
    with $FutureModifier<List<Message>>, $StreamProvider<List<Message>> {
  /// Stream of crew messages for a specific channel
  CrewMessagesStreamProvider._(
      {required CrewMessagesStreamFamily super.from,
      required (
        String,
        String,
      )
          super.argument})
      : super(
          retry: null,
          name: r'crewMessagesStreamProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$crewMessagesStreamHash();

  @override
  String toString() {
    return r'crewMessagesStreamProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<List<Message>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Message>> create(Ref ref) {
    final argument = this.argument as (
      String,
      String,
    );
    return crewMessagesStream(
      ref,
      argument.$1,
      argument.$2,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CrewMessagesStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$crewMessagesStreamHash() =>
    r'ae42be203d53a3c369345ea3e3ee682d98485c9f';

/// Stream of crew messages for a specific channel

final class CrewMessagesStreamFamily extends $Family
    with
        $FunctionalFamilyOverride<
            Stream<List<Message>>,
            (
              String,
              String,
            )> {
  CrewMessagesStreamFamily._()
      : super(
          retry: null,
          name: r'crewMessagesStreamProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Stream of crew messages for a specific channel

  CrewMessagesStreamProvider call(
    String crewId,
    String channelId,
  ) =>
      CrewMessagesStreamProvider._(argument: (
        crewId,
        channelId,
      ), from: this);

  @override
  String toString() => r'crewMessagesStreamProvider';
}

/// Crew messages for a specific channel

@ProviderFor(crewMessages)
final crewMessagesProvider = CrewMessagesFamily._();

/// Crew messages for a specific channel

final class CrewMessagesProvider
    extends $FunctionalProvider<List<Message>, List<Message>, List<Message>>
    with $Provider<List<Message>> {
  /// Crew messages for a specific channel
  CrewMessagesProvider._(
      {required CrewMessagesFamily super.from,
      required (
        String,
        String,
      )
          super.argument})
      : super(
          retry: null,
          name: r'crewMessagesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$crewMessagesHash();

  @override
  String toString() {
    return r'crewMessagesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<List<Message>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Message> create(Ref ref) {
    final argument = this.argument as (
      String,
      String,
    );
    return crewMessages(
      ref,
      argument.$1,
      argument.$2,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Message> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Message>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CrewMessagesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$crewMessagesHash() => r'fac57f817a027e87f067165fb197828a52203730';

/// Crew messages for a specific channel

final class CrewMessagesFamily extends $Family
    with
        $FunctionalFamilyOverride<
            List<Message>,
            (
              String,
              String,
            )> {
  CrewMessagesFamily._()
      : super(
          retry: null,
          name: r'crewMessagesProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Crew messages for a specific channel

  CrewMessagesProvider call(
    String crewId,
    String channelId,
  ) =>
      CrewMessagesProvider._(argument: (
        crewId,
        channelId,
      ), from: this);

  @override
  String toString() => r'crewMessagesProvider';
}

/// Provider to get chat channels for a crew

@ProviderFor(crewChannelsStream)
final crewChannelsStreamProvider = CrewChannelsStreamFamily._();

/// Provider to get chat channels for a crew

final class CrewChannelsStreamProvider extends $FunctionalProvider<
        AsyncValue<List<ChatChannel>>,
        List<ChatChannel>,
        Stream<List<ChatChannel>>>
    with
        $FutureModifier<List<ChatChannel>>,
        $StreamProvider<List<ChatChannel>> {
  /// Provider to get chat channels for a crew
  CrewChannelsStreamProvider._(
      {required CrewChannelsStreamFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'crewChannelsStreamProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$crewChannelsStreamHash();

  @override
  String toString() {
    return r'crewChannelsStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<ChatChannel>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<ChatChannel>> create(Ref ref) {
    final argument = this.argument as String;
    return crewChannelsStream(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CrewChannelsStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$crewChannelsStreamHash() =>
    r'b254e5da67530650ed393c8c82e3c0f47d03690f';

/// Provider to get chat channels for a crew

final class CrewChannelsStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<ChatChannel>>, String> {
  CrewChannelsStreamFamily._()
      : super(
          retry: null,
          name: r'crewChannelsStreamProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider to get chat channels for a crew

  CrewChannelsStreamProvider call(
    String crewId,
  ) =>
      CrewChannelsStreamProvider._(argument: crewId, from: this);

  @override
  String toString() => r'crewChannelsStreamProvider';
}

/// Crew channels

@ProviderFor(crewChannels)
final crewChannelsProvider = CrewChannelsFamily._();

/// Crew channels

final class CrewChannelsProvider extends $FunctionalProvider<List<ChatChannel>,
    List<ChatChannel>, List<ChatChannel>> with $Provider<List<ChatChannel>> {
  /// Crew channels
  CrewChannelsProvider._(
      {required CrewChannelsFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'crewChannelsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$crewChannelsHash();

  @override
  String toString() {
    return r'crewChannelsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<ChatChannel>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<ChatChannel> create(Ref ref) {
    final argument = this.argument as String;
    return crewChannels(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ChatChannel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ChatChannel>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CrewChannelsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$crewChannelsHash() => r'ce37df18c6281c42268741e603d36e03ada93dbf';

/// Crew channels

final class CrewChannelsFamily extends $Family
    with $FunctionalFamilyOverride<List<ChatChannel>, String> {
  CrewChannelsFamily._()
      : super(
          retry: null,
          name: r'crewChannelsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Crew channels

  CrewChannelsProvider call(
    String crewId,
  ) =>
      CrewChannelsProvider._(argument: crewId, from: this);

  @override
  String toString() => r'crewChannelsProvider';
}

/// Provider to get recent messages (last 24 hours) across channels

@ProviderFor(recentMessages)
final recentMessagesProvider = RecentMessagesFamily._();

/// Provider to get recent messages (last 24 hours) across channels

final class RecentMessagesProvider
    extends $FunctionalProvider<List<Message>, List<Message>, List<Message>>
    with $Provider<List<Message>> {
  /// Provider to get recent messages (last 24 hours) across channels
  RecentMessagesProvider._(
      {required RecentMessagesFamily super.from,
      required (
        String,
        String,
      )
          super.argument})
      : super(
          retry: null,
          name: r'recentMessagesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$recentMessagesHash();

  @override
  String toString() {
    return r'recentMessagesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<List<Message>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Message> create(Ref ref) {
    final argument = this.argument as (
      String,
      String,
    );
    return recentMessages(
      ref,
      argument.$1,
      argument.$2,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Message> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Message>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RecentMessagesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$recentMessagesHash() => r'616c33c8f82983b5f528effce8fc03d4d23769fb';

/// Provider to get recent messages (last 24 hours) across channels

final class RecentMessagesFamily extends $Family
    with
        $FunctionalFamilyOverride<
            List<Message>,
            (
              String,
              String,
            )> {
  RecentMessagesFamily._()
      : super(
          retry: null,
          name: r'recentMessagesProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider to get recent messages (last 24 hours) across channels

  RecentMessagesProvider call(
    String crewId,
    String channelId,
  ) =>
      RecentMessagesProvider._(argument: (
        crewId,
        channelId,
      ), from: this);

  @override
  String toString() => r'recentMessagesProvider';
}

/// Provider to get message count for a crew channel

@ProviderFor(messageCount)
final messageCountProvider = MessageCountFamily._();

/// Provider to get message count for a crew channel

final class MessageCountProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// Provider to get message count for a crew channel
  MessageCountProvider._(
      {required MessageCountFamily super.from,
      required (
        String,
        String,
      )
          super.argument})
      : super(
          retry: null,
          name: r'messageCountProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$messageCountHash();

  @override
  String toString() {
    return r'messageCountProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    final argument = this.argument as (
      String,
      String,
    );
    return messageCount(
      ref,
      argument.$1,
      argument.$2,
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
    return other is MessageCountProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$messageCountHash() => r'fb403f11888ce36ba82da761deb4f6019df822bf';

/// Provider to get message count for a crew channel

final class MessageCountFamily extends $Family
    with
        $FunctionalFamilyOverride<
            int,
            (
              String,
              String,
            )> {
  MessageCountFamily._()
      : super(
          retry: null,
          name: r'messageCountProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider to get message count for a crew channel

  MessageCountProvider call(
    String crewId,
    String channelId,
  ) =>
      MessageCountProvider._(argument: (
        crewId,
        channelId,
      ), from: this);

  @override
  String toString() => r'messageCountProvider';
}
