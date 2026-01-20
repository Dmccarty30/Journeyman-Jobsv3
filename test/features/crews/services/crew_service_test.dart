import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:journeyman_jobs/features/crews/services/crew_service.dart';
import 'package:journeyman_jobs/features/crews/services/job_sharing_service_impl.dart';
import 'package:journeyman_jobs/core/services/offline_data_service.dart';
import 'package:journeyman_jobs/core/services/connectivity_service.dart';
import 'package:journeyman_jobs/features/crews/services/job_matching_service_impl.dart';

// Generate mocks
@GenerateNiceMocks([
  MockSpec<JobSharingService>(),
  MockSpec<OfflineDataService>(),
  MockSpec<ConnectivityService>(),
  MockSpec<JobMatchingService>(),
])
import 'crew_service_test.mocks.dart';

void main() {
  group('CrewService', () {
    late CrewService crewService;
    late MockJobSharingService mockJobSharingService;
    late MockOfflineDataService mockOfflineDataService;
    late MockConnectivityService mockConnectivityService;
    late MockJobMatchingService mockJobMatchingService;

    setUp(() {
      mockJobSharingService = MockJobSharingService();
      mockOfflineDataService = MockOfflineDataService();
      mockConnectivityService = MockConnectivityService();
      mockJobMatchingService = MockJobMatchingService();

      crewService = CrewService(
        jobSharingService: mockJobSharingService,
        offlineDataService: mockOfflineDataService,
        connectivityService: mockConnectivityService,
        jobMatchingService: mockJobMatchingService,
      );
    });

    test('can be instantiated', () {
      expect(crewService, isA<CrewService>());
    });
  });
}
