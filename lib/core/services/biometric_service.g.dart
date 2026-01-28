// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biometric_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(biometricService)
final biometricServiceProvider = BiometricServiceProvider._();

final class BiometricServiceProvider extends $FunctionalProvider<
    BiometricService,
    BiometricService,
    BiometricService> with $Provider<BiometricService> {
  BiometricServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'biometricServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$biometricServiceHash();

  @$internal
  @override
  $ProviderElement<BiometricService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BiometricService create(Ref ref) {
    return biometricService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BiometricService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BiometricService>(value),
    );
  }
}

String _$biometricServiceHash() => r'18210c094d1a72ed9598598ff121847f2a12ad88';
