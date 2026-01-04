import 'package:journeyman_jobs/features/jobs/jobs.dart';

import 'package:journeyman_jobs/core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_ai_model_provider.g.dart';

@Riverpod(keepAlive: true)
LocalModelService localModelService(Ref ref) {
  // This will be a singleton instance available throughout the app.
  return LocalModelService();
}

@riverpod
Future<void> modelInitializer(Ref ref) async {
  // This provider handles the asynchronous initialization of the model.
  // UI can watch this provider to show a loading indicator while the model loads.
  final modelService = ref.watch(localModelServiceProvider);
  await modelService.loadModel();
}
