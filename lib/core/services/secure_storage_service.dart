import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_service.g.dart';

/// Antigravity Kit 2.0 - Secure Token Storage
///
/// Per mobile-design SKILL.md security patterns:
/// - ✅ Uses flutter_secure_storage (Keychain on iOS, EncryptedSharedPreferences on Android)
/// - ❌ NEVER use SharedPreferences for tokens
/// - ❌ NEVER log sensitive data
///
/// This service wraps flutter_secure_storage for secure auth token management.
class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // Auth Token Management
  // ═══════════════════════════════════════════════════════════════════════════

  static const _keyAuthToken = 'auth_token';
  static const _keyRefreshToken = 'refresh_token';
  static const _keyUserId = 'user_id';

  /// Store auth token securely
  Future<void> saveAuthToken(String token) async {
    await _storage.write(key: _keyAuthToken, value: token);
  }

  /// Retrieve auth token
  Future<String?> getAuthToken() async {
    return await _storage.read(key: _keyAuthToken);
  }

  /// Store refresh token securely
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _keyRefreshToken, value: token);
  }

  /// Retrieve refresh token
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _keyRefreshToken);
  }

  /// Store user ID (less sensitive but still protected)
  Future<void> saveUserId(String userId) async {
    await _storage.write(key: _keyUserId, value: userId);
  }

  /// Retrieve user ID
  Future<String?> getUserId() async {
    return await _storage.read(key: _keyUserId);
  }

  /// Check if user is authenticated (has valid tokens)
  Future<bool> isAuthenticated() async {
    final token = await getAuthToken();
    return token != null && token.isNotEmpty;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // Generic Key-Value Operations
  // ═══════════════════════════════════════════════════════════════════════════

  /// Write any sensitive value securely
  Future<void> write({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  /// Read any sensitive value
  Future<String?> read({required String key}) async {
    return await _storage.read(key: key);
  }

  /// Delete a specific key
  Future<void> delete({required String key}) async {
    await _storage.delete(key: key);
  }

  /// Check if a key exists
  Future<bool> containsKey({required String key}) async {
    return await _storage.containsKey(key: key);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // Session Management
  // ═══════════════════════════════════════════════════════════════════════════

  /// Clear all auth-related data (logout)
  Future<void> clearAuthData() async {
    await _storage.delete(key: _keyAuthToken);
    await _storage.delete(key: _keyRefreshToken);
    await _storage.delete(key: _keyUserId);
  }

  /// Clear ALL secure storage (use with caution)
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}

/// Provider for SecureStorageService
///
/// Usage:
/// ```dart
/// final secureStorage = ref.watch(secureStorageServiceProvider);
/// await secureStorage.saveAuthToken(token);
/// ```
@riverpod
SecureStorageService secureStorageService(Ref ref) {
  return SecureStorageService();
}
