import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:journeyman_jobs/core/core.dart';
import 'package:journeyman_jobs/features/crews/crews.dart';

part 'offline_data_service_provider.g.dart';

@Riverpod(keepAlive: true)
OfflineDataService offlineDataService(Ref ref) {
  final connectivityService = ref.watch(connectivityServiceForOfflineProvider);
  // connectivityService is already the correct type from the provider
  return OfflineDataService(connectivityService);
}
