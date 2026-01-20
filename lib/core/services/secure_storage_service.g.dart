// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secure_storage_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for SecureStorageService
///
/// Usage:
/// ```dart
/// final secureStorage = ref.watch(secureStorageServiceProvider);
/// await secureStorage.saveAuthToken(token);
/// ```

@ProviderFor(secureStorageService)
final secureStorageServiceProvider = SecureStorageServiceProvider._();

/// Provider for SecureStorageService
///
/// Usage:
/// ```dart
/// final secureStorage = ref.watch(secureStorageServiceProvider);
/// await secureStorage.saveAuthToken(token);
/// ```

final class SecureStorageServiceProvider extends $FunctionalProvider<
    SecureStorageService,
    SecureStorageService,
    SecureStorageService> with $Provider<SecureStorageService> {
  /// Provider for SecureStorageService
  ///
  /// Usage:
  /// ```dart
  /// final secureStorage = ref.watch(secureStorageServiceProvider);
  /// await secureStorage.saveAuthToken(token);
  /// ```
  SecureStorageServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'secureStorageServiceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$secureStorageServiceHash();

  @$internal
  @override
  $ProviderElement<SecureStorageService> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SecureStorageService create(Ref ref) {
    return secureStorageService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SecureStorageService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SecureStorageService>(value),
    );
  }
}

String _$secureStorageServiceHash() =>
    r'0295e42b0c2763787b4b230961936eabcd0d0877';
