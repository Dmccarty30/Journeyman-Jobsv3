/// Helper utilities for Firebase Storage operations
class FirebaseStorageHelper {
  // TODO: Replace with your actual bucket name if different
  static const String _bucketName = 'journeyman-jobs.firebasestorage.app';
  static const String _logoPath = 'storm_contractors/logos';

  /// Converts a company name to a Firebase Storage download URL
  ///
  /// Example:
  /// ```dart
  /// getLogoUrl("ALLIANCE POWER GROUP")
  /// // Returns: https://firebasestorage.googleapis.com/v0/b/.../alliance_power_group.png?alt=media
  /// ```
  static String getLogoUrl(String companyName) {
    final slug = _slugify(companyName);
    return 'https://firebasestorage.googleapis.com/v0/b/$_bucketName/o/$_logoPath%2F$slug.png?alt=media';
  }

  /// Converts company name to URL-safe slug
  ///
  /// Example: "J.W. DIDADO" → "jw_didado"
  static String _slugify(String name) {
    return name
        .toLowerCase()
        .trim()
        .replaceAll(
            RegExp(r"[.\-'\u0022]+"), '') // Remove periods, hyphens, quotes
        .replaceAll(RegExp(r'\s+'), '_') // Spaces to underscores
        .replaceAll(RegExp(r'[^a-z0-9_]'), ''); // Remove other special chars
  }

  /// Gets just the filename slug (for uploading)
  ///
  /// Example: "ALLIANCE POWER GROUP" → "alliance_power_group.png"
  static String getLogoFileName(String companyName) {
    return '${_slugify(companyName)}.png';
  }
}
