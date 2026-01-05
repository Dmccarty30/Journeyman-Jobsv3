// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_job_preference_query_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userJobFilterCriteria)
final userJobFilterCriteriaProvider = UserJobFilterCriteriaProvider._();

final class UserJobFilterCriteriaProvider extends $FunctionalProvider<
        AsyncValue<JobFilterCriteria>,
        JobFilterCriteria,
        FutureOr<JobFilterCriteria>>
    with
        $FutureModifier<JobFilterCriteria>,
        $FutureProvider<JobFilterCriteria> {
  UserJobFilterCriteriaProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userJobFilterCriteriaProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userJobFilterCriteriaHash();

  @$internal
  @override
  $FutureProviderElement<JobFilterCriteria> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<JobFilterCriteria> create(Ref ref) {
    return userJobFilterCriteria(ref);
  }
}

String _$userJobFilterCriteriaHash() =>
    r'0e3681801678578c910ee7220859e2fe534d6391';

@ProviderFor(userPreferredJobs)
final userPreferredJobsProvider = UserPreferredJobsProvider._();

final class UserPreferredJobsProvider extends $FunctionalProvider<
        AsyncValue<List<Job>>, List<Job>, FutureOr<List<Job>>>
    with $FutureModifier<List<Job>>, $FutureProvider<List<Job>> {
  UserPreferredJobsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userPreferredJobsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userPreferredJobsHash();

  @$internal
  @override
  $FutureProviderElement<List<Job>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Job>> create(Ref ref) {
    return userPreferredJobs(ref);
  }
}

String _$userPreferredJobsHash() => r'4adfafba749f87a995197a1ab1fa4915250fe9ab';
