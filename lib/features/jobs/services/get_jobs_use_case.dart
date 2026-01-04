/// Use case for fetching jobs from the repository.
library;
import '../jobs.dart';

class GetJobsUseCase {
  final JobRepository repository;

  GetJobsUseCase(this.repository);

  Future<List<Job>> call() async {
    return await repository.fetchJobs();
  }
}
