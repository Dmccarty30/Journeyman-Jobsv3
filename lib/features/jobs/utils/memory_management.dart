import 'dart:collection';
import '../jobs.dart';

/// A memory-efficient list wrapper that maintains a maximum size
class BoundedJobList extends ListBase<Job> {
  final List<Job> _innerList = [];
  final int maxSize;

  BoundedJobList({this.maxSize = 1000});

  @override
  int get length => _innerList.length;

  @override
  set length(int newLength) => _innerList.length = newLength;

  @override
  Job operator [](int index) => _innerList[index];

  @override
  void operator []=(int index, Job value) => _innerList[index] = value;

  @override
  void add(Job element) {
    if (_innerList.length >= maxSize) {
      // Remove from the beginning (oldest) if we hit max size
      // This presumes we are adding to the end (newest/most relevant)
      _innerList.removeAt(0);
    }
    _innerList.add(element);
  }

  @override
  void addAll(Iterable<Job> iterable) {
    // If adding more than max size, just take the last maxSize items
    if (iterable.length >= maxSize) {
      _innerList.clear();
      _innerList.addAll(iterable.skip(iterable.length - maxSize));
      return;
    }

    // Check if adding will exceed max size
    final overflow = (_innerList.length + iterable.length) - maxSize;
    if (overflow > 0) {
      _innerList.removeRange(0, overflow);
    }
    _innerList.addAll(iterable);
  }

  /// Estimates the memory usage of the list in bytes (very rough approximation)
  int get estimatedMemoryUsage {
    // Rough estimate:
    // Base object overhead ~16 bytes
    // Avreage Job string data ~500 bytes (description, title, company, etc.)
    // Other fields ~100 bytes
    const int bytesPerJob = 616;
    return length * bytesPerJob;
  }

  /// Clears the list and releases memory
  void dispose() {
    clear();
  }
}

/// Helper class to manage virtual list state and calculations
class VirtualJobListState {
  // Config
  final double itemHeight;
  final int bufferCount;

  // State
  int _firstVisibleIndex = 0;
  int _lastVisibleIndex = 0;

  VirtualJobListState({
    this.itemHeight = 120.0,
    this.bufferCount = 5,
  });

  /// Update visible range based on scroll offset and viewport height
  bool updateVisibleRange(
      double scrollOffset, double viewportHeight, int totalItems) {
    final int newFirst = (scrollOffset / itemHeight).floor();
    final int visibleCount = (viewportHeight / itemHeight).ceil();
    final int newLast = newFirst + visibleCount;

    // Apply buffer
    final int bufferedFirst = (newFirst - bufferCount).clamp(0, totalItems);
    final int bufferedLast = (newLast + bufferCount).clamp(0, totalItems);

    if (bufferedFirst != _firstVisibleIndex ||
        bufferedLast != _lastVisibleIndex) {
      _firstVisibleIndex = bufferedFirst;
      _lastVisibleIndex = bufferedLast;
      return true; // Range changed
    }

    return false; // Range unchanged
  }

  /// Check if an index should be rendered
  bool shouldRender(int index) {
    return index >= _firstVisibleIndex && index <= _lastVisibleIndex;
  }

  int get firstVisible => _firstVisibleIndex;
  int get lastVisible => _lastVisibleIndex;

  void dispose() {
    // Cleanup if needed
  }
}
