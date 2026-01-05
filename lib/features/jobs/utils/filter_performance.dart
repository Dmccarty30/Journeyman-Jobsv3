import 'package:flutter/foundation.dart';

/// Engine to track and analyze filter performance metrics
class FilterPerformanceEngine {
  final Map<String, List<Duration>> _metrics = {};

  /// Start measuring a filter operation
  Stopwatch startMeasure() {
    return Stopwatch()..start();
  }

  /// Stop measuring and record the metric
  void stopMeasure(String filterKey, Stopwatch stopwatch) {
    stopwatch.stop();
    _recordMetric(filterKey, stopwatch.elapsed);
  }

  void _recordMetric(String key, Duration duration) {
    if (!_metrics.containsKey(key)) {
      _metrics[key] = [];
    }
    _metrics[key]!.add(duration);

    // Keep only last 50 samples per key to manage memory
    if (_metrics[key]!.length > 50) {
      _metrics[key]!.removeAt(0);
    }
  }

  /// Get average duration for a specific filter type
  Duration getAverageFilterTime([String? filterKey]) {
    if (filterKey != null) {
      if (!_metrics.containsKey(filterKey) || _metrics[filterKey]!.isEmpty) {
        return Duration.zero;
      }
      return _calculateAverage(_metrics[filterKey]!);
    }

    if (_metrics.isEmpty) return Duration.zero;

    final allDurations = _metrics.values.expand((element) => element).toList();
    if (allDurations.isEmpty) return Duration.zero;

    return _calculateAverage(allDurations);
  }

  Duration _calculateAverage(List<Duration> durations) {
    final totalMicroseconds = durations.fold<int>(
        0, (sum, duration) => sum + duration.inMicroseconds);
    return Duration(microseconds: totalMicroseconds ~/ durations.length);
  }

  /// Clear all metrics
  void clearMetrics() {
    _metrics.clear();
  }

  /// Get detailed report for debugging
  Map<String, String> getPerformanceReport() {
    if (!kDebugMode) return {};

    return _metrics.map((key, durations) {
      final avg = _calculateAverage(durations);
      return MapEntry(
          key, '${avg.inMilliseconds}ms (${durations.length} samples)');
    });
  }
}
