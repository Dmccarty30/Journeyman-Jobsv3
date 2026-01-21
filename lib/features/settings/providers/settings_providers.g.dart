// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppearanceSettings)
final appearanceSettingsProvider = AppearanceSettingsProvider._();

final class AppearanceSettingsProvider extends $AsyncNotifierProvider<
    AppearanceSettings, AppearanceSettingsModel> {
  AppearanceSettingsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'appearanceSettingsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$appearanceSettingsHash();

  @$internal
  @override
  AppearanceSettings create() => AppearanceSettings();
}

String _$appearanceSettingsHash() =>
    r'fdcaa92533b2753aeaeb4291506122b0746bbb45';

abstract class _$AppearanceSettings
    extends $AsyncNotifier<AppearanceSettingsModel> {
  FutureOr<AppearanceSettingsModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<AppearanceSettingsModel>, AppearanceSettingsModel>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<AppearanceSettingsModel>,
            AppearanceSettingsModel>,
        AsyncValue<AppearanceSettingsModel>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(NotificationSettings)
final notificationSettingsProvider = NotificationSettingsProvider._();

final class NotificationSettingsProvider extends $AsyncNotifierProvider<
    NotificationSettings, NotificationSettingsModel> {
  NotificationSettingsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'notificationSettingsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$notificationSettingsHash();

  @$internal
  @override
  NotificationSettings create() => NotificationSettings();
}

String _$notificationSettingsHash() =>
    r'0eb746aae89f45a8676bf0f18dcc4b0050be2473';

abstract class _$NotificationSettings
    extends $AsyncNotifier<NotificationSettingsModel> {
  FutureOr<NotificationSettingsModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<NotificationSettingsModel>,
        NotificationSettingsModel>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<NotificationSettingsModel>,
            NotificationSettingsModel>,
        AsyncValue<NotificationSettingsModel>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(JobSearchSettings)
final jobSearchSettingsProvider = JobSearchSettingsProvider._();

final class JobSearchSettingsProvider
    extends $AsyncNotifierProvider<JobSearchSettings, JobSearchSettingsModel> {
  JobSearchSettingsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'jobSearchSettingsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$jobSearchSettingsHash();

  @$internal
  @override
  JobSearchSettings create() => JobSearchSettings();
}

String _$jobSearchSettingsHash() => r'fac338a34e28771e434e1395ef4f735f933f7a0f';

abstract class _$JobSearchSettings
    extends $AsyncNotifier<JobSearchSettingsModel> {
  FutureOr<JobSearchSettingsModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<JobSearchSettingsModel>, JobSearchSettingsModel>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<JobSearchSettingsModel>, JobSearchSettingsModel>,
        AsyncValue<JobSearchSettingsModel>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
